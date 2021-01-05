DECLARE
    l_campaign_id number := 2;
BEGIN
    dbms_output.put_line('Total sum for campaign with ID of ' || l_campaign_id || ' is $'|| f_sum_left_campaign(l_campaign_id));
END;
