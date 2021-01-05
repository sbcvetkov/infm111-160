BEGIN
    -- test regular case - submitting a donation that doesn't reach target_sum
    insert into donations (
        donator_id,
        campaign_id,
        donation_sum,
        donation_date
    ) values (
        1,
        1,
        1,
        sysdate
    );


    -- test edge case - submitting a donation that will collect or will result in higher sum than target_sum (if target_sum = 100000, current_sum = 300)
    insert into donations (
        donator_id,
        campaign_id,
        donation_sum,
        donation_date
    ) values (
        1,
        1,
        99701,
        sysdate
    );
END;
