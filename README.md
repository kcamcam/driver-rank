# Driver Rank 🚘

### [DriverRank.ca](https://driverrank.ca)  

Rate other shit💩head drivers on their driving 🚘  
My first rails project   
Deployed on Heroku  
Runing on Rails 5.1.4  
[Materialize.css](http://materializecss.com/) for the front-end framework

### Run Locally (OS X)
1. Make sure Brew is isntalled and the latest version of Ruby (2.4.2)
2. cd into/the/location/of/the/project
3. Install rails  
  `$ gem install rails; hash -r; rails -v;`  
4. Install Postgres  
  `$ brew update; brew install postgres`  
5. Install gems  
  `$ bundle install`
6. Initialize the DB  
  `$ bin/rake db:create RAILS_ENV=development`  
  `$ bin/rake db:migrate RAILS_ENV=development`  
7. Migrate the DB  
  `$ rails db:migrate`  
8. Launch the server  
  `$ rails server`
9. Visit the site  
  `http://localhost:3000/`  
  
note: if you run into problems at #6 [this](https://stackoverflow.com/questions/25611004/rake-dbcreate-throws-database-does-not-exist-error-with-postgresql) helped me.
  
