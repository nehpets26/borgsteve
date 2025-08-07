# Bash Scripting Assignment – DB Backup & Log Analysis

This project contains two main tasks:

1. **MySQL Database Backup**  
2. **Analyzing Apache log files**

---

## Setup Directories

Create required directories:

```bash
mkdir -p /var/backups/dbbackups/
cd /tmp/
git clone https://github.com/nehpets26/borgsteve.git
cd /tmp/borgsteve/
```
## Download & Import the Sample Database
Clone the sample MySQL `employees` database:
```
git clone https://github.com/datacharmer/test_db.git
```
Import the database:
```
cd test_db/
mysql < employees.sql
```
Test that the database was imported correctly:
```
mysql -t < test_employees_md5.sql
```
## Task 1 – Database Backup Script
Execute the backup script:
```
cd /tmp/borgsteve/
bash my_sql_backup.sh
```
This script will back up the employees database and store the compressed `.gz` file with logs in:
```
ll /var/backups/dbbackups/
```
## Task 2 – Apache Log Analysis

Download the Apache log file:
```
curl -o apache_logs "https://raw.githubusercontent.com/elastic/examples/6d86454ebb7a850bcd7e80abe86fe683370018a6/Common%20Data%20Formats/apache_logs/apache_logs"
```
Run the log analysis script:
```
bash apache_logs_analysis.sh
```
This script provides in a menu format:

- Counts how many requests happened
- Shows which IP made the most requests
- Identifys how many `404` errors there were



## What Assumptions Were Made
It was assumed that the MySQL server is already installed and running.
gzip for backup compression is installed
Scripts are run in a Linux-like environment

## How I Would Improve It with More Time

Automate the setup and execution using Ansible to make the solution scalable and repeatable across multiple servers.
Support automatic email notifications after a successful backup or if a failure occurs.
Schedule the backup script with `cron` and log rotation.
