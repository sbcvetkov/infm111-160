-- procedure - obfuscate all rows that have the anonymous flag on
create or replace procedure p_pii_data_deletion
IS
BEGIN
    UPDATE donators
       SET first_name = '', last_name = '', email = ''
       WHERE anonymous = 'YES';
end p_pii_data_deletion;
/

-- obfuscate only specific donators in case of a PII data deletion request
CREATE OR REPLACE procedure p_pii_data_deletion_single
    ( v_donator_id IN number )
IS
    DONATOR_NOT_EXIST exception;
    CURSOR c_donators
    IS
        select count(*)
        from donators
        where donator_id = v_donator_id;
    n_count number;
BEGIN
    open c_donators;
    fetch c_donators into n_count;
    close c_donators;

    if n_count > 0 then
        UPDATE donators
            SET first_name = '', last_name = '', email = '', anonymous = 'YES'
            WHERE donator_id = v_donator_id;
    else
        raise DONATOR_NOT_EXIST;
    end if;
    EXCEPTION
    when DONATOR_NOT_EXIST then
        dbms_output.put_line('Donator with id of '|| v_donator_id ||' does not exist.');
END p_pii_data_deletion_single;
/
