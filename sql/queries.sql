INSERT INTO cd.facilities(facid, name, membercost, guestcost, initialoutlay, monthlymaintenance)
VALUES(9, 'Spa', 20, 30, 100000, 800);

INSERT INTO cd.facilities(facid, name, membercost, guestcost, initialoutlay, monthlymaintenance)
SELECT(SELECT MAX(facid) from cd.facilities)+1, 'Spa', 20, 30, 100000, 800;

UPDATE cd.facilities
SET initialoutlay = 10000
WHERE name = 'Tennis Court 2';

UPDATE cd.facilities
SET membercost = membercost+(0.1 * membercost), guestcost = guestcost+(0.1 * guestcost)\
WHERE name = 'Tennis Court 2';

DELETE FROM cd.bookings

DELETE FROM cd.members
WHERE memid = 37;

SELECT facid, name, membercost, monthlymaintenance
FROM cd.facilities
WHERE membercost > 0 AND membercost < 0.02*monthlymaintenance;

SELECT * FROM cd.facilities
WHERE name LIKE '%Tennis%';

SELECT * FROM cd.facilities
WHERE facid IN (1,5);

SELECT memid, surname, firstname, joindate
FROM cd.members
WHERE
        joindate >= '2012-09-01';

SELECT surname FROM cd.members
UNION
SELECT name FROM cd.facilities;

SELECT starttime
FROM cd.bookings B
         JOIN cd.members M ON B.memid = M.memid
WHERE
        firstname = 'David' AND M.surname = 'Farrell';

SELECT B.starttime, F.name
FROM cd.bookings B
         JOIN cd.facilities F ON B.facid = F.facid
WHERE
        F.name LIKE 'Tennis Court%' AND
        B.starttime >= '2012-09-21'AND
        B.starttime <= '2012-09-22'
ORDER BY B.starttime;

SELECT M.firstname as memfname, M.surname as memsname, R.firstname as recfname, R.surname as recsname 
FROM cd.members M
        LEFT OUTER JOIN cd.members R ON R.memid = M.recommendedby
ORDER BY M.surname, M.firstname;

SELECT R.firstname, R.surname 
FROM cd.members M
JOIN cd.members R ON R.memid = M.recommendedby
GROUP BY R.firstname, R.surname
ORDER BY surname, firstname;

SELECT DISTINCT M.firstname || ' ' || M.surname as member, 
       ( 
        SELECT R.firstname || ' ' || R.surname as recommender
  	FROM cd.members R
  	WHERE M.recommendedby = R.memid
       )
FROM cd.members M
ORDER BY member;

SELECT facid, SUM(slots) as "Total Slots"
FROM cd.bookings
GROUP BY facid
ORDER BY facid;

SELECT facid, SUM(slots) as "Total Slots"
FROM cd.bookings
WHERE starttime >= '2012-09-01' AND starttime < '2012-10-01'
GROUP BY facid
ORDER BY "Total Slots";

SELECT facid, extract(month from starttime) as month, SUM(slots) as "Total Slots"
FROM cd.bookings
WHERE starttime >= '2012-01-01' AND starttime < '2013-01-01'
GROUP BY facid, month
ORDER BY facid, month;

SELECT COUNT(DISTINCT memid) FROM cd.bookings;

SELECT M.surname, M.firstname, B.memid, MIN(B.starttime) as starttime
FROM cd.members M
JOIN cd.bookings B ON M.memid = B.memid
WHERE starttime > '2012-09-01'
GROUP BY B.memid, M.surname, M.firstname
ORDER BY B.memid;

SELECT COUNT(*) OVER(), firstname, surname
FROM cd.members
ORDER BY joindate;

SELECT ROW_NUMBER() OVER(ORDER BY joindate) as row_number, firstname, surname
FROM cd.members;

SELECT surname || ', ' || firstname as name
FROM cd.members;

SELECT memid, telephone
FROM cd.members
WHERE telephone LIKE '%(%'
ORDER BY memid;

SELECT LEFT(surname, 1) as letter, COUNT(*) as count
FROM cd.members
GROUP BY letter
ORDER BY letter;

