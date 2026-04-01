DROP TABLE movie CASCADE CONSTRAINTS;
DROP TABLE actor CASCADE CONSTRAINTS;
DROP TABLE creator CASCADE CONSTRAINTS;
DROP TABLE languages CASCADE CONSTRAINTS;
DROP TABLE film_locations CASCADE CONSTRAINTS;
DROP TABLE production_companies CASCADE CONSTRAINTS;






CREATE TABLE movie(
	movie_ID NUMERIC(5) CONSTRAINT movie_id_pk PRIMARY KEY,
	popularity NUMERIC(3),  									-- NOT SURE HOW THE POPULARITY RATINGS ARE, GUESSING THEY ARE 1 - 100, NEEDS REVIEW
	production_cost NUMERIC(4), 								--e.g. 3.5m
	profit NUMERIC(4), 											-- e.g. 3.5m
	income NUMERIC(4), 											-- e.g. 3.5m 
	average_rating NUMERIC(2),
	number_of_reviews NUMERIC(6),
	duration NUMERIC(3), 										--in minutes
	release_date NUMERIC(6),
	country_of_origin VARCHAR2(20)
	);

CREATE TABLE languages(											--NEED TO DOUBLE CHECK WHICH IS SUPPOSED TO BE PRIMARY KEY
	languages VARCHAR2(20),
	movie_ID NUMERIC(5)
	);

CREATE TABLE film_locations(
	filming_locations VARCHAR2(20),								--NEED TO DOUBLE CHECK WHICH IS SUPPOSED TO BE PRIMARY KEY
	movie_ID
	);

CREATE TABLE production_companies(
	production_companies VARCHAR2(20),
	movie_ID
	);
	
CREATE TABLE reviews(
	review_id NUMERIC(5) CONSTRAINT review_id_pk PRIMARY KEY,
	review_score NUMERIC(3),									--REVIEW IF 3 is the LENGTH
	review VARCHAR2(500),
	has_reviews NUMERIC(5)										--foreign key referencing movie_id
	);
	
CREATE TABLE movie_genre(
	genre VARCHAR2(20) CONSTRAINT genre_pk PRIMARY KEY,
	movie VARCHAR2(20) CONSTRAINT moview_pk PRIMARY KEY        -- both are primary keys
	);
	
CREATE TABLE genre(
	movie_counts VARCHAR2(20),                                 -- I am not sure what movie counts is
	genre_id NUMERIC(5) CONSTRAINT genre_id_pk PRIMARY key
	);
	
CREATE TABLE acts_in(
	movie NUMERIC(5) CONSTRAINT movie_pk PRIMARY KEY,
	star NUMERIC(5) CONSTRAINT star_pk PRIMARY KEY
	);
	
CREATE TABLE stars(
	star_id NUMERIC(5) CONSTRAINT star_id_pk PRIMARY KEY,
	birth_date NUMERIC(6),									--mayber there is a date data TYPE
	age NUMERIC(3),
	height NUMERIC(3), 										-- in inches
	known_for VARCHAR2(50),
	);
	
CREATE TABLE other_works(
	works VARCHAR2(20) CONSTRAINT works_pk PRIMARY KEY,
	star NUMERIC(5) CONSTRAINT star_pk PRIMARY key
	);
	
CREATE TABLE relatives(
	name VARCHAR2(20) CONSTRAINT name_pk PRIMARY KEY,
	related_to NUMERIC(5) CONSTRAINT related_to_pk PRIMARY key
	);
	
CREATE TABLE photos(
	photo VARCHAR2(20) CONSTRAINT photo_pk PRIMARY KEY,
	star NUMERIC(5) CONSTRAINT star_pk PRIMARY KEY
	);
	
CREATE TABLE cast_by(
	star NUMERIC(5) CONSTRAINT star_pk PRIMARY KEY,
	creator NUMERIC(5) CONSTRAINT creator_pk PRIMARY key
	);
	
CREATE TABLE creator(
	birth_place VARCHAR2(20),
	creator_id NUMERIC(5) CONSTRAINT creator_id_pk PRIMARY KEY,
	biography VARCHAR2(500),
	age NUMERIC(3),
	name VARCHAR2(20),
	known_for VARCHAR2(50)
	);
	
CREATE TABLE awards(
	award VARCHAR2(20) CONSTRAINT award_pk PRIMARY KEY,
	creator NUMERIC(5) CONSTRAINT creator_pk PRIMARY key
	);
	
CREATE TABLE producer(
	producer_id NUMERIC(5) CONSTRAINT producer_id_pk PRIMARY KEY, 
	creator NUMERIC(5) -- foreign key
	);
	
CREATE TABLE director(
	director_id NUMERIC(5) CONSTRAINT director_id_pk PRIMARY KEY,
	creator NUMERIC(5) -- foreign key
	);
	
CREATE TABLE writer(
	writer_id NUMERIC(5) CONSTRAINT writer_id_pk PRIMARY KEY,
	creator NUMERIC(5) -- foreign key
	);
	
CREATE TABLE director(
	movie_id NUMERIC(5) CONSTRAINT movie_id_pk PRIMARY KEY,
	creator NUMERIC(5) CONSTRAINT creator_id_pk PRIMARY KEY
	);
	