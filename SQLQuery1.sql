CREATE DATABASE task1
CREATE TABLE Actor (
    act_id      INT PRIMARY KEY,
    act_fname   VARCHAR(20),
    act_lname   VARCHAR(20),
    act_gender  CHAR(1)
);
CREATE TABLE Director (
    dir_id      INT PRIMARY KEY,
    dir_fname   VARCHAR(20),
    dir_lname   VARCHAR(20)
);
CREATE TABLE Movie (
    mov_id          INT PRIMARY KEY,
    mov_title       VARCHAR(50),
    mov_year        INT,
    mov_time        INT,
    mov_lang        VARCHAR(50),
    mov_dt_rel      DATE,
    mov_rel_country CHAR(5)
);

CREATE TABLE Reviewer (
    rev_id    INT PRIMARY KEY,
    rev_name  VARCHAR(30)
);

CREATE TABLE Genres (
    gen_id     INT PRIMARY KEY,
    gen_title  VARCHAR(20)
);

CREATE TABLE Movie_Cast (
    act_id  INT,
    mov_id  INT,
    role    VARCHAR(30),
    PRIMARY KEY (act_id, mov_id),
    FOREIGN KEY (act_id) REFERENCES Actor(act_id),
    FOREIGN KEY (mov_id) REFERENCES Movie(mov_id)
);


CREATE TABLE Movie_Direction (
    dir_id  INT,
    mov_id  INT,
    PRIMARY KEY (dir_id, mov_id),
    FOREIGN KEY (dir_id) REFERENCES Director(dir_id),
    FOREIGN KEY (mov_id) REFERENCES Movie(mov_id)
);


CREATE TABLE Movie_Genres (
    mov_id  INT,
    gen_id  INT,
    PRIMARY KEY (mov_id, gen_id),
    FOREIGN KEY (mov_id) REFERENCES Movie(mov_id),
    FOREIGN KEY (gen_id) REFERENCES Genres(gen_id)
);

CREATE TABLE Rating (
    mov_id          INT,
    rev_id          INT,
    rev_stars       INT,
    num_o_ratings   INT,
    PRIMARY KEY (mov_id, rev_id),
    FOREIGN KEY (mov_id) REFERENCES Movie(mov_id),
    FOREIGN KEY (rev_id) REFERENCES Reviewer(rev_id)
);
