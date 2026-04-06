DROP TABLE has_credit       CASCADE CONSTRAINTS;
DROP TABLE writes           CASCADE CONSTRAINTS;
DROP TABLE cast_by          CASCADE CONSTRAINTS;
DROP TABLE acts_in          CASCADE CONSTRAINTS;
DROP TABLE awards           CASCADE CONSTRAINTS;
DROP TABLE producer         CASCADE CONSTRAINTS;
DROP TABLE director         CASCADE CONSTRAINTS;
DROP TABLE writer           CASCADE CONSTRAINTS;
DROP TABLE photos           CASCADE CONSTRAINTS;
DROP TABLE relatives        CASCADE CONSTRAINTS;
DROP TABLE other_works      CASCADE CONSTRAINTS;
DROP TABLE reviews          CASCADE CONSTRAINTS;
DROP TABLE movie_genre      CASCADE CONSTRAINTS;
DROP TABLE film_locations   CASCADE CONSTRAINTS;
DROP TABLE production_companies CASCADE CONSTRAINTS;
DROP TABLE languages        CASCADE CONSTRAINTS;
DROP TABLE stars            CASCADE CONSTRAINTS;
DROP TABLE creator          CASCADE CONSTRAINTS;
DROP TABLE genre            CASCADE CONSTRAINTS;
DROP TABLE movie            CASCADE CONSTRAINTS;







CREATE TABLE movie(
	movie_ID CHAR(5) CONSTRAINT movie_id_pk PRIMARY KEY,
	popularity NUMERIC(3),  									-- NOT SURE HOW THE POPULARITY RATINGS ARE, GUESSING THEY ARE 1 - 100, NEEDS REVIEW
	production_cost NUMERIC(4), 								--e.g. 3.5m
	profit NUMERIC(4), 											-- e.g. 3.5m
	income NUMERIC(4), 											-- e.g. 3.5m 
	average_rating NUMERIC(2),
	number_of_reviews NUMERIC(6),
	duration NUMERIC(3), 										--in minutes
	release_date DATE NOT NULL,
	country_of_origin VARCHAR2(20)
	);

CREATE TABLE languages(											
	languages VARCHAR2(20),
	movie_ID CHAR(5),
	CONSTRAINT movie_languages_pk PRIMARY KEY(languages, movie_ID),
	CONSTRAINT movie_movie_ID_fk FOREIGN KEY (movie_ID) REFERENCES movie(movie_ID)
	);

CREATE TABLE film_locations(
	filming_locations VARCHAR2(20),								--NEED TO DOUBLE CHECK WHICH IS SUPPOSED TO BE PRIMARY KEY
	movie_ID CHAR(5),
	CONSTRAINT movie_locations_pk PRIMARY KEY(filming_locations, movie_ID),
	CONSTRAINT movie_movie_ID_fk FOREIGN KEY (movie_ID) REFERENCES movie(movie_ID)
	);

CREATE TABLE production_companies(
	production_companies VARCHAR2(20),
	movie_ID CHAR(5)
	);
	
CREATE TABLE reviews(
	review_id CHAR(5) CONSTRAINT review_id_pk PRIMARY KEY,
	review_score NUMERIC(3),									--REVIEW IF 3 is the LENGTH
	review VARCHAR2(500),
	has_reviews NUMERIC(5)										--foreign key referencing movie_id
	);
	
CREATE TABLE genre(
	movie_counts VARCHAR2(20),                                 -- I am not sure what movie counts is
	genre_id CHAR(5) CONSTRAINT genre_id_pk PRIMARY key
	);

CREATE TABLE movie_genre(
	genre_id    CHAR(5),
    movie_id    CHAR(5),
    CONSTRAINT movie_genre_pk PRIMARY KEY (genre_id, movie_id)    -- both are primary keys
	);
	
	
CREATE TABLE stars(
	star_id CHAR(5) CONSTRAINT star_id_pk PRIMARY KEY,
	birth_date DATE,									--mayber there is a date data TYPE
	age NUMERIC(3),
	height NUMERIC(3), 										-- in inches
	known_for VARCHAR2(50)
	);

CREATE TABLE acts_in(
	movie_id    CHAR(5),
    star_id     CHAR(5),
    CONSTRAINT acts_in_pk PRIMARY KEY (movie_id, star_id)
	);
	

	
CREATE TABLE other_works(
	works   VARCHAR2(100),
    star_id CHAR(5),
    CONSTRAINT other_works_pk PRIMARY KEY (works, star_id)
	);
	
CREATE TABLE relatives(
	name    VARCHAR2(50),
    star_id CHAR(5),
    CONSTRAINT relatives_pk PRIMARY KEY (name, star_id)
	);
	
CREATE TABLE photos(
	photo   VARCHAR2(200),
    star_id CHAR(5),
    CONSTRAINT photos_pk PRIMARY KEY (photo, star_id)
	);
	
CREATE TABLE creator(
	birth_place VARCHAR2(20),
	creator_id CHAR(5) CONSTRAINT creator_id_pk PRIMARY KEY,
	biography VARCHAR2(500),
	age NUMERIC(3),
	name VARCHAR2(20),
	known_for VARCHAR2(50)
	);

CREATE TABLE cast_by(
	star_id     CHAR(5),
    creator_id  CHAR(5),
    CONSTRAINT cast_by_pk PRIMARY KEY (star_id, creator_id)
	);
	

	
CREATE TABLE awards(
	award       VARCHAR2(100),
    creator_id  CHAR(5),
    CONSTRAINT awards_pk PRIMARY KEY (award, creator_id)
	);
	
CREATE TABLE producer(
	producer_id CHAR(5) CONSTRAINT producer_id_pk PRIMARY KEY, 
	creator CHAR(5) -- foreign key
	);


CREATE TABLE director (
    director_id          CHAR(5)      CONSTRAINT director_pk PRIMARY KEY,
    guild_membership    VARCHAR2(100),
	creator_id CHAR(5),

    CONSTRAINT director_creator_fk  FOREIGN KEY (creator_id) REFERENCES creator(creator_id)
);
	
CREATE TABLE writer(
	writer_id CHAR(5) CONSTRAINT writer_id_pk PRIMARY KEY,
	creator CHAR(5) 

	CONSTRAINT writer_creator_fk FOREIGN KEY (creator) REFERENCES creator(creator_id)
	);

	

