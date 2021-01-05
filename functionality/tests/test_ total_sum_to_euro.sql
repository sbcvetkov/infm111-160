-- pass valid campaign_id
DECLARE
    l_campaign_id number := 1;
    l_total_sum number;
BEGIN
    l_total_sum := campaign_ops.f_current_sum_to_euro(l_campaign_id); 
    IF l_total_sum IS NOT NULL 
    THEN
        dbms_output.put_line('Total sum donated to campaign with ID of ' || l_campaign_id || ' is €'|| l_total_sum);
    END IF;
END;

-- pass non existing campaign_id
DECLARE
    l_campaign_id number := 123534;
    l_total_sum number;
BEGIN
    l_total_sum := campaign_ops.f_current_sum_to_euro(l_campaign_id);
    IF l_total_sum IS NOT NULL 
    THEN
        dbms_output.put_line('Total sum donated to campaign with ID of ' || l_campaign_id || ' is €'|| l_total_sum);
    END IF;
END;
