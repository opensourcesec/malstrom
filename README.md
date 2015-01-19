![alt tag](app/assets/images/Malstrom.png)  

Open-Source Threat Intelligence Platform
---------

Installation
---------
* Clone repository
* cd into project directory and run 'bundle install'
* setup the database.yml file by running:
```nano config/database.yml
```	
  
* In the database.yml file, copy and paste this data to setup a db schema:
```production:\n
    adapter: sqlite3\n
    database: db/production.sqlite3\n
    pool: 5\n
    timeout: 5000
``` 
* Type Ctrl-X and hit return to save
* Type 'rake db:migrate' to run database migrations
* Finally, run the server with the command 'rails server'