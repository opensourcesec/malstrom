![alt tag](app/assets/images/Malstrom.png)  

Open-Source Threat Intelligence Platform
---------

Installation
---------
* Clone repository
* cd into project directory and run 'bundle install'
* setup the database.yml config file for your chosen DB
* Type 'rake db:migrate' to run database migrations
* Run 
`RAILS_ENV=production bundle exec rake assets:precompile` to precompile assets
* Finally, run the server with the command 'rails server -e production'
