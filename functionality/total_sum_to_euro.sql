CREATE OR REPLACE function f_current_sum_to_euro
    ( v_campaign_id IN number )
    RETURN number
IS
    l_current_sum number;
    l_current_sum_euro number;
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
        select current_sum into l_current_sum from campaigns where campaign_id = v_campaign_id;
        l_current_sum_euro := l_current_sum * 0.823003;
        RETURN l_current_sum_euro;
    else
        raise CAMPAIGN_NOT_EXIST;
    end if;
    EXCEPTION
    when CAMPAIGN_NOT_EXIST then
        dbms_output.put_line('Donations for campaign with id of '|| v_campaign_id ||' do not exist.');
        return null;
END f_current_sum_to_euro;
/
