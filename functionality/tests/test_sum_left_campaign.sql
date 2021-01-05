-- call existing campaign
DECLARE
    l_campaign_id number := 2;
    l_sum_left number;
BEGIN
    l_sum_left := campaign_ops.f_sum_left_campaign(l_campaign_id);
    IF l_sum_left IS NOT NULL 
    THEN
        dbms_output.put_line('Total sum for campaign with ID of ' || l_campaign_id || ' is $'|| l_sum_left);
    END IF;
END;

-- call non existing campaign
DECLARE
    l_campaign_id number := 231235245;
    l_sum_left number;
BEGIN
    l_sum_left := campaign_ops.f_sum_left_campaign(l_campaign_id);
    IF l_sum_left IS NOT NULL 
    THEN
        dbms_output.put_line('Total sum for campaign with ID of ' || l_campaign_id || ' is $'|| l_sum_left);
    END IF;
END;
