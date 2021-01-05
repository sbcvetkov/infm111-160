CREATE OR REPLACE function f_total_sum_donator
    ( v_donator_id IN number )
    RETURN number
IS
    l_total_sum number;
    DONATOR_NOT_EXIST exception;
    CURSOR c_donations
    IS
        select count(*)
        from donations
        where donator_id = v_donator_id;
    n_count number;
BEGIN
    open c_donations;
    fetch c_donations into n_count;
    close c_donations;

    if n_count > 0 then
        select sum(donation_sum) into l_total_sum from donations where donator_id = v_donator_id;
        RETURN l_total_sum;
    else
        raise DONATOR_NOT_EXIST;
    end if;
    EXCEPTION
    when DONATOR_NOT_EXIST then
        dbms_output.put_line('Donations with donator with id of '|| v_donator_id ||' do not exist.');
        return null;
END f_total_sum_donator;
/
