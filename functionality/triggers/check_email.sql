-- check if email is legitimate
-- if the email is legitimate, apply the lower method
-- if it is not raise an exception that suggests it
create or replace trigger t_creators_email_check
    before insert or update
    on creators
    for each row
DECLARE
   e_invalid_email EXCEPTION;
   b_isvalid   BOOLEAN;
BEGIN
   b_isvalid :=
      REGEXP_LIKE (:new.email,
                   '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$');
   IF b_isvalid
   THEN
      :new.email := lower(:new.email);
    ELSE      
        RAISE e_invalid_email;
   END IF;
   EXCEPTION
    WHEN e_invalid_email THEN
       DBMS_OUTPUT.put_line ('The email address you have entered is invalid! -> '||:new.email || '. This entry will be deleted!');
end t_creators_email_check;
/

-- check if email is legitimate
-- if the email is legitimate, apply the lower method
-- if it is not raise an exception that suggests it
create or replace trigger t_donators_email_check
    before insert or update
    on donators
    for each row
DECLARE
   e_invalid_email EXCEPTION;
   e_anonymous EXCEPTION;
   b_isvalid   BOOLEAN;
BEGIN
   b_isvalid :=
      REGEXP_LIKE (:new.email,
                   '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$');
   IF b_isvalid AND :new.anonymous = 'NO'
   THEN
      :new.email := lower(:new.email);
   ELSIF b_isvalid AND :new.anonymous = 'YES'
   THEN
      RAISE e_anonymous;
   ELSIF NOT b_isvalid AND :new.anonymous = 'NO'
   THEN
      RAISE e_invalid_email;
   END IF;
   EXCEPTION
    WHEN e_invalid_email THEN
       DBMS_OUTPUT.put_line ('The email address you have entered is invalid! -> '||:new.email || '. This entry will be deleted!');
    WHEN e_anonymous THEN
       DBMS_OUTPUT.put_line ('The email address you have entered is valid,  but you opted for anonymity! This entry will be automatically deleted!');
end t_donators_email_check;
