

-- fixed drop tables because of reverse dependency issues, children first, then parents.
DROP TABLE has_credit               CASCADE CONSTRAINTS;
DROP TABLE cast_by                  CASCADE CONSTRAINTS;
DROP TABLE acts_in                  CASCADE CONSTRAINTS;
DROP TABLE belongs_to               CASCADE CONSTRAINTS;
DROP TABLE writes                   CASCADE CONSTRAINTS;
DROP TABLE industry_person_awards   CASCADE CONSTRAINTS;
DROP TABLE stars_photos             CASCADE CONSTRAINTS;
DROP TABLE relatives                CASCADE CONSTRAINTS; -- fix actor id 1
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
    popularity NUMERIC(4) NOT NULL, --ADDED NOT NULL
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
    birth_date DATE ,  
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


--            STREET FIGHTER

    INSERT INTO movie VALUES (
    1, 'Street Fighter', 479, DATE '2026-10-16',
    'United States', 0, NULL, 163, 'Sydney, Australia'
);

INSERT INTO industry_person VALUES (
    1, NULL, 
    'Kinusaga, Japan',
     'Kitao Sakurai is a Japanese-American writer and director,', 
     'Kitao Sakurai',
      'Eric Andre Show'
);

INSERT INTO industry_person VALUES (
    2, NULL, NULL, NULL, 'Dalan Musson', 'Captain America'
);

INSERT INTO industry_person VALUES (
    3, NULL, NULL, NULL, 'Cale Boyter', 'Dune: Part One'
);

INSERT INTO stars VALUES (
    1, 'Jason Momoa', 
    DATE '1979-08-01',
     193, 
     'Joseph Jason Namakaeha Momoa was born in Honolulu, Hawaii.
     He is the son of Coni (Lemke), a photographer, and Joseph Momoa, a painter.',
      NULL
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

-----------------------------------------------------------
--          AQUAMAN



   INSERT INTO movie VALUES (
    2, 'Aquaman and the Lost Kingdom', 2362, DATE '2023-12-22',
    'United Kingdom', 40, 20, 124, 'London, England'
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

INSERT INTO acts_in VALUES (2, 1); 
INSERT INTO acts_in VALUES (2, 2); 

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



------------------------------------------------------------------------
-- Uncharted


INSERT INTO movie VALUES (
    3,
    'Uncharted',
    735,
    DATE '2022-02-18', 
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
    DATE '1974-10-31',
    'Washington, District of Columbia, USA',
    'Ruben Fleischer...',
    'Ruben Fleishcer',
    'Directing Zombie Land'
);

INSERT INTO industry_person VALUES (
    6,
    DATE '1983-01-08',
    'Salt Lake City, Utah',
    'Rafe Judkins was born on January 8, 1983 in Salt Lake City, Utah, USA. He is a producer and writer...',
    'Rafe Judkins',
    'Wheel of Time, Uncharted'
);



INSERT INTO director VALUES (
    5,
    'DBA'
);

INSERT INTO writer VALUES (
    6,
    'Adventure'
);


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


INSERT INTO stars_other_works VALUES (
    'Billy Elliot: The Musical',
    3
);

INSERT INTO relatives VALUES (
    'Harry Hollan (sibling)',
    3
);


---------------------------------------------------------------------------
---------------------------------------------------------


-- Zombieland


INSERT INTO movie VALUES (
    4,
    'Zombieland',
    1128,
    DATE '2009-10-02',
    'United States',
    102,
    23,
    88,
    'Atlanta, Georgia, USA'
);

INSERT INTO genre VALUES (
    4,
    'Dark Comedy'
);

INSERT INTO stars VALUES (
    4,
    'Woody Harrelson',
    DATE '1961-06-23',
    69,
    'Academy Award-nominated and Emmy Award-winning 
    actor Woodrow Tracy Harrelson was born on July 23, 1961 in Midland, 
    Texas, to Diane Lou (Oswald) and Charles Harrelson....',
    NULL
);

INSERT INTO industry_person VALUES (
    7,
    DATE '1969-07-23',
    'Phoenix, Arizona, USA',
    'Rhett Reese is an American screenwriter and producer known for writing
     the Deadpool film trilogy starring Ryan Reynolds and Zombieland.',
    'Rhett Reese',
    'Writing'
);

INSERT INTO industry_person VALUES (
    8,
    NULL,
    NULL,
    NULL,
    'Gavin Polone',
    '8mm, Premium Rush'
);


INSERT INTO producer VALUES (
    7,
    'Columbia Pictures'
);

INSERT INTO producer VALUES (
    8,
    'Columbia Pictures'
);


INSERT INTO writer VALUES (
    7,
    'Action'
);


INSERT INTO movie_languages VALUES (
    'English',
    4
);

INSERT INTO production_companies VALUES (
    'Columbia Pictures',
    4
);

INSERT INTO reviews VALUES (
    2,
    5,
    'review...',
    4
);


INSERT INTO belongs_to VALUES (
    4,
    4
);

INSERT INTO acts_in VALUES (
    4,
    4
);

INSERT INTO writes VALUES (
    4,
    7
);

INSERT INTO has_credit VALUES (
    4,
    7
);

INSERT INTO has_credit VALUES (
    4,
    5
);

INSERT INTO has_credit VALUES (
    4,
    8
);

INSERT INTO cast_by VALUES (
    4,
    5
);


INSERT INTO stars_other_works VALUES (
    'True Detective',
    4
);

INSERT INTO stars_other_works VALUES (
    'Natural Born Killers',
    4
);

INSERT INTO relatives VALUES (
    'Denni Montana Harrelson',
    4
);

INSERT INTO relatives VALUES (
    'Diane Lou Harrelson',
    4
);

INSERT INTO stars_photos VALUES (
    'Time Magazine',
    4
);


-------------------------------------------------------------------------
--DEADPOOL

INSERT INTO movie VALUES (
    5,
    'Deadpool',
    509,
    DATE '2016-02-12',
    'United States',
    782,
    58,
    108,
    'Vancouver, British Columbia, Canada'
);


INSERT INTO stars VALUES (
    5,
    'Ryan Reynolds',
    DATE '1976-10-23',
    74,
    'Ryan Rodney Reynolds was born on October 23, 1976 in Vancouver, 
    British Columbia, Canada, the youngest of four children. His father, James Chester Reynolds, was a food wholesaler...',
    'Champ Nightengale'
);

INSERT INTO stars VALUES (
    6,
    'Morrena Baccarin',
    DATE '1979-06-02',
    67,
    'Morena Baccarin was born in Rio de Janeiro, Brazil, to actress Vera Setta and journalist Fernando Baccarin... ',
    NULL
);

INSERT INTO industry_person VALUES (
    9,
    DATE '1964-10-10',
    'Fort Washington, Maryland, USA',
    'Tim Miller is an American animator, film director, creative director 
    and visual effects artist. He was nominated for the Academy Award',
    'Tim Miller',
    'Batman: Arkham Origins'
);

INSERT INTO industry_person VALUES (
    10,
    DATE '1976-10-23',
    'Vancouver, Canada',
    'Ryan Rodney Reynolds was born on October 23, 1976 in Vancouver, 
    British Columbia, Canada, the youngest of four children. His father, James Chester Reynolds, was a food wholesaler...',
    'Ryan Reynolds',
    'Waiting'
);


INSERT INTO producer VALUES (
    10,
    'Twentieth Century Fox'
);

INSERT INTO director VALUES (
    9,
    'DBA'
);


INSERT INTO movie_languages VALUES (
    'English',
    5
);

INSERT INTO production_companies VALUES (
    'Twentieth Century Fox',
    5
);

INSERT INTO production_companies VALUES (
    'Marvel Entertainment',
    5
);

INSERT INTO reviews VALUES (
    3,
    8,
    'reviews',
    5
);

INSERT INTO belongs_to VALUES (
    4,
    5
);

INSERT INTO acts_in VALUES (
    5,
    5
);

INSERT INTO acts_in VALUES (
    5,
    6
);

INSERT INTO writes VALUES (
    5,
    7
);

INSERT INTO has_credit VALUES (
    5,
    10
);

INSERT INTO has_credit VALUES (
    5,
    9
);

INSERT INTO cast_by VALUES (
    6,
    10
);

INSERT INTO stars_other_works VALUES (
    'Waiting',
    5
);

INSERT INTO relatives VALUES (
    'James Reynolds',
    5
);


-----------------------------------------------------------------------------
-- THRASH 

INSERT INTO movie VALUES (
    6,
    'Thrash',
    253, 
    DATE '2026-04-10', 
    'Australia',
    NULL, 
    NULL, 
    86,
    'Docklands Studios, Melbourne, Victoria, Australia'
);


INSERT INTO genre VALUES (6, 'Horror');

INSERT INTO belongs_to VALUES (6, 6);


INSERT INTO stars VALUES (
    7,
    'Phoebe Dynevor',
    DATE '1995-04-17', 
    65, 
    'Phoebe Dynevor is a British actress born in Manchester, England in 1995...',
    NULL
);

INSERT INTO stars VALUES (
    8,
    'Djimon Hounsou',
    DATE '1964-04-24',
    74,
    'Djimon Hounsou was born in Cotonou, Benin, in west Africa to Albertine and Pierre Hounsou, a cook... ',
    NULL
);


INSERT INTO acts_in VALUES (6, 7);
INSERT INTO acts_in VALUES (6, 8);


INSERT INTO industry_person VALUES (
    11,
    DATE '1979-12-06',
    'Alta, Norway',
    'Tommy Wirkola was born on December 6, 1979 in Alta, Norway. He',
    'Tommy Wirkola',
    'Dead Snow 2: Red vs. Dead'
);


INSERT INTO director VALUES (
    11,
    NULL
);


INSERT INTO writer VALUES (
    11,
    'Horror / Thriller'
);


INSERT INTO industry_person VALUES (
    12,
    DATE '1968-04-17',
    'Philadelphia, Pennsylvania',
    'Adam McKay (born April 17, 1968) is an American screenwriter, director, comedian, and actor... ',
    'Adam McKay',
    'Talladega Nights'
);


INSERT INTO producer VALUES (
    12,
    'Hyperobject Industries'
);


INSERT INTO writes VALUES (6, 11);


INSERT INTO has_credit VALUES (6, 11); 
INSERT INTO has_credit VALUES (6, 12); 


INSERT INTO cast_by VALUES (7, 11);
INSERT INTO cast_by VALUES (8, 11);


INSERT INTO movie_languages VALUES ('English', 6);


INSERT INTO production_companies VALUES ('Hyperobject Industries', 6);
INSERT INTO production_companies VALUES ('Sony Pictures Releasing', 6);


INSERT INTO reviews VALUES (
    6,
    51, 
    'mixed audience reception',
    6
);


----------------------------------------------------------------------------------------------------
-- READY OR NOT 2: HERE I COME


INSERT INTO movie VALUES (
    7,
    'Ready or Not 2: Here I Come',
    185,
    DATE '2026-03-20',
    'United States / Canada',
    37.8, 
    17.0,  
    108,
    'Toronto, Ontario, Canada'
);




INSERT INTO belongs_to VALUES (6, 7);


INSERT INTO stars VALUES (
    9,
    'Samara Weaving',
    DATE '1992-02-23',
    65,
    'Samara Weaving was born on February 23, 1992 in Adelaide, South Australia, Australia...',
    NULL
);

INSERT INTO stars VALUES (
    10,
    'Kathryn Newton',
    DATE '1997-02-08',
    65,
    'Kathryn co-starred as Cassie Lang in Ant-Man and the Wasp: Quantumania 2023, followed by Lisa Frankenstein...',
    NULL
);


INSERT INTO acts_in VALUES (7, 9);
INSERT INTO acts_in VALUES (7, 10);


INSERT INTO industry_person VALUES (
    13,
    NULL,
    'Oakland, California',
    'Matt Bettinelli-Olpin was born in Oakland, California, USA. Matt is a director and writer...',
    'Matt Bettinelli-Olpin',
    'Scream VI'
);

INSERT INTO industry_person VALUES (
    14,
    DATE '1982-03-06',
    'Flagstaff, Arizona',
    'Tyler Gillett was born on March 6, 1982 in Flagstaff, Arizona, USA. He is a director...',
    'Tyler Gillett',
    'V/H/S'
);


INSERT INTO director VALUES (13, NULL);
INSERT INTO director VALUES (14, NULL);


INSERT INTO industry_person VALUES (
    15,
    DATE '1975-11-01',
    'Grand Island, Nebraska',
    'Guy Busick was born on November 1, 1975 in Grand Island, Nebraska, USA. He is a writer and producer...',
    'Guy Busick',
    'Scream'
);


INSERT INTO writer VALUES (
    15,
    'Horror / Thriller'
);


INSERT INTO writes VALUES (7, 15);


INSERT INTO has_credit VALUES (7, 13); -- director
INSERT INTO has_credit VALUES (7, 14); -- director
INSERT INTO has_credit VALUES (7, 15); -- writer



INSERT INTO cast_by VALUES (9, 13);
INSERT INTO cast_by VALUES (10, 13);


INSERT INTO movie_languages VALUES ('English', 7);


INSERT INTO production_companies VALUES ('Mythology Entertainment', 7);
INSERT INTO production_companies VALUES ('Ontario Creates', 7);


INSERT INTO reviews VALUES (
    7,
    68,
    'Mixed to positive reception based on IMDb user reviews',
    7
);


---------------------------------------------------------

-- ANACONDA 


INSERT INTO movie VALUES (
    8,
    'Anaconda',
    556,
    DATE '2025-12-25',
    'United States',
    135, 
    45,  
    99,
    'Village Roadshow Studios, Queensland, Australia'
);



INSERT INTO belongs_to VALUES (3, 8);


INSERT INTO stars VALUES (
    11,
    'Jack Black',
    DATE '1969-08-28',
    66,
    'Thomas Jacob "Jack" Black was born on August 28, 1969 in Santa Monica, California and raised in Hermosa Beach, California',
    'JB'
);

INSERT INTO stars VALUES (
    12,
    'Paul Rudd',
    DATE '1969-04-06',
    69,
    'Paul Stephen Rudd was born in Passaic, New Jersey. His parents, Michael and Gloria, both from Jewish families...',
    NULL
);

INSERT INTO acts_in VALUES (8, 11);
INSERT INTO acts_in VALUES (8, 12);


INSERT INTO industry_person VALUES (
    21,
    DATE '1980-04-02',
    'Boston, Massachusetts',
    'Director and writer known for comedy films',
    'Tom Gormican',
    'The Unbearable Weight of Massive Talent'
);


INSERT INTO director VALUES (
    21,
    'DBA'
);


INSERT INTO industry_person VALUES (
    22,
    Null,
    NULL,
    NULL,
    'Kevin Etten',
    'The Unbearable Weight of Massive Talent'
);


INSERT INTO writer VALUES (
    22,
    'Comedy / Adventure'
);


INSERT INTO writes VALUES (8, 22);


INSERT INTO has_credit VALUES (8, 21); 
INSERT INTO has_credit VALUES (8, 22); 


INSERT INTO cast_by VALUES (11, 21);
INSERT INTO cast_by VALUES (12, 21);


INSERT INTO movie_languages VALUES ('English', 8);
INSERT INTO movie_languages VALUES ('Portuguese', 8);


INSERT INTO production_companies VALUES ('Columbia Pictures', 8);

-- REVIEW
INSERT INTO reviews VALUES (
    8,
    56,
    'Mixed reviews, generally considered fun but flawed',
    8
);

-----------------------------------------
-- PROJECT HAIL MARY 



INSERT INTO movie VALUES (
    9,
    'Project Hail Mary',
    240,
    DATE '2026-03-20',
    'United States',
    533, 
    200, 
    156,
    'South Parade Pier, Portsmouth, England'
);


INSERT INTO genre VALUES (9, 'Sci-Fi');


INSERT INTO belongs_to VALUES (9, 9);


INSERT INTO stars VALUES (
    13,
    'Ryan Gosling',
    DATE '1980-11-12',
    72,
    'Born Ryan Thomas Gosling in London, Ontario, Canada, 
    he is the son of Donna (Wilson), a secretary, and Thomas Ray Gosling, a traveling salesman...',
    'Ry'
);

INSERT INTO stars VALUES (
    14,
    'Sandra Hüller',
    DATE '1978-04-30',
    68,
    'Sandra Hüller was born in Suhl. She studied acting at the Ernst Busch Academy of Dramatic Arts in Berlin...',
    NULL
);


INSERT INTO acts_in VALUES (9, 13);
INSERT INTO acts_in VALUES (9, 14);


INSERT INTO industry_person VALUES (
    17,
    DATE '1975-07-12',
    'Miami, Florida',
    'Director known for The Lego Movie and 21 Jump Street',
    'Phil Lord',
    'The Lego Movie'
);

-- DIRECTOR subtype
INSERT INTO director VALUES (
    17,
    NULL
);

-- INDUSTRY PERSON (ONE WRITER ONLY)
INSERT INTO industry_person VALUES (
    18,
    DATE '1975-02-24',
    'United States',
    'Drew Goddard was raised in Los Alamos, New Mexico. 
    He attended Los Alamos High School in Los Alamos, New Mexico and graduated in 1993',
    'Drew Goddard',
    'The Martian'
);

-- WRITER subtype
INSERT INTO writer VALUES (
    18,
    'Sci-Fi'
);

-- WRITES
INSERT INTO writes VALUES (9, 18);

-- HAS_CREDIT
INSERT INTO has_credit VALUES (9, 17);
INSERT INTO has_credit VALUES (9, 18);

-- CAST_BY
INSERT INTO cast_by VALUES (13, 17);
INSERT INTO cast_by VALUES (14, 17);

-- LANGUAGES
INSERT INTO movie_languages VALUES ('English', 9);

-- PRODUCTION COMPANIES (minimal)
INSERT INTO production_companies VALUES ('Amazon MGM Studios', 9);

-- REVIEW
INSERT INTO reviews VALUES (
    9,
    84,
    'Highly rated sci-fi film with strong emotional storytelling',
    9
);

INSERT INTO industry_person_awards VALUES ('Best Director', 17);

-----------------------------------------
-- THE DRAMA 


-- BASE TABLE
INSERT INTO movie VALUES (
    10,
    'The Drama',
    256,
    DATE '2026-04-03',
    'United States',
    57,  
    28,  
    105,
    'Boston, Massachusetts, USA'
);


INSERT INTO belongs_to VALUES (1, 10);


INSERT INTO stars VALUES (
    15,
    'Zendaya',
    DATE '1996-09-01',
    70,
    'Zendaya (which means "to give thanks" in the language of Shona)
     is an American actress and singer born in Oakland, California...',
    NULL
);

INSERT INTO stars VALUES (
    16,
    'Robert Pattinson',
    DATE '1986-05-13',
    73,
    'Robert Douglas Thomas Pattinson was born May 13, 1986 in London, England, 
    to Richard Pattinson, a car dealer importing vintage cars, and Clare Pattinson',
    NULL
);


INSERT INTO acts_in VALUES (10, 15);
INSERT INTO acts_in VALUES (10, 16);


INSERT INTO industry_person VALUES (
    19,
    NULL,
    'Norway',
    'Kristoffer Borgli was born in 1985 in Oslo, Norway.',
    'Kristoffer Borgli',
    'Dream Scenario'
);

-- DIRECTOR subtype
INSERT INTO director VALUES (
    19,
    NULL
);

-- WRITER subtype
INSERT INTO writer VALUES (
    19,
    'Drama / Dark Comedy'
);


INSERT INTO industry_person VALUES (
    20,
    DATE '1986-07-15',
    'New York City, New York',
    'Ari Aster is an American film director, screenwriter, and producer.',
    'Ari Aster',
    'Hereditary'
);

INSERT INTO producer VALUES (
    20,
    'Square Peg'
);


INSERT INTO writes VALUES (10, 19);


INSERT INTO has_credit VALUES (10, 19);
INSERT INTO has_credit VALUES (10, 20);


INSERT INTO cast_by VALUES (15, 19);
INSERT INTO cast_by VALUES (16, 19);


INSERT INTO movie_languages VALUES ('English', 10);


INSERT INTO production_companies VALUES ('A24', 10);
INSERT INTO production_companies VALUES ('Square Peg', 10);


INSERT INTO reviews VALUES (
    10,
    75,
    'Strong performances and emotionally intense storytelling',
    10
);

INSERT INTO stars_other_works VALUES (
    'Euphoria',
    15
);

INSERT INTO stars_other_works VALUES (
    'The Batman',
    16
);


INSERT INTO stars_photos VALUES (
    'zendaya_photo.jpg',
    15
);

INSERT INTO stars_photos VALUES (
    'pattinson_photo.jpg',
    16
);


