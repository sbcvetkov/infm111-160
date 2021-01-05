-- get existing donator
DECLARE
    l_donator_id number := 2;
    l_total_sum number;
BEGIN
    l_total_sum := people_ops.f_total_sum_donator(l_donator_id);
    IF l_total_sum IS NOT NULL 
    THEN
        dbms_output.put_line('Total sum donated by donator with ID of ' || l_donator_id || ' is $'|| l_total_sum);
    END IF;
END;

-- get non existing donator
DECLARE
    l_donator_id number := 1232545342;
    l_total_sum number;
BEGIN
    l_total_sum := people_ops.f_total_sum_donator(l_donator_id);
    IF l_total_sum IS NOT NULL 
    THEN
        dbms_output.put_line('Total sum donated by donator with ID of ' || l_donator_id || ' is $'|| l_total_sum);
    END IF;
END;
