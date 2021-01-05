-- execute this to purge the invalid entries in Donators and Creators
BEGIN
    -- insert regular entry into donators
    insert into donators (
        first_name,
        last_name,
        email
    ) values (
        'Test',
        'Testov',
        'test.testov@aaaf.com'
    );

    -- insert invalid email entry into donators
    insert into donators (
        first_name,
        last_name,
        email
    ) values (
        'Testolin',
        'Testolinov',
        'testolin'
    );

    -- insert valid email entry with anonymous 'YES' flag into donators and then purge it
    insert into donators (
        first_name,
        last_name,
        email,
        anonymous
    ) values (
        'Testoslav',
        'Testoslavov',
        'testoslav@gmail.com',
        'YES'
    );

    -- insert regular entry into creators
    insert into creators (
        first_name,
        last_name,
        email,
        phone,
        address
    ) values (
        'James',
        'Reacher',
        'james.reacher@aaac.com',
        123456789,
        '394 Cantaloube Street'
    );

    -- insert ivalid email entry into creators and purge it
    insert into creators (
        first_name,
        last_name,
        email,
        phone,
        address
    ) values (
        'Dean',
        'Aldrich',
        'dean.aldrich',
        123456789,
        '394 Cantaloube Street'
    );

    people_ops.p_creators_email_delete;
    people_ops.p_donators_email_delete;
END;
