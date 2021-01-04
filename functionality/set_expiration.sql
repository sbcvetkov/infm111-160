-- check for dates and set EXPIRED status if needed
CREATE OR REPLACE procedure p_set_expired_status
IS
BEGIN
    UPDATE campaigns
        SET EXPIRY_STATUS = 'EXPIRED'
        WHERE EXPIRY_DATE < trunc(sysdate);
END p_set_expired_status;
/
