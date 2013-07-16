CREATE TABLE IF NOT EXISTS `#__phunshuk_account` (
    `id` int auto_increment not null,
    `balance` int,
    `current_sub_id` int,
    PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `#__phunshuk_menu` (
    `id` int auto_increment not null,
    `name` text,
    `price` int,
    PRIMARY KEY(`id`)
);

CREATE TABLE IF NOT EXISTS `#__phunshuk_subscription` (
    `id` int auto_increment not null,
    `user_id` int,
    `menu_id` int,
    `from_date` date,
    `to_date` date,
    `remarks` text,

    PRIMARY KEY(`id`)
);

CREATE TABLE IF NOT EXISTS `#__phunshuk_delivered` (
    `id` int auto_increment not null,
    `sub_id` varchar(100),
    `date` varchar(100),
    `remarks` text,
    PRIMARY KEY(`id`)
);

