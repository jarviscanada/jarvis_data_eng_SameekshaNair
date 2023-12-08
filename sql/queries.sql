INSERT INTO cd.facilities(facid, name, membercost, guestcost, initialoutlay, monthlymaintenance)
VALUES(9, 'Spa', 20, 30, 100000, 800);

INSERT INTO cd.facilities(facid, name, membercost, guestcost, initialoutlay, monthlymaintenance)
SELECT(SELECT MAX(facid) from cd.facilities)+1, 'Spa', 20, 30, 100000, 800;

UPDATE cd.facilities
SET initialoutlay = 10000
WHERE name = 'Tennis Court 2'

UPDATE cd.facilities
SET membercost = membercost+(0.1 * membercost), guestcost = guestcost+(0.1 * guestcost)\
WHERE name = 'Tennis Court 2'

DELETE FROM cd.bookings

DELETE FROM cd.members
WHERE memid = 37;

SELECT facid, name, membercost, monthlymaintenance
FROM cd.facilities
WHERE membercost > 0 AND membercost < 0.02*monthlymaintenance

SELECT * FROM cd.facilities
WHERE name LIKE '%Tennis%'

SELECT * FROM cd.facilities
WHERE facid IN (1,5)

SELECT memid, surname, firstname, joindate
FROM cd.members
WHERE
        joindate >= '2012-09-01'

SELECT surname FROM cd.members
UNION
SELECT name FROM cd.facilities

SELECT starttime
FROM cd.bookings B
         JOIN cd.members M ON B.memid = M.memid
WHERE
        firstname = 'David' AND M.surname = 'Farrell'

SELECT B.starttime, F.name
FROM cd.bookings B
         JOIN cd.facilities F ON B.facid = F.facid
WHERE
        F.name LIKE 'Tennis Court%' AND
        B.starttime >= '2012-09-21'AND
        B.starttime <= '2012-09-22'
ORDER BY B.starttime