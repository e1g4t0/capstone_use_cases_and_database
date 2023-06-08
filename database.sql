CREATE DATABASE movies;
GRANT ALL PRIVILEGES ON DATABASE movies TO postgres;

CREATE SEQUENCE mv_actors_seq start with 100;

CREATE TABLE actors (
  actor_id bigint NOT NULL DEFAULT nextval('mv_actors_seq'),
  first_name varchar(200) DEFAULT NULL,
  last_name varchar(200) DEFAULT NULL,
  birth_date date DEFAULT NULL,
  rating real DEFAULT NULL,
  country varchar(200) DEFAULT NULL,
  PRIMARY KEY (actor_id)
);

ALTER SEQUENCE mv_actors_seq OWNED BY actors.actor_id;

INSERT INTO actors(actor_id, first_name, last_name, birth_date, rating, country)
VALUES
(1, 'Ricardo', 'Milos', '1977-11-11', 10.0, 'Brazil'),
(2, 'Billy', 'Herrington', '1969-07-14', 9.9, 'USA'),
(3, 'Van', 'Darkholme', '1972-10-24', 9.8, 'Vietnam');

CREATE SEQUENCE mv_movie_seq start with 100;
CREATE SEQUENCE mv_movieactor_seq start with 100;

CREATE TABLE movie (
  movie_id bigint NOT NULL DEFAULT nextval('mv_movie_seq'),
  name varchar(200) DEFAULT NULL,
  rating real DEFAULT NULL,
  release_year date DEFAULT NULL,
  country varchar(200) DEFAULT NULL,
  director varchar(200) DEFAULT NULL,
  description varchar(500) DEFAULT NULL,
  PRIMARY KEY (movie_id)
);

CREATE TABLE movie_actor (
    movie_actor_id bigint NOT NULL DEFAULT nextval('mv_movieactor_seq'),
    movie_id bigint NOT NULL,
    actor_id bigint NOT NULL,
    PRIMARY KEY (movie_actor_id),
    FOREIGN KEY (movie_id) REFERENCES movie(movie_id),
    FOREIGN KEY (actor_id) REFERENCES actors(actor_id)
);

ALTER SEQUENCE mv_movie_seq OWNED BY movie.movie_id;
ALTER SEQUENCE mv_movieactor_seq OWNED BY movie_actor.movie_actor_id;

INSERT INTO movie(movie_id, name, rating, release_year, country, director, description)
VALUES
(1, 'Leather Guys', 9.9, '2000-11-11', 'USA', 'BestDirector', 'Leather guys having leather issues'),
(2, 'Best Flex', 10.0, '2010-11-11', 'Japan', 'The best flexer', 'Ricardo giving his best flex'),
(3, 'Best Gachi', 9.9,'2010-11-11', 'Japan', 'The best flexer', 'Best flex sequel');

INSERT INTO movie_actor(movie_actor_id, movie_id, actor_id)
VALUES
(1, 1, 2),
(2, 1, 3),
(3, 2, 1),
(4, 3, 1);

CREATE SEQUENCE mv_cinema_seq start with 100;
CREATE SEQUENCE mv_hall_seq start with 100;
CREATE SEQUENCE mv_seat_seq start with 100;

CREATE TABLE cinemas (
  cinema_id bigint NOT NULL DEFAULT nextval('mv_cinema_seq'),
  name varchar(200) DEFAULT NULL,
  address varchar(200) DEFAULT NULL,
  telephone varchar(12) DEFAULT NULL,
  PRIMARY KEY (cinema_id)
);

CREATE TABLE halls (
  hall_id bigint NOT NULL DEFAULT nextval('mv_hall_seq'),
  cinema_id bigint NOT NULL,
  hall_colour varchar(20) DEFAULT NULL,
  number_of_seats SMALLINT DEFAULT NULL,
  PRIMARY KEY (hall_id),
  FOREIGN KEY (cinema_id) REFERENCES cinemas(cinema_id)
);

CREATE TABLE seats (
  seat_id bigint NOT NULL DEFAULT nextval('mv_seat_seq'),
  seat_number SMALLINT NOT NULL,
  seat_type varchar(20) DEFAULT NULL,
  hall_id bigint NOT NULL ,
  is_booked boolean DEFAULT NULL,
  PRIMARY KEY (seat_id),
  FOREIGN KEY (hall_id) REFERENCES halls(hall_id)
);

ALTER SEQUENCE mv_cinema_seq OWNED BY cinemas.cinema_id;
ALTER SEQUENCE mv_hall_seq OWNED BY halls.hall_id;
ALTER SEQUENCE mv_seat_seq OWNED BY seats.seat_id;

INSERT INTO cinemas (cinema_id, name, address, telephone)
VALUES
(1, 'Best cinema for best movies', 'Kazakhstan, Almaty c., flex st., 228', '88005553535');

INSERT INTO halls (hall_id, cinema_id, hall_colour, number_of_seats)
VALUES
(1, 1, 'Red', 100),
(2, 1, 'Blue', 200);

INSERT INTO seats (seat_id, seat_number, seat_type, hall_id)
VALUES
(1, 1, 'VIP', 1),
(2, 2, 'Regular', 1),
(3, 3, 'Regular', 1),
(4, 4, 'Regular', 1),
(5, 5, 'VIP', 1),
(7, 7, 'VIP', 1),
(8, 1, 'VIP', 2),
(9, 2, 'VIP', 2),
(10, 3, 'VIP', 2),
(11, 4, 'VIP', 2),
(12, 5, 'Regular', 2),
(13, 6, 'Regular', 2);

CREATE SEQUENCE mv_schedule_seq start with 100;
CREATE SEQUENCE mv_user_seq start with 100;
CREATE SEQUENCE mv_ticket_seq start with 100;

CREATE TABLE movie_schedule (
  schedule_id bigint NOT NULL DEFAULT nextval('mv_schedule_seq'),
  movie_id bigint NOT NULL,
  hall_id bigint NOT NULL,
  movie_date date NOT NULL,
  movie_time time NOT NULL,
  price INTEGER,
  PRIMARY KEY (schedule_id),
  FOREIGN KEY (movie_id) REFERENCES movie(movie_id),
  FOREIGN KEY (hall_id) REFERENCES halls(hall_id)
);

CREATE TABLE users(
  user_id bigint NOT NULL DEFAULT nextval('mv_user_seq'),
  username varchar(200) UNIQUE,
  first_name varchar(200) NOT NULL,
  last_name varchar(200) DEFAULT NULL,
  password varchar(256) NOT NULL,
  role varchar(128) NOT NULL,
  birth_date date DEFAULT NULL,
  telephone varchar(12) DEFAULT NULL,
  email varchar(200) NOT NULL,
  PRIMARY KEY (user_id)
);

CREATE TABLE tickets(
  ticket_id bigint NOT NULL DEFAULT nextval('mv_ticket_seq'),
  user_id bigint NOT NULL,
  schedule_id bigint NOT NULL,
  seat_id bigint NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  FOREIGN KEY (schedule_id) REFERENCES movie_schedule(schedule_id),
  FOREIGN KEY (seat_id) REFERENCES seats(seat_id)
);

ALTER SEQUENCE mv_schedule_seq OWNED BY movie_schedule.schedule_id;
ALTER SEQUENCE mv_user_seq OWNED BY users.user_id;
ALTER SEQUENCE mv_ticket_seq OWNED BY tickets.ticket_id;

INSERT INTO users (user_id, username, first_name, last_name, password, role, birth_date, telephone, email)
VALUES (1, 'admin', 'super', 'user', 'password', 'ADMIN', '1977-11-11', '88005553535', 'ricardo_sxxy@yahoo.com');