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
    movie_ID NUMERIC(5) CONSTRAINT movie_id_pk PRIMARY KEY,
    movie_name VARCHAR2(30) NOT NULL, -- ADDED movie_name 
    popularity NUMERIC(3) NOT NULL, --ADDED NOT NULL
    release_date DATE NOT NULL, -- ADDED NOT NULL
    country_of_origin VARCHAR2(250),
    income NUMERIC(4),                                          -- e.g. 3.5m
    production_cost NUMERIC(4),                                 --e.g. 3.5m
    duration NUMERIC(3),                                        --in minutes    
    filming_locations VARCHAR2(1000)
    );





CREATE TABLE genre (
    genre_id NUMERIC(5) CONSTRAINT genre_id_pk PRIMARY KEY,
    genre_name VARCHAR2(20) NOT NULL -- added genrename
    );


CREATE TABLE stars(
    star_id NUMERIC(5) CONSTRAINT star_id_pk PRIMARY KEY,
    star_name VARCHAR2(30) NOT NULL, --ADDED star_name
    birth_date DATE NOT NULL,   -- ADDED NOT NULL                                    
    height NUMERIC(5),                                      
    biography VARCHAR2(500),
    alt_names VARCHAR2(100)
    );

CREATE TABLE industry_person(
    industry_person_id NUMERIC(5) CONSTRAINT industry_person_id_pk PRIMARY KEY,
    birth_date DATE('YYYY-MM-DD') ,  
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
    );

--==========================================
--            STREET FIGHTER
--==========================================


    INSERT INTO movie VALUES (
    1, 'Street Fighter', 479, DATE '2026-10-16',
    'United States', 0, NULL, 163, 'Sydney, Australia'
);

INSERT INTO industry_person VALUES (
    1, NULL, 'Kinusaga, Japan', 'Mini Bio', 'Kitao Sakurai', 'Eric Andre Show'
);

INSERT INTO industry_person VALUES (
    2, NULL, NULL, NULL, 'Dalan Musson', 'Captain America'
);

INSERT INTO industry_person VALUES (
    3, NULL, NULL, NULL, 'Cale Boyter', 'Dune: Part One'
);

INSERT INTO stars VALUES (
    1, 'Jason Momoa', DATE '1979-08-01', 193, 'Enter Bio', NULL
);

INSERT INTO genre VALUES (1, 'Drama');



INSERT INTO director VALUES (1, 'DGA');
INSERT INTO writer VALUES (2, 'Action');
INSERT INTO producer VALUES (3, 'Warner Bros');



INSERT INTO belongs_to VALUES (1, 1);


INSERT INTO acts_in VALUES (1, 1);

INSERT INTO has_credit VALUES (1, 1);
INSERT INTO has_credit VALUES (1, 2);
INSERT INTO has_credit VALUES (1, 3);


INSERT INTO writes VALUES (1, 2);


INSERT INTO cast_by VALUES (1, 1);



INSERT INTO movie_languages VALUES ('English', 1);
INSERT INTO production_companies VALUES ('Warner Bros', 1);

INSERT INTO reviews VALUES (
    1, 85, 'Great action movie', 1
);

INSERT INTO stars_other_works VALUES ('Aquaman', 1);
INSERT INTO relatives VALUES ('Sibling Name', 1);
INSERT INTO stars_photos VALUES ('photo1.jpg', 1);

INSERT INTO industry_person_awards VALUES ('Best Director', 1);

--================================================================
--          AQUAMAN
--==============================================================


    INSERT INTO movie VALUES (
    2, 'Aquaman and the Lost Kingdom', 2362, DATE '2023-12-22',
    'United Kingdom', 40.4,20.5 ,124 , 'London, England'
);

INSERT INTO genre VALUES (2, 'Action');

INSERT INTO belongs_to VALUES (2, 2);

INSERT INTO stars VALUES (
    2,
    'Patrick Wilson',
    DATE '1973-07-03',
    185,
    'Bio placeholder',
    NULL
);

INSERT INTO acts_in VALUES (2, 1); -- Jason Momoa (already exists)
INSERT INTO acts_in VALUES (2, 2); -- Patrick Wilson

INSERT INTO industry_person VALUES (
    4,
    NULL,
    NULL,
    NULL,
    'James Wan',
    'Director'
);

INSERT INTO director VALUES (4, 'DGA');

INSERT INTO has_credit VALUES (2, 4);

INSERT INTO movie_languages VALUES ('English', 2);

INSERT INTO production_companies VALUES ('Warner Bros', 2);

INSERT INTO reviews VALUES (
    2,
    56,
    'Placeholder review',
    2
);



-- =========================
-- Uncharted
-- =========================

INSERT INTO movie VALUES (
    3,
    'Uncharted',
    735,
    DATE '2022-18-02',
    'Spain',
    407,
    120,
    116,
    'Lloret de Mar, Girona, Spain'
);

INSERT INTO genre VALUES (
    3,
    'Adventure'
);

INSERT INTO stars VALUES (
    3,
    'Tom Holland',
    DATE '1996-06-01',
    66,
    'Thomas Stanley Holland was born in Kingston-upon-Thames, Surrey, to Nicola Elizabeth (Frost)...',
    NULL
);

INSERT INTO industry_person VALUES (
    5,
    DATE '1974-31-10',
    'Washington, District of Columbia, USA',
    'Ruben Fleischer was born on October 31, 1974 in Washington, District of Columbia, USA...',
    'Ruben Fleishcer',
    'Directing Zombie Land'
);

INSERT INTO industry_person VALUES (
    6,
    DATE '<1983-01-08>',
    '<birth_place>',
    'Rafe Judkins was born on January 8, 1983 in Salt Lake City, Utah, USA. He is a producer and writer...',
    'Rafe Judkins',
    'Wheel of Time, Uncharted'
);



INSERT INTO director VALUES (
    5,
    '<guild_membership>'
);

INSERT INTO writer VALUES (
    6,
    '<genre_speciality>'
);

-- =========================
-- DEPENDENT TABLES
-- =========================

INSERT INTO movie_languages VALUES (
    'Spanish',
    3
);

INSERT INTO movie_languages VALUES (
    'English',
    3
);

INSERT INTO production_companies VALUES (
    'Columbia Pictures',
    3
);

INSERT INTO production_companies VALUES (
    'Arad Productions',
    3
);

INSERT INTO reviews VALUES (
    <review_id>,
    <review_score>,
    '<review>',
    <movie_ID>
);

-- =========================
-- JUNCTION TABLES
-- =========================

INSERT INTO belongs_to VALUES (
    3,
    3
);

INSERT INTO acts_in VALUES (
    3,
    3
);

INSERT INTO writes VALUES (
    3,
    6
);

INSERT INTO has_credit VALUES (
    3,
    6
);

INSERT INTO has_credit VALUES (
    3,
    5
);

INSERT INTO cast_by VALUES (
    3,
    5
);

INSERT INTO cast_by VALUES (
    3,
    6
);

-- =========================
-- EXTRA RELATION TABLES
-- =========================

INSERT INTO stars_other_works VALUES (
    'Billy Elliot: The Musical',
    3
);

INSERT INTO relatives VALUES (
    'Harry Hollan (sibling)',
    3
);


---------------------------------------------------------------------------

-- =========================
-- BASE TABLES
-- =========================

INSERT INTO movie VALUES (
    <movie_ID>,
    '<movie_name>',
    <popularity>,
    DATE '<YYYY-MM-DD>',
    '<country_of_origin>',
    <income>,
    <production_cost>,
    <duration>,
    '<filming_locations>'
);

INSERT INTO genre VALUES (
    <genre_id>,
    '<genre_name>'
);

INSERT INTO stars VALUES (
    <star_id>,
    '<star_name>',
    DATE '<YYYY-MM-DD>',
    <height>,
    '<biography>',
    '<alt_names>'
);

INSERT INTO industry_person VALUES (
    <industry_person_id>,
    DATE '<YYYY-MM-DD>',
    '<birth_place>',
    '<biography>',
    '<name>',
    '<known_for>'
);

-- =========================
-- SUBTYPE TABLES
-- =========================

INSERT INTO producer VALUES (
    <industry_person_id>,
    '<production_company>'
);

INSERT INTO director VALUES (
    <industry_person_id>,
    '<guild_membership>'
);

INSERT INTO writer VALUES (
    <industry_person_id>,
    '<genre_speciality>'
);

-- =========================
-- DEPENDENT TABLES
-- =========================

INSERT INTO movie_languages VALUES (
    '<language>',
    <movie_ID>
);

INSERT INTO production_companies VALUES (
    '<production_company>',
    <movie_ID>
);

INSERT INTO reviews VALUES (
    <review_id>,
    <review_score>,
    '<review>',
    <movie_ID>
);

-- =========================
-- JUNCTION TABLES
-- =========================

INSERT INTO belongs_to VALUES (
    <genre_id>,
    <movie_ID>
);

INSERT INTO acts_in VALUES (
    <movie_ID>,
    <star_id>
);

INSERT INTO writes VALUES (
    <movie_ID>,
    <industry_person_id>
);

INSERT INTO has_credit VALUES (
    <movie_ID>,
    <industry_person_id>
);

INSERT INTO cast_by VALUES (
    <star_id>,
    <industry_person_id>
);

-- =========================
-- EXTRA RELATION TABLES
-- =========================

INSERT INTO stars_other_works VALUES (
    '<work>',
    <star_id>
);

INSERT INTO relatives VALUES (
    '<relative_name>',
    <star_id>
);

INSERT INTO stars_photos VALUES (
    '<photo_path>',
    <star_id>
);

INSERT INTO industry_person_awards VALUES (
    '<award>',
    <industry_person_id>
);


---------------------------------------------------------

-- =========================
-- BASE TABLES
-- =========================

INSERT INTO movie VALUES (
    <movie_ID>,
    '<movie_name>',
    <popularity>,
    DATE '<YYYY-MM-DD>',
    '<country_of_origin>',
    <income>,
    <production_cost>,
    <duration>,
    '<filming_locations>'
);

INSERT INTO genre VALUES (
    <genre_id>,
    '<genre_name>'
);

INSERT INTO stars VALUES (
    <star_id>,
    '<star_name>',
    DATE '<YYYY-MM-DD>',
    <height>,
    '<biography>',
    '<alt_names>'
);

INSERT INTO industry_person VALUES (
    <industry_person_id>,
    DATE '<YYYY-MM-DD>',
    '<birth_place>',
    '<biography>',
    '<name>',
    '<known_for>'
);

-- =========================
-- SUBTYPE TABLES
-- =========================

INSERT INTO producer VALUES (
    <industry_person_id>,
    '<production_company>'
);

INSERT INTO director VALUES (
    <industry_person_id>,
    '<guild_membership>'
);

INSERT INTO writer VALUES (
    <industry_person_id>,
    '<genre_speciality>'
);

-- =========================
-- DEPENDENT TABLES
-- =========================

INSERT INTO movie_languages VALUES (
    '<language>',
    <movie_ID>
);

INSERT INTO production_companies VALUES (
    '<production_company>',
    <movie_ID>
);

INSERT INTO reviews VALUES (
    <review_id>,
    <review_score>,
    '<review>',
    <movie_ID>
);

-- =========================
-- JUNCTION TABLES
-- =========================

INSERT INTO belongs_to VALUES (
    <genre_id>,
    <movie_ID>
);

INSERT INTO acts_in VALUES (
    <movie_ID>,
    <star_id>
);

INSERT INTO writes VALUES (
    <movie_ID>,
    <industry_person_id>
);

INSERT INTO has_credit VALUES (
    <movie_ID>,
    <industry_person_id>
);

INSERT INTO cast_by VALUES (
    <star_id>,
    <industry_person_id>
);

-- =========================
-- EXTRA RELATION TABLES
-- =========================

INSERT INTO stars_other_works VALUES (
    '<work>',
    <star_id>
);

INSERT INTO relatives VALUES (
    '<relative_name>',
    <star_id>
);

INSERT INTO stars_photos VALUES (
    '<photo_path>',
    <star_id>
);

INSERT INTO industry_person_awards VALUES (
    '<award>',
    <industry_person_id>
);


---------------------------------------------------------

-- =========================
-- BASE TABLES
-- =========================

INSERT INTO movie VALUES (
    <movie_ID>,
    '<movie_name>',
    <popularity>,
    DATE '<YYYY-MM-DD>',
    '<country_of_origin>',
    <income>,
    <production_cost>,
    <duration>,
    '<filming_locations>'
);

INSERT INTO genre VALUES (
    <genre_id>,
    '<genre_name>'
);

INSERT INTO stars VALUES (
    <star_id>,
    '<star_name>',
    DATE '<YYYY-MM-DD>',
    <height>,
    '<biography>',
    '<alt_names>'
);

INSERT INTO industry_person VALUES (
    <industry_person_id>,
    DATE '<YYYY-MM-DD>',
    '<birth_place>',
    '<biography>',
    '<name>',
    '<known_for>'
);

-- =========================
-- SUBTYPE TABLES
-- =========================

INSERT INTO producer VALUES (
    <industry_person_id>,
    '<production_company>'
);

INSERT INTO director VALUES (
    <industry_person_id>,
    '<guild_membership>'
);

INSERT INTO writer VALUES (
    <industry_person_id>,
    '<genre_speciality>'
);

-- =========================
-- DEPENDENT TABLES
-- =========================

INSERT INTO movie_languages VALUES (
    '<language>',
    <movie_ID>
);

INSERT INTO production_companies VALUES (
    '<production_company>',
    <movie_ID>
);

INSERT INTO reviews VALUES (
    <review_id>,
    <review_score>,
    '<review>',
    <movie_ID>
);

-- =========================
-- JUNCTION TABLES
-- =========================

INSERT INTO belongs_to VALUES (
    <genre_id>,
    <movie_ID>
);

INSERT INTO acts_in VALUES (
    <movie_ID>,
    <star_id>
);

INSERT INTO writes VALUES (
    <movie_ID>,
    <industry_person_id>
);

INSERT INTO has_credit VALUES (
    <movie_ID>,
    <industry_person_id>
);

INSERT INTO cast_by VALUES (
    <star_id>,
    <industry_person_id>
);

-- =========================
-- EXTRA RELATION TABLES
-- =========================

INSERT INTO stars_other_works VALUES (
    '<work>',
    <star_id>
);

INSERT INTO relatives VALUES (
    '<relative_name>',
    <star_id>
);

INSERT INTO stars_photos VALUES (
    '<photo_path>',
    <star_id>
);

INSERT INTO industry_person_awards VALUES (
    '<award>',
    <industry_person_id>
);

