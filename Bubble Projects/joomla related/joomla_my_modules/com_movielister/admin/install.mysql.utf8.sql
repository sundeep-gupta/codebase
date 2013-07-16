CREATE TABLE IF NOT EXISTS `#__movielister_movies` (
    `id` int auto_increment not null,
    `name` varchar(100),
    `director` text,
    `lead1` varchar(50),
    `lead2` varchar(50),
    `lead3` varchar(50),
    `rel_date` datetime,
    `genre` varchar(20),
    `rating` int,
    `duration` text,
    `language` text,
    `reviews` text,

    PRIMARY KEY(`id`)
);

CREATE TABLE IF NOT EXISTS `#__movielister_cinemas` (
    `id` int auto_increment not null,
    `name` varchar(255),
    `screens` text,
    `rating` int,
    `loc_id` int,
    `remarks` text,

    PRIMARY KEY(`id`)
);

CREATE TABLE IF NOT EXISTS `#__movielister` (
    `id` int auto_increment not null,
    `street` varchar(100),
    `locality` varchar(100),
    `remarks` text,
    PRIMARY KEY(`id`)
);


CREATE TABLE IF NOT EXISTS `#__movielister_play` (
       `id` int auto_increment not null,
       `movie_id` int,
       `cinema_id` int,
       `screen` int,
       `from_date` datetime,
       `to_date` datetime,
       `show1` varchar(15),
       `show2` varchar(15),
       `show3` varchar(15),
       `show4` varchar(15),
       `show5` varchar(15),
       PRIMARY KEY (`id`)
);
