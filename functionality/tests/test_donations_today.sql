-- insert donations and get number of donations for the day
BEGIN
    insert into donations (
        campaign_id,
        donator_id,
        donation_sum,
        donation_date
    ) values (
        2,
        1,
        30,
        sysdate
    );

    insert into donations (
        campaign_id,
        donator_id,
        donation_sum,
        donation_date
    ) values (
        2,
        2,
        300,
        sysdate
    );

    insert into donations (
        campaign_id,
        donator_id,
        donation_sum,
        donation_date
    ) values (
        3,
        3,
        3000,
        sysdate
    );

  dbms_output.put_line('Total number of donations for today -> ' || campaign_ops.f_donations_today );
END;
