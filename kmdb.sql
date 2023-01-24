-- In this assignment, you'll be building the domain model, database 
-- structure, and data for "KMDB" (the Kellogg Movie Database).
-- The end product will be a report that prints the movies and the 
-- top-billed cast for each movie in the database.

-- Requirements/assumptions
--
-- - There will only be three movies in the database – the three films
--   that make up Christopher Nolan's Batman trilogy.
-- - Movie data includes the movie title, year released, MPAA rating,
--   and studio.
-- - There are many studios, and each studio produces many movies, but
--   a movie belongs to a single studio.
-- - An actor can be in multiple movies.
-- - Everything you need to do in this assignment is marked with TODO!

-- User stories
--
-- - As a guest, I want to see a list of movies with the title, year released,
--   MPAA rating, and studio information.
-- - As a guest, I want to see the movies which a single studio has produced.
-- - As a guest, I want to see each movie's cast including each actor's
--   name and the name of the character they portray.
-- - As a guest, I want to see the movies which a single actor has acted in.
-- * Note: The "guest" user role represents the experience prior to logging-in
--   to an app and typically does not have a corresponding database table.


-- Deliverables
-- 
-- There are three deliverables for this assignment, all delivered via
-- this file and submitted via GitHub and Canvas:
-- - A domain model, implemented via CREATE TABLE statements for each
--   model/table. Also, include DROP TABLE IF EXISTS statements for each
--   table, so that each run of this script starts with a blank database.
-- - Insertion of "Batman" sample data into tables.
-- - Selection of data, so that something similar to the sample "report"
--   below can be achieved.

-- Rubric
--
-- 1. Domain model - 6 points
-- - Think about how the domain model needs to reflect the
--   "real world" entities and the relationships with each other. 
--   Hint: It's not just a single table that contains everything in the 
--   expected output. There are multiple real world entities and
--   relationships including at least one many-to-many relationship.
-- 2. Execution of the domain model (CREATE TABLE) - 4 points
-- - Follow best practices for table and column names
-- - Use correct data column types (i.e. TEXT/INTEGER)
-- - Use of the `model_id` naming convention for foreign key columns
-- 3. Insertion of data (INSERT statements) - 4 points
-- - Insert data into all the tables you've created
-- - It actually works, i.e. proper INSERT syntax
-- 4. "The report" (SELECT statements) - 6 points
-- - Write 2 `SELECT` statements to produce something similar to the
--   sample output below - 1 for movies and 1 for cast. You will need
--   to read data from multiple tables in each `SELECT` statement.
--   Formatting does not matter.

-- Submission
-- 
-- - "Use this template" to create a brand-new "hw1" repository in your
--   personal GitHub account, e.g. https://github.com/<USERNAME>/hw1
-- - Do the assignment, committing and syncing often
-- - When done, commit and sync a final time, before submitting the GitHub
--   URL for the finished "hw1" repository as the "Website URL" for the 
--   Homework 1 assignment in Canvas

-- Successful sample output is as shown:

-- Movies
-- ======

-- Batman Begins          2005           PG-13  Warner Bros.
-- The Dark Knight        2008           PG-13  Warner Bros.
-- The Dark Knight Rises  2012           PG-13  Warner Bros.

-- Top Cast
-- ========

-- Batman Begins          Christian Bale        Bruce Wayne
-- Batman Begins          Michael Caine         Alfred
-- Batman Begins          Liam Neeson           Ra's Al Ghul
-- Batman Begins          Katie Holmes          Rachel Dawes
-- Batman Begins          Gary Oldman           Commissioner Gordon
-- The Dark Knight        Christian Bale        Bruce Wayne
-- The Dark Knight        Heath Ledger          Joker
-- The Dark Knight        Aaron Eckhart         Harvey Dent
-- The Dark Knight        Michael Caine         Alfred
-- The Dark Knight        Maggie Gyllenhaal     Rachel Dawes
-- The Dark Knight Rises  Christian Bale        Bruce Wayne
-- The Dark Knight Rises  Gary Oldman           Commissioner Gordon
-- The Dark Knight Rises  Tom Hardy             Bane
-- The Dark Knight Rises  Joseph Gordon-Levitt  John Blake
-- The Dark Knight Rises  Anne Hathaway         Selina Kyle

-- Turns column mode on but headers off
.mode column
.headers off
.width 25 25 25 25

-- Drop existing tables, so you'll start fresh each time this script is run.
-- TODO!
DROP TABLE IF EXISTS Movie;
DROP TABLE IF EXISTS Actor;
DROP TABLE IF EXISTS Studio;
DROP TABLE IF EXISTS Top_Cast;

-- Create new tables, according to your domain model
-- TODO!
CREATE TABLE Movie (
    ID INTEGER PRIMARY KEY,
    Title TEXT,
    Released_Year INTEGER,
    MPAA_Rating TEXT,
    Studio_Id INTEGER 
);

CREATE TABLE Studio (
    ID INTEGER PRIMARY KEY,
    Studio_Name TEXT
);

CREATE TABLE Actor (
    Id INTEGER PRIMARY KEY,
    Actor_Name TEXT 
);

CREATE TABLE Top_Cast (
    Id INTEGER PRIMARY KEY,
    Movie_Id INTEGER,
    Actor_Id INTEGER,
    Character_Name TEXT 
);

-- Insert data into your database that reflects the sample data shown above
-- Use hard-coded foreign key IDs when necessary
-- TODO!
INSERT INTO Movie (
    Id, Title, Released_Year, MPAA_Rating, Studio_Id)
VALUES
(1,"Batman Begins", 2005, "PG-13", 1),
(2, "The Dark Knight", 2008, "PG-13", 1),
(3, "The Dark Knight Rises", 2012, "PG-13", 1);

INSERT INTO Studio (
    Id, Studio_Name)
VALUES
(1,"Warner Bros.");

INSERT INTO Actor (
    Id, Actor_Name)
VALUES
(1,"Christian Bale"),
(2,"Michael Caine"),
(3,"Liam Neeson"),
(4,"Katie Holmes"),
(5,"Gary Oldman"),
(6,"Heath Ledger"),
(7,"Aaron Eckhart"),
(8,"Maggie Gyllenhaal"),
(9,"Tom Hardy"),
(10,"Joseph Gordon-Levitt"),
(11,"Anne Hathaway");

INSERT INTO Top_Cast (
    Id, Movie_Id, Actor_Id, Character_Name)
VALUES
(1,1, 1, "Bruce Wayne"),
(2,1, 2, "Alfred"),
(3,1, 3, "Ra's Al Ghul"),
(4,1, 4, "Rachel Dawes"),
(5,1, 5, "Commissioner Gordon"),

(6,2, 1, "Bruce Wayne"),
(7,2, 6, "Joker"),
(8,2, 7, "Harvey Dent"),
(9,2, 2, "Alfred"),
(10,2, 8, "Rachel Dawes"),

(11,3, 1, "Bruce Wayne"),
(12,3, 5, "Commissioner Gordon"),
(13,3, 9, "Bane"),
(14,3, 10, "John Blake"),
(15,3, 11, "Selina Kyle");


-- Prints a header for the movies output
.print "Movies"
.print "======"
.print ""

-- The SQL statement for the movies output
-- TODO!
SELECT movie.Title, movie.Released_Year, movie.MPAA_Rating, studio.Studio_Name 
FROM movie 
INNER JOIN studio ON movie.Studio_Id=studio.id;

-- Prints a header for the cast output
.print ""
.print "Top Cast"
.print "========"
.print ""


-- The SQL statement for the cast output
-- TODO!
SELECT Movie.Title, Actor.Actor_Name, Top_Cast.Character_Name
FROM Actor
INNER JOIN Top_Cast ON Actor.Id=Top_Cast.Actor_Id
INNER JOIN Movie ON Top_Cast.Movie_Id=Movie.Id;