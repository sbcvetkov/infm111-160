-- procedure - add to campaign_sum when new donation to the same campaign. Add only a part of the donation to fulfil the target_sum
create or replace procedure p_add_donation_to_campaign(v_campaign_id IN number, v_donation_sum IN number)
as
    e_sum_collected exception;
    v_new_sum number;
    l_current_sum number;
    l_new_sum number;
    l_partial_sum number;
    l_target_sum number;
    l_final_sum number;
BEGIN
    SELECT current_sum, target_sum INTO l_current_sum, l_target_sum
    FROM campaigns
    WHERE campaign_id = v_campaign_id;

    l_new_sum := l_current_sum + v_donation_sum;
    IF l_target_sum >= l_new_sum THEN
        UPDATE campaigns
        set current_sum = l_new_sum
        where campaign_id = v_campaign_id;
    ELSE
        l_partial_sum := v_donation_sum - (l_new_sum - l_target_sum);
        l_new_sum := l_partial_sum + l_current_sum;
        UPDATE campaigns
        set current_sum = l_new_sum
        where campaign_id = v_campaign_id;
        RAISE e_sum_collected;
    END IF;
    EXCEPTION
        WHEN e_sum_collected THEN
            dbms_output.put_line('Sum collected! We only assigned ' || l_partial_sum || ' to the campaign.');
end p_add_donation_to_campaign;
/

-- trigger - add to campaign_sum when new donation to the same campaign
create or replace trigger t_add_donation_to_campaign
    before insert or update
    on donations
    for each row
BEGIN
    p_add_donation_to_campaign(:new.campaign_id, :new.donation_sum);
end t_add_donation_to_campaign;
/
