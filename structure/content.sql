-- insert categories

insert into categories (
    category_name
) values (
    'Slavcho'
);

insert into categories (
    category_name
) values (
    'Medical'
);

insert into categories (
    category_name
) values (
    'Educational'
);

insert into categories (
    category_name
) values (
    'Structural'
);

insert into categories (
    category_name
) values (
    'Wellbeing'
);

commit;

-- insert donations

insert into donations (
    campaign_id,
    donator_id,
    donation_sum,
    donation_date
) values (
    1,
    1,
    100,
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
    58,
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
    40,
    sysdate
);

insert into donations (
    campaign_id,
    donator_id,
    donation_sum,
    donation_date
) values (
    4,
    4,
    30,
    sysdate
);

insert into donations (
    campaign_id,
    donator_id,
    donation_sum,
    donation_date
) values (
    1,
    2,
    100,
    sysdate
);

commit;

-- insert donators

insert into donators (
    first_name,
    last_name,
    email
) values (
    'Gricelda',
    'Luebbers',
    'gricelda.luebbers@aaab.com'
);

insert into donators (
    first_name,
    last_name,
    email
) values (
    'Dean',
    'Bollich',
    'dean.bollich@aaac.com'
);

insert into donators (
    first_name,
    last_name,
    email
) values (
    'Milo',
    'Manoni',
    'milo.manoni@aaad.com'
);

insert into donators (
    first_name,
    last_name,
    email
) values (
    'Laurice',
    'Karl',
    'laurice.karl@aaae.com'
);

insert into donators (
    first_name,
    last_name,
    email
) values (
    'August',
    'Rupel',
    'august.rupel@aaaf.com'
);

-- insert campaigns

insert into campaigns (
    campaign_name,
    target_sum,
    current_sum,
    expiry_date,
    expiry_status,
    category_id,
    creator_id
) values (
    'Church restoration',
    100000,
    0,
    sysdate + 400,
    'ACTIVE',
    4,
    1
);

insert into campaigns (
    campaign_name,
    target_sum,
    current_sum,
    expiry_date,
    expiry_status,
    category_id,
    creator_id
) values (
    'Food for the poor',
    200000,
    100,
    sysdate + 356,
    'ACTIVE',
    5,
    2
);

insert into campaigns (
    campaign_name,
    target_sum,
    current_sum,
    expiry_date,
    expiry_status,
    category_id,
    creator_id
) values (
    'University for orphan prodigies',
    300000,
    100,
    sysdate + 100,
    'ACTIVE',
    3,
    3
);

insert into campaigns (
    campaign_name,
    target_sum,
    current_sum,
    expiry_date,
    expiry_status,
    category_id,
    creator_id
) values (
    'Medicines for poor retired people',
    500000,
    5000,
    sysdate + 58,
    'ACTIVE',
    2,
    4
);

insert into campaigns (
    campaign_name,
    target_sum,
    current_sum,
    expiry_date,
    expiry_status,
    category_id,
    creator_id
) values (
    'Apartment for Slavcho',
    1000000,
    0,
    sysdate - 58,
    'EXPIRED',
    1,
    5
);

commit;

-- insert creators

insert into creators (
    first_name,
    last_name,
    email,
    phone,
    address
) values (
    'Gricelda',
    'Luebbers',
    'gricelda.luebbers@aaab.com',
    123456789,
    '545 Hallering Street'
);

insert into creators (
    first_name,
    last_name,
    email,
    phone,
    address
) values (
    'Dean',
    'Bollich',
    'dean.bollich@aaac.com',
    123456789,
    '394 Cantaloube Street'
);

insert into creators (
    first_name,
    last_name,
    email,
    phone,
    address
) values (
    'Milo',
    'Manoni',
    'milo.manoni@aaad.com',
    123456789,
    '622 Trenay Ave'
);

insert into creators (
    first_name,
    last_name,
    email,
    phone,
    address
) values (
    'Laurice',
    'Karl',
    'laurice.karl@aaae.com',
    123456789,
    '417 Vaqueria Street'
);

insert into creators (
    first_name,
    last_name,
    email,
    phone,
    address
) values (
    'Slavcho',
    'Slavcho',
    'slavcho@aaaf.com',
    123456789,
    '268 Eldon Street'
);

commit;
