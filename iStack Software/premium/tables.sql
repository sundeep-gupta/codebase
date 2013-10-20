create table pb_prop_type (
type_id  tinyint(4)  NOT NULL auto_increment,
type     varchar(30) NOT NULL,
sub_type varchar(30) NOT NULL,
PRIMARY KEY (type_id)
);

create table pb_property_status (
status_id tinyint(2) NOT NULL auto_increment,
status_desc varchar(20) NOT NULL,
PRIMARY KEY (status_id)
);


create table pb_internet (
id tinyint(2)           NOT NULL auto_increment,
description varchar(30) NOT NULL,
PRIMARY KEY (id)
);

create table pb_status (
status_id   tinyint(2)  NOT NULL auto_increment,
description varchar(20) NOT NULL,
PRIMARY KEY (status_id)
);

create table pb_furnished (
furnished_id tinyint(2)  NOT NULL auto_increment,
description  varchar(25) NOT NULL,
PRIMARY KEY (furnished_id)
);

create table pb_address_book (
id       int(10)   NOT NULL auto_increment,
f_name   varchar(20) NOT NULL,
l_name   varchar(20) NOT NULL,
address  varchar(50),
email    varchar(50),
phone    bigint NOT NULL,
PRIMARY KEY (id)
);

create table pb_txn_type (
type_id tinyint(2) NOT NULL auto_increment,
description  varchar(20) NOT NULL,
PRIMARY KEY (type_id)
);

create table pb_lift_facility ( 
id           tinyint(2)  NOT NULL auto_increment,
description  varchar(20) NOT NULL,
PRIMARY KEY (id)
);

create table pb_residential (
prop_id   int(5)                       NOT NULL auto_increment,
prop_type tinyint(4)                   NOT NULL,
name      varchar(30)                  ,
address   varchar(60)                  NOT NULL,
status    tinyint(2)                   NOT NULL,
age       tinyint(3)   default '0'     NOT NULL,
bedrooms  tinyint(3)   default '1'     NOT NULL,
b_area    int(7)                       NOT NULL,
c_area    int(7)                       NOT NULL,
cost      int(11)                      NOT NULL,
floor     tinyint(3)   default '0'     NOT NULL,
garden    tinyint(2)   default '0'     NOT NULL,
terrace   tinyint(2)   default '0'     NOT NULL,
balcony   tinyint(2)   default '0'     NOT NULL,
amenities varchar(30)  default NULL,
water     varchar(20),
furnished tinyint(2)                   NOT NULL,
lift      tinyint(2)   default '1'     NOT NULL,
generator boolean      default false NOT NULL,
txn_type  tinyint(2)                   NOT NULL,
details   varchar(100) default NULL,
contact   int(10)                      NOT NULL,
FOREIGN KEY (contact)   REFERENCES pb_address_book(id)        Match Full ON DELETE CASCADE,
FOREIGN KEY (furnished) REFERENCES pb_furnished(furnished_id) Match Full,
FOREIGN KEY (status)    REFERENCES pb_status(status_id)       Match Full,
FOREIGN KEY (prop_type) REFERENCES pb_prop_type(type_id)      Match Full,
FOREIGN KEY (txn_type)  REFERENCES pb_txn_type(type_id)       Match Full,
FOREIGN KEY (lift)      REFERENCES pb_lift_facility(id)       Match Full,
PRIMARY KEY (prop_id)
);

create table pb_commercial (
prop_id       int(5)                     NOT NULL auto_increment,
prop_type     tinyint(4)                 NOT NULL,
name          varchar(30)                ,
address       varchar(60)                NOT NULL,
b_area        int(7)                     NOT NULL,
c_area        int(7)                     NOT NULL,
age           tinyint(3) default '0'     NOT NULL,
cost          int(11)                    NOT NULL,
floor         int(3)     default '0'     NOT NULL,
height        int(3)                     NOT NULL,
frontage      int(5)                     NOT NULL,
mezzanine     int(5)                     NOT NULL,
elec_capacity int(8)                     NOT NULL,
fire_safety   boolean    default false NOT NULL,
internet      tinyint(2) default '1'     NOT NULL,
water         varchar(20),
lift          tinyint(2) default '1'     NOT NULL,
generator     boolean    default false,
gen_capacity  varchar(20),
details       varchar(60),
txn_type      tinyint(2)                 NOT NULL,
contact       int(10)                    NOT NULL,
FOREIGN KEY (contact)   REFERENCES pb_address_book(id)   Match Full,
FOREIGN KEY (prop_type) REFERENCES pb_prop_type(type_id) Match Full,
FOREIGN KEY (internet)  REFERENCES pb_internet(id)       Match Full,
FOREIGN KEY (lift)      REFERENCES pb_lift_facility(id)  Match Full,
FOREIGN KEY (txn_type)  REFERENCES pb_txn_type(type_id)  Match Full,
PRIMARY KEY (prop_id)
	);


insert into pb_status (description) values('Under Construction');
insert into pb_status (description) values('Ready to Use');
insert into pb_status (description) values('Under Renovation');

insert into pb_prop_type (type, sub_type) values('Residential', 'Independent House');
insert into pb_prop_type (type, sub_type) values('Residential', 'Land');
insert into pb_prop_type (type, sub_type) values ('Residential', 'Apartment / Flat');
insert into pb_prop_type (type, sub_type) values ('Residential', 'Farm House');
insert into pb_prop_type (type, sub_type) values ('Residential', 'Bunglaw');
insert into pb_prop_type (type, sub_type) values ('Residential', 'Other');

insert into pb_prop_type (type, sub_type) values ('Commercial','Office');
insert into pb_prop_type (type, sub_type) values ('Commercial','Showroom');
insert into pb_prop_type (type, sub_type) values ('Commercial','Retail');
insert into pb_prop_type (type, sub_type) values ('Commercial','Industrial');
insert into pb_prop_type (type, sub_type) values ('Commercial','Shop');
insert into pb_prop_type (type, sub_type) values ('Commercial','Hotel / Restaurant');
insert into pb_prop_type (type, sub_type) values ('Commercial','Land');
insert into pb_prop_type (type, sub_type) values ('Commercial','Warehouse');
insert into pb_prop_type (type, sub_type) values ('Commercial','IT / ITeS');
insert into pb_prop_type (type, sub_type) values ('Commercial','Other');

insert into pb_internet (description) values ('Not Available');
insert into pb_internet (description) values ('WiFi');
insert into pb_internet (description) values ('Broadband');

insert into pb_furnished (description) values ('Not Furnished');
insert into pb_furnished (description) values ('Partially Furnished');
insert into pb_furnished (description) values ('Fully Furnished');


insert into pb_txn_type (description) values ('Rent');
insert into pb_txn_type (description) values ('Sell');

insert into pb_lift_facility (description) values ('Not Available');
insert into pb_lift_facility (description) values ('With Generator');
insert into pb_lift_facility (description) values ('Without Generator');
