![alt tag](app/assets/images/Malstrom.png)  

Cyber Intelligence Management Platform
---------
[![Build Status](https://travis-ci.org/byt3smith/malstrom.svg?branch=master)](https://travis-ci.org/byt3smith/malstrom)
[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

Malstrom aims to be a repository for threat tracking and forensic artifacts, but also stores YARA rules and notes for investigation


### Dashboard
![alt tag] (docs/malstrom_dash.png)
### Malware Samples
![alt tag] (docs/malware_samples.png)
### Malware File Details
![alt tag] (docs/sample_analysis.png)
### Threat Tag Cloud
![alt tag] (docs/tag_cloud.png)
### IOC Extraction and Storage
![alt tag] (docs/ioc_imports.png)
### YARA Rule Storage
![alt tag] (docs/yara_rules.png)

Installation
---------
* Clone repository
* Edit app/assets/vt.key and input your VirusTotal API key as the only line in the file
* cd into project directory and run 'bundle install'
* setup the database.yml config file for your chosen DB
* Type 'rake db:migrate' to run database migrations
* Run 
`RAILS_ENV=production bundle exec rake assets:precompile` to precompile assets
* Finally, run the server with the command 'rails server -e production'
