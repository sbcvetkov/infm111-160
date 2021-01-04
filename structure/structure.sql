
create table creators (
    creator_id                     number GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1)
                                   constraint creators_creator_id_pk primary key,
    first_name                     varchar2(30) not null,
    last_name                      varchar2(30) not null,
    email                          varchar2(30) not null,
    phone                          number not null,
    address                        varchar2(100) not null
)
;

create table categories (
    category_id                    number GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1)
                                   constraint categories_category_id_pk primary key,
    category_name                  varchar2(20) not null
)
;

create table donators (
    donator_id                     number GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1)
                                   constraint donators_donator_id_pk primary key,
    first_name                     varchar2(30),
    last_name                      varchar2(30),
    email                          varchar2(30),
    anonymous                      varchar2(3) DEFAULT 'NO' constraint donators_anonymous_cc
                                   check (anonymous in ('YES','NO')) not null
)
;

create table campaigns (
    campaign_id                    number GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1)
                                   constraint campaigns_campaign_id_pk primary key,
    campaign_name                  varchar2(50) not null,
    target_sum                     number not null,
    current_sum                    number not null,
    expiry_date                    date not null,
    expiry_status                  varchar2(60) constraint campaigns_expiry_status_cc
                                   check (expiry_status in ('ACTIVE','EXPIRED')) not null,
    category_id                    number
                                   constraint campaigns_category_id_fk
                                   references categories on delete cascade not null,
    creator_id                     number
                                   constraint campaigns_creator_id_fk
                                   references creators on delete cascade not null
)
;

create table donations (
    campaign_id                    number
                                   constraint donations_campaign_id_fk
                                   references campaigns on delete cascade,
    donator_id                     number
                                   constraint donations_donator_id_fk
                                   references donators on delete cascade not null,
    donation_id                    number GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1)
                                   constraint donations_donation_id_pk primary key,
    donation_sum                   number not null,
    donation_date                  date not null,
    anonymous                      varchar2(3) not null
)
;
