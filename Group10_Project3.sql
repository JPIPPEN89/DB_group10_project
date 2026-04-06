-- fixed drop tables because of reverse dependency issues, children first, then parents. 
DROP TABLE has_credit               CASCADE CONSTRAINTS;
DROP TABLE cast_by                  CASCADE CONSTRAINTS;
DROP TABLE acts_in                  CASCADE CONSTRAINTS;
DROP TABLE belongs_to               CASCADE CONSTRAINTS;
DROP TABLE writes                   CASCADE CONSTRAINTS;
DROP TABLE industry_person_awards   CASCADE CONSTRAINTS;
DROP TABLE stars_photos             CASCADE CONSTRAINTS;
DROP TABLE relatives                CASCADE CONSTRAINTS;
DROP TABLE stars_other_works        CASCADE CONSTRAINTS;
DROP TABLE reviews                  CASCADE CONSTRAINTS;
DROP TABLE production_companies     CASCADE CONSTRAINTS;
DROP TABLE movie_languages          CASCADE CONSTRAINTS;
DROP TABLE producer                 CASCADE CONSTRAINTS;
DROP TABLE director                 CASCADE CONSTRAINTS;
DROP TABLE writer                   CASCADE CONSTRAINTS;
DROP TABLE industry_person          CASCADE CONSTRAINTS;
DROP TABLE stars                    CASCADE CONSTRAINTS;
DROP TABLE genre                    CASCADE CONSTRAINTS;
DROP TABLE movie                    CASCADE CONSTRAINTS;


-- create base tables, no foreign keys.

CREATE TABLE movie(
<<<<<<< HEAD
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
=======
	movie_ID NUMERIC(5) CONSTRAINT movie_id_pk PRIMARY KEY,
	popularity NUMERIC(3),
	release_date DATE,
	country_of_origin VARCHAR2(250),
	income NUMERIC(4), 											-- e.g. 3.5m 
	production_cost NUMERIC(4), 								--e.g. 3.5m
	duration NUMERIC(3), 										--in minutes	
	filming_locations VARCHAR2(1000)
	);

CREATE TABLE genre (
	genre_id NUMERIC(5) CONSTRAINT genre_id_pk PRIMARY KEY
	);

CREATE TABLE stars(
	star_id NUMERIC(5) CONSTRAINT star_id_pk PRIMARY KEY,
	birth_date DATE,									
	height NUMERIC(5), 										
	biography VARCHAR2(500),
	alt_names VARCHAR2(100)
>>>>>>> ec0a848 (Thanh - Made to where it match the relational schema on the report document.)
	);

CREATE TABLE industry_person(
	industry_person_id NUMERIC(5) CONSTRAINT industry_person_id_pk PRIMARY KEY,
	birth_date DATE,
	birth_place VARCHAR2(100),
	biography VARCHAR2(500),
	names VARCHAR2(100),
	known_for VARCHAR2(100)
	);


-- Subtype tables 1-1 relationships with industry_person

CREATE TABLE producer(
	industry_person_id NUMERIC(5) CONSTRAINT producer_pk PRIMARY KEY,
	production_company VARCHAR2(100),
	CONSTRAINT producer_industry_person_fk FOREIGN KEY (industry_person_id) REFERENCES industry_person(industry_person_id)
	);

CREATE TABLE director (
<<<<<<< HEAD
    director_id          CHAR(5)      CONSTRAINT director_pk PRIMARY KEY,
    guild_membership    VARCHAR2(100),
	creator_id CHAR(5),

    CONSTRAINT director_creator_fk  FOREIGN KEY (creator_id) REFERENCES creator(creator_id)
);
	
CREATE TABLE writer(
	writer_id CHAR(5) CONSTRAINT writer_id_pk PRIMARY KEY,
	creator CHAR(5) 

	CONSTRAINT writer_creator_fk FOREIGN KEY (creator) REFERENCES creator(creator_id)
=======
    industry_person_id NUMERIC(5) CONSTRAINT director_pk PRIMARY KEY,
    guild_membership VARCHAR2(100),
    CONSTRAINT dir_ind_person_fk FOREIGN KEY (industry_person_id) REFERENCES industry_person(industry_person_id)
	);

CREATE TABLE writer (
    industry_person_id NUMERIC(5) CONSTRAINT writer_pk PRIMARY KEY,
    genre_speciality VARCHAR2(100),
    CONSTRAINT writer_ind_person_fk FOREIGN KEY (industry_person_id) REFERENCES industry_person(industry_person_id)
	);


-- create dependent & junction tables rely on base tables

CREATE TABLE movie_languages(											
	languages VARCHAR2(100),
    movie_ID NUMERIC(5),
    CONSTRAINT movie_lang_pk PRIMARY KEY (languages, movie_ID),
    CONSTRAINT lang_movie_fk FOREIGN KEY (movie_ID) REFERENCES movie(movie_ID)
	);

CREATE TABLE production_companies (
    production_companies VARCHAR2(100),
    movie_ID NUMERIC(5),
    CONSTRAINT prod_comp_pk PRIMARY KEY (production_companies, movie_ID),
    CONSTRAINT comp_movie_fk FOREIGN KEY (movie_ID) REFERENCES movie(movie_ID)
    );

CREATE TABLE reviews(
	review_id NUMERIC(5),
    review_score NUMERIC(3),
    review VARCHAR2(500),
    movie_ID NUMERIC(5),
	CONSTRAINT review_pk PRIMARY KEY (review_id, movie_ID),
    CONSTRAINT review_movie_fk FOREIGN KEY (movie_ID) REFERENCES movie(movie_ID)
	);

CREATE TABLE belongs_to (
    genre_id NUMERIC(5),
    movie_id NUMERIC(5),
    CONSTRAINT belongs_to_pk PRIMARY KEY (genre_id, movie_id),
    CONSTRAINT bt_genre_fk FOREIGN KEY (genre_id) REFERENCES genre(genre_id),
    CONSTRAINT bt_movie_fk FOREIGN KEY (movie_id) REFERENCES movie(movie_ID)
	);

CREATE TABLE acts_in(
	movie_id NUMERIC(5),
    star_id  NUMERIC(5),
    CONSTRAINT acts_in_pk PRIMARY KEY (movie_id, star_id),
    CONSTRAINT acts_movie_fk FOREIGN KEY (movie_id) REFERENCES movie(movie_ID),
    CONSTRAINT acts_star_fk FOREIGN KEY (star_id) REFERENCES stars(star_id)
	);

CREATE TABLE stars_other_works (
    works VARCHAR2(100),
    star_id NUMERIC(5),
    CONSTRAINT other_works_pk PRIMARY KEY (works, star_id),
    CONSTRAINT works_star_fk FOREIGN KEY (star_id) REFERENCES stars(star_id)
	);

CREATE TABLE relatives (
    names VARCHAR2(100),
    star_id NUMERIC(5),
    CONSTRAINT relatives_pk PRIMARY KEY (names, star_id),
    CONSTRAINT rel_star_fk FOREIGN KEY (star_id) REFERENCES stars(star_id)
	);

CREATE TABLE stars_photos (
    photos VARCHAR2(200),
    star_id NUMERIC(5),
    CONSTRAINT photos_pk PRIMARY KEY (photos, star_id),
    CONSTRAINT photo_star_fk FOREIGN KEY (star_id) REFERENCES stars(star_id)
	);

CREATE TABLE industry_person_awards (
    award VARCHAR2(100),
    industry_person_id NUMERIC(5),
    CONSTRAINT awards_pk PRIMARY KEY (award, industry_person_id),
    CONSTRAINT awards_ind_person_fk FOREIGN KEY (industry_person_id) REFERENCES industry_person(industry_person_id)
	);

CREATE TABLE cast_by (
    star_id NUMERIC(5),
    industry_person_id NUMERIC(5),
    CONSTRAINT cast_by_pk PRIMARY KEY (star_id, industry_person_id),
    CONSTRAINT cast_star_fk FOREIGN KEY (star_id) REFERENCES stars(star_id),
    CONSTRAINT cast_ind_person_fk FOREIGN KEY (industry_person_id) REFERENCES industry_person(industry_person_id)
	);

CREATE TABLE writes (
    movie_id NUMERIC(5),
    industry_person_id NUMERIC(5),
    CONSTRAINT writes_pk PRIMARY KEY (movie_id, industry_person_id),
    CONSTRAINT writes_movie_fk FOREIGN KEY (movie_id) REFERENCES movie(movie_ID),
    CONSTRAINT writes_ind_person_fk FOREIGN KEY (industry_person_id) REFERENCES industry_person(industry_person_id)
	);

CREATE TABLE has_credit (
    movie_id NUMERIC(5),
    industry_person_id NUMERIC(5),
    CONSTRAINT has_credit_pk PRIMARY KEY (movie_id, industry_person_id),
    CONSTRAINT hc_movie_fk FOREIGN KEY (movie_id) REFERENCES movie(movie_ID),
    CONSTRAINT hc_ind_person_fk FOREIGN KEY (industry_person_id) REFERENCES industry_person(industry_person_id)
>>>>>>> ec0a848 (Thanh - Made to where it match the relational schema on the report document.)
	);

	

	

