# Linux Cluster Monitoring Agent

## Introduction
This project aims to create an app that can be used to track real time memory usage of a machine. The app is automated to gather memory usage data every minute and store it into a database to analyze later. The database can hold multiple host machines and fetch each of their data. This app is built using bash scripts for scripting, PostgreSQL and docker for database, git for version control and crontab for automation.  

## How to Use
### We can use the following commands to run the system
To create a new container and docker instance:\
`./psql_docker.sh create username password`
('create' makes a new instance with given username and password for the instance)
\
After creation:\
`./psql_docker.sh start` and `./psql_docker.sh stop` to start and stop container.

`./ddl.sql` to create a new postgreSQL table if it doesn't exist already

`./host_info.sh hostname portnumber database psqluser psqlpass` to input the host system info into the created database

`./host_usage.sh hostname portnumber database psqluser psqlpass` to input the host system's memory info into the database.

Next, `crontab -e` and adding: `* * * * * bash (the path to the host_usage.sh)` to crontab can be used to automate the host_usage.sh script to run every minute.

## Implementation

- First, Create a docker container in the host system to run the psql database instance.
- After creating the instance, run the sql file to create the tables we are going to use (if it does not exist already)
- Next, store the information of the new host into the database using the `host_info.sh` script
- Then run the `host_usage.sh` to store information on memory usage. 
- The previous step can be automated by editing crontab and adding the file path to the host_usage script into the crontab with `* * * * *` marker to indicate automation every minute. This can be altered to automate with the desired setting.


## Architecture

## Scripts

`psql_docker.sh` - can be used to control the docker container, i.e. create, start or stop it\
`ddl.sql` - used to initialize the database and tables\
`host_info.sh` - used to automatically gather host information and then insert it into the database.\
`host_usgae.sh` - used to automatically gather the host memory info and store it into the database.

## Database Modelling

The tables used are as follows:

- `host_info`
  - `id` - This is the primary key. Increments each time a new host is added.
  - `hostname` - Name of the host system
  - `cpu_number` - CPU number of the system
  - `cpu_architecture` - Processor architecture
  - `cpu_model` - Type of processor
  - `cpu_mhz` - Processor speed
  - `l2_cache`- L2 cache memory in the CPU
  - `timestamp`- Time of addition to the table 
  - `total_mem` - Total memory of the system


- `host_usage`
    - `timestamp`- Time of addition to the table
    - `host_id` - This is the foreign key. Connects this table to host_info
    - `memory_free` - The amount of free memory available
    - `cpu_idle` - Idle RAM memory usage
    - `cpu_kernel` - Kernel memory 
    - `disk_io` - Disk memory used for io operations
    - `disk_available` - Disk memory available
    
## Test

Tested manually using Linux terminal.

## Deployment

Deployed using Github for version control, docker so that app can run on multiple machines and crontab used for automation.
## Improvements
- Add more scripts to filter or sort processes so that user can filter out processes using more memory