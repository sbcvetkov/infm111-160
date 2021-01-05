-- Package specification
CREATE OR REPLACE PACKAGE people_ops
AS
  FUNCTION f_total_sum_donator
  (i_donator_id IN donations.donator_id%TYPE)
  RETURN number;

  FUNCTION f_donations_today
  RETURN number;

  PROCEDURE p_donators_email_delete;

  PROCEDURE p_creators_email_delete;

  PROCEDURE p_pii_data_deletion;

  PROCEDURE p_pii_data_deletion_single
  (i_donator_id IN donators.donator_id%TYPE);

END people_ops;
/

-- Package body definintion
CREATE OR REPLACE PACKAGE BODY people_ops
AS
    FUNCTION f_total_sum_donator
        (i_donator_id IN donations.donator_id%TYPE)
        RETURN number
    IS
        l_total_sum number;
        DONATOR_NOT_EXIST exception;
        CURSOR c_donations
        IS
            select count(*)
            from donations
            where donator_id = i_donator_id;
        n_count number;
    BEGIN
        open c_donations;
        fetch c_donations into n_count;
        close c_donations;

        if n_count > 0 then
            select sum(donation_sum) into l_total_sum from donations where donator_id = i_donator_id;
            RETURN l_total_sum;
        else
            raise DONATOR_NOT_EXIST;
        end if;
        EXCEPTION
        when DONATOR_NOT_EXIST then
            dbms_output.put_line('Donations with donator with id of '|| i_donator_id ||' do not exist.');
            return null;
    END f_total_sum_donator;

    -- function - get number of donations for the day
    FUNCTION f_donations_today
    RETURN number
    IS
        l_today_donations number;
    BEGIN
        select count(*) into l_today_donations from donations where trunc(donation_date) = trunc(sysdate);
        RETURN l_today_donations;
    END f_donations_today;

    -- procedure - delete all entries with invalid emails
    PROCEDURE p_donators_email_delete
    IS
        b_isvalid BOOLEAN;
    BEGIN
    FOR l_donators IN (SELECT email,anonymous FROM donators)
    LOOP
        b_isvalid :=
        REGEXP_LIKE (l_donators.email,
                    '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$');
    IF NOT b_isvalid AND l_donators.anonymous = 'NO'
    THEN
        DELETE FROM donators WHERE email = l_donators.email;
    END IF;
    END LOOP;
    END p_donators_email_delete;

    -- procedure - delete all entries with invalid emails
    PROCEDURE p_creators_email_delete
    IS
        b_isvalid BOOLEAN;
    BEGIN
    FOR l_creators IN (SELECT email FROM creators)
    LOOP
        b_isvalid :=
        REGEXP_LIKE (l_creators.email,
                    '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$');
    IF NOT b_isvalid
    THEN
        DELETE FROM creators WHERE email = l_creators.email;
    END IF;
    END LOOP;
    END p_creators_email_delete;

    -- procedure - obfuscate all rows that have the anonymous flag on
    PROCEDURE p_pii_data_deletion
    IS
    BEGIN
        UPDATE donators
        SET first_name = '', last_name = '', email = ''
        WHERE anonymous = 'YES';
    end p_pii_data_deletion;

    -- procedure - obfuscate only specific donators in case of a PII data deletion request
    PROCEDURE p_pii_data_deletion_single
        (i_donator_id IN donators.donator_id%TYPE)
    IS
        DONATOR_NOT_EXIST exception;
        CURSOR c_donators
        IS
            select count(*)
            from donators
            where donator_id = i_donator_id;
        n_count number;
    BEGIN
        open c_donators;
        fetch c_donators into n_count;
        close c_donators;

        if n_count > 0 then
            UPDATE donators
                SET first_name = '', last_name = '', email = '', anonymous = 'YES'
                WHERE donator_id = i_donator_id;
        else
            raise DONATOR_NOT_EXIST;
        end if;
        EXCEPTION
        when DONATOR_NOT_EXIST then
            dbms_output.put_line('Donator with id of '|| i_donator_id ||' does not exist.');
    END p_pii_data_deletion_single;

END people_ops;
