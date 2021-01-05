CREATE OR REPLACE function f_total_sum_campaign
    ( v_campaign_id IN number )
    RETURN number
IS
    l_total_sum number;
    CAMPAIGN_NOT_EXIST exception;
    CURSOR c_donations
    IS
        select count(1)
        from donations
        where donator_id = v_campaign_id;
    n_count number;
BEGIN
    open c_donations;
    fetch c_donations into n_count;
    close c_donations;

    if n_count > 0 then
        select sum(donation_sum) into l_total_sum from donations where donator_id = v_campaign_id;
        RETURN l_total_sum;
    else
        raise CAMPAIGN_NOT_EXIST;
    end if;
    EXCEPTION
    when CAMPAIGN_NOT_EXIST then
        dbms_output.put_line('Donations for campaign with id of '|| v_campaign_id ||' do not exist.');
END f_total_sum_campaign;
