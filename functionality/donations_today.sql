CREATE OR REPLACE Function f_donations_today
   RETURN number
IS
    l_today_donations number;
BEGIN
    select count(*) into l_today_donations from donations where trunc(donation_date) = trunc(sysdate);
RETURN l_today_donations;
END f_donations_today;
/
