# Linux Cluster Monitoring Agent

## Introduction
This project aims to work around with Linux and use bash scripts to create an app that tracks the memory usage of my system. This app can be used by anyone who wants to check how much memory they are using on their system. This can help users understand and optimize their memory usgae. The app uses docker so it can run on different systems, bash scripting for the main scripts, PostgreSQL for the database and git for version control

## How to Use
### We can use the following commands to run the system
To create a new container and docker instance:\
`./psql_docker.sh create username password`
('create' makes a new instance with given username and password for the instance)
\
Similarly, `./psql_docker.sh start` and `./psql_docker.sh stop` to start and stop container

`./ddl.sql` to create a new postgreSQL table if it doesn't exist already

`./host_info.sh hostname portnumber database psqluser psqlpass` to input the host system info into the created database

`./host_usage.sh hostname portnumber database psqluser psqlpass` to input the host memory info into the database.

And finally, `crontab` can ve used to automate the host_usage.sh script to run every minute.

## Implementation

- First, we create a docker container in the host system to run the database instance. 