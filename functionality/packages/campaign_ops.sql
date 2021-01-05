-- Package specification
CREATE OR REPLACE PACKAGE campaign_ops
AS

    FUNCTION f_donations_today
    RETURN number;

    FUNCTION f_sum_left_campaign
    (i_campaign_id IN campaigns.campaign_id%TYPE)
    RETURN number;

    FUNCTION f_current_sum_to_euro
    (i_campaign_id IN campaigns.campaign_id%TYPE)
    RETURN number;

    PROCEDURE p_add_donation_to_campaign
    (i_campaign_id IN campaigns.campaign_id%TYPE,
    i_donation_sum IN donations.donation_sum%TYPE);

    PROCEDURE p_set_expired_status;
END campaign_ops;
/

-- Package body definintion
CREATE OR REPLACE PACKAGE BODY campaign_ops
AS
    -- function - get number of donations for the day
    FUNCTION f_donations_today
    RETURN number
    IS
        l_today_donations number;
    BEGIN
        select count(*) into l_today_donations from donations where trunc(donation_date) = trunc(sysdate);
    RETURN l_today_donations;
    END f_donations_today;

    -- function - get sum left to reach target
    FUNCTION f_sum_left_campaign
        ( i_campaign_id IN campaigns.campaign_id%TYPE )
        RETURN number
    IS
        l_current_sum number;
        l_target_sum number;
        l_sum_left number;
        CAMPAIGN_NOT_EXIST exception;
        CURSOR c_campaign
        IS
            select count(*)
            from campaigns
            where campaign_id = i_campaign_id;
        n_count number;
    BEGIN
        open c_campaign;
        fetch c_campaign into n_count;
        close c_campaign;
        if n_count > 0 then
            select current_sum, target_sum into l_current_sum, l_target_sum from campaigns where campaign_id = i_campaign_id;
            l_sum_left := l_target_sum - l_current_sum;
            RETURN l_sum_left;
        else
            raise CAMPAIGN_NOT_EXIST;
        end if;
        EXCEPTION
        when CAMPAIGN_NOT_EXIST then
            dbms_output.put_line('Campaign with id of '|| i_campaign_id ||' does not exist.');
            return null;
    END f_sum_left_campaign;

    -- function - turn collected sum from USD to EUR
    FUNCTION f_current_sum_to_euro
        ( i_campaign_id IN campaigns.campaign_id%TYPE )
        RETURN number
    IS
        l_current_sum number;
        l_current_sum_euro number;
        CAMPAIGN_NOT_EXIST exception;
        CURSOR c_campaign
        IS
            select count(*)
            from campaigns
            where campaign_id = i_campaign_id;
        n_count number;
    BEGIN
        open c_campaign;
        fetch c_campaign into n_count;
        close c_campaign;

        if n_count > 0 then
            select current_sum into l_current_sum from campaigns where campaign_id = i_campaign_id;
            l_current_sum_euro := l_current_sum * 0.823003;
            RETURN l_current_sum_euro;
        else
            raise CAMPAIGN_NOT_EXIST;
        end if;
        EXCEPTION
        when CAMPAIGN_NOT_EXIST then
            dbms_output.put_line('Donations for campaign with id of '|| i_campaign_id ||' do not exist.');
            return null;
    END f_current_sum_to_euro;

    -- procedure - add donation to campaign
    PROCEDURE p_add_donation_to_campaign
    (i_campaign_id IN campaigns.campaign_id%TYPE, i_donation_sum IN donations.donation_sum%TYPE)
    IS
        e_sum_collected exception;
        l_current_sum number;
        l_new_sum number;
        l_partial_sum number;
        l_target_sum number;
        l_final_sum number;
    BEGIN
        SELECT current_sum, target_sum INTO l_current_sum, l_target_sum
        FROM campaigns
        WHERE campaign_id = i_campaign_id;

        l_new_sum := l_current_sum + i_donation_sum;
        IF l_target_sum >= l_new_sum THEN
            UPDATE campaigns
            set current_sum = l_new_sum
            where campaign_id = i_campaign_id;
        ELSE
            l_partial_sum := i_donation_sum - (l_new_sum - l_target_sum);
            l_new_sum := l_partial_sum + l_current_sum;
            UPDATE campaigns
            set current_sum = l_new_sum
            where campaign_id = i_campaign_id;
            RAISE e_sum_collected;
        END IF;
        EXCEPTION
            WHEN e_sum_collected THEN
                dbms_output.put_line('Sum collected! We only assigned ' || l_partial_sum || ' to the campaign.');
    end p_add_donation_to_campaign;

    -- procedure - set expired status
    PROCEDURE p_set_expired_status
    IS
    BEGIN
        UPDATE campaigns
            SET EXPIRY_STATUS = 'EXPIRED'
            WHERE EXPIRY_DATE < trunc(sysdate);
    END p_set_expired_status;
END campaign_ops;
