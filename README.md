![alt tag](app/assets/images/Malstrom.png)  

Open-Source Threat Intelligence Platform
---------
Not your average threat intelligence platform. Malstrom aims to be a repository, not just for threat tracking and forensic artifact storage, but also stores YARA rules and notes for investigation, and will soon be able to correlate metadata for attribution beyond passive data analysis 

Screenshots
-----------
### Dashboard
![alt tag] (docs/malstrom_dash.png)
### Threat Feeds
![alt tag] (docs/feed_list.png)
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
