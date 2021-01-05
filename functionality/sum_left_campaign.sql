CREATE OR REPLACE function f_sum_left_campaign
    ( v_campaign_id IN number )
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
        where campaign_id = v_campaign_id;
    n_count number;
BEGIN
    open c_campaign;
    fetch c_campaign into n_count;
    close c_campaign;
    if n_count > 0 then
        select current_sum, target_sum into l_current_sum, l_target_sum from campaigns where campaign_id = v_campaign_id;
        l_sum_left := l_target_sum - l_current_sum;
        RETURN l_sum_left;
    else
        raise CAMPAIGN_NOT_EXIST;
    end if;
    EXCEPTION
    when CAMPAIGN_NOT_EXIST then
        dbms_output.put_line('Campaign with id of '|| v_campaign_id ||' does not exist.');
        return null;
END f_sum_left_campaign;
/
