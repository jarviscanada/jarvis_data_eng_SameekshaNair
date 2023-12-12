# Introduction

# SQL Queries

###### Table Setup (DDL)

CREATE TABLE public.members (\
memid _int2 NOT NULL,\
surname varchar NOT NULL,\
firstname varchar NOT NULL,\
address varchar NOT NULL,\
zipcode _int8 NOT NULL,\
telephone varchar NOT NULL,\
recommendedby _int2,\
joindate _timestamp NOT NULL,\
CONSTRAINT members_pk PRIMARY KEY (memid),\
CONSTRAINT members_fk FOREIGN KEY (recommendedby) REFERENCES public.members(memid)\
);

CREATE TABLE public.facilities (\
facid _int4 NOT NULL,\
"name" varchar NULL,\
membercost _numeric NULL,\
guestcost _numeric NULL,\
initialoutlay _numeric NULL,\
monthlymaintenance _numeric NULL,\
CONSTRAINT facilities_pk PRIMARY KEY (facid),\
);


CREATE TABLE public.bookings (\
facid _int4 NOT NULL,\
memid _int2 NULL,\
starttime _timestamp NULL,\
slots _int2 NULL,\
CONSTRAINT bookings_pk PRIMARY KEY (facid),\
CONSTRAINT bookings_fk FOREIGN KEY (memid) REFERENCES public.members(memid)\
CONSTRAINT bookings_fk FOREIGN KEY (facid) REFERENCES public.facilities(facid)\
);

###### Pratice Queries Answers:

1. INSERT INTO cd.facilities(facid, name, membercost, guestcost, initialoutlay, monthlymaintenance)\
   VALUES(9, 'Spa', 20, 30, 100000, 800);
2. INSERT INTO cd.facilities(facid, name, membercost, guestcost, initialoutlay, monthlymaintenance)\
   SELECT(SELECT MAX(facid) from cd.facilities)+1, 'Spa', 20, 30, 100000, 800;
3. UPDATE cd.facilities\
   SET initialoutlay = 10000\
   WHERE name = 'Tennis Court 2'
4. UPDATE cd.facilities\
   SET membercost = membercost+(0.1 * membercost), guestcost = guestcost+(0.1 * guestcost)\
   WHERE name = 'Tennis Court 2'
5. DELETE FROM cd.bookings
6. DELETE FROM cd.members\
   WHERE memid = 37;

7. SELECT facid, name, membercost, monthlymaintenance\
   FROM cd.facilities\
   WHERE membercost > 0 AND membercost < 0.02*monthlymaintenance 
8. SELECT * FROM cd.facilities\
   WHERE name LIKE '%Tennis%'
9. SELECT * FROM cd.facilities\
   WHERE facid IN (1,5)
10. SELECT memid, surname, firstname, joindate\
    FROM cd.members\
    WHERE\
    joindate >= '2012-09-01'
11. SELECT surname FROM cd.members\
    UNION\
    SELECT name FROM cd.facilities
12. SELECT starttime\
    FROM cd.bookings B\
    JOIN cd.members M ON B.memid = M.memid\
    WHERE\
    M.firstname = 'David' AND M.surname = 'Farrell'
13. SELECT B.starttime, F.name\
    FROM cd.bookings B\
    JOIN cd.facilities F ON B.facid = F.facid\
    WHERE\
    F.name LIKE 'Tennis Court%' AND\
    B.starttime >= '2012-09-21'AND\
    B.starttime <= '2012-09-22'\
    ORDER BY B.starttime
14. SELECT M.firstname as memfname, M.surname as memsname, R.firstname as recfname, R.surname as recsname\
    FROM\
    cd.members M\
    LEFT OUTER JOIN cd.members R ON R.memid = M.recommendedby\
    ORDER BY M.surname, M.firstname
15. SELECT R.firstname, R.surname \
    FROM cd.members M\
    JOIN cd.members R ON R.memid = M.recommendedby\
    GROUP BY R.firstname, R.surname\
    ORDER BY surname, firstname\
16. SELECT DISTINCT M.firstname || ' ' || M.surname as member,\
      (\
         SELECT R.firstname || ' ' || R.surname as recommender\
         FROM cd.members R\
         WHERE M.recommendedby = R.memid\
      )\
    FROM cd.members M\
    ORDER BY member\

17. SELECT facid, SUM(slots) as "Total Slots"\
    FROM cd.bookings\
    GROUP BY facid\
    ORDER BY facid;\

18. SELECT facid, SUM(slots) as "Total Slots"\
    FROM cd.bookings\
    WHERE starttime >= '2012-09-01' AND starttime < '2012-10-01'\
    GROUP BY facid\
    ORDER BY "Total Slots";\

19. SELECT facid, extract(month from starttime) as month, SUM(slots) as "Total Slots"\
    FROM cd.bookings\
    WHERE starttime >= '2012-01-01' AND starttime < '2013-01-01'\
    GROUP BY facid, month\
    ORDER BY facid, month;\

20. SELECT COUNT(DISTINCT memid) FROM cd.bookings;

21. SELECT M.surname, M.firstname, B.memid, MIN(B.starttime) as starttime\
    FROM cd.members M\
    JOIN cd.bookings B ON M.memid = B.memid\
    WHERE starttime > '2012-09-01'\
    GROUP BY B.memid, M.surname, M.firstname\
    ORDER BY B.memid;\

22. SELECT COUNT(*) OVER(), firstname, surname\
    FROM cd.members\
    ORDER BY joindate

23. SELECT ROW_NUMBER() OVER(ORDER BY joindate) as row_number, firstname, surname\
    FROM cd.members

24. 
25. SELECT surname || ', ' || firstname as name\
    FROM cd.members

26. SELECT memid, telephone\
    FROM cd.members\
    WHERE telephone LIKE '%(%'\
    ORDER BY memid\
    
27. SELECT LEFT(surname, 1) as letter, COUNT(*) as count\
    FROM cd.members\
    GROUP BY letter\
    ORDER BY letter





