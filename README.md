# cals-mock-api
Mock api to facilitate CALS development

git clone git@github.com:CambriaSolutions/cals-mock-api.git


Pre-requisite:
Postgresql database installed and running as service.

    bundle install 

#### brew will automatically initialize database directory
    
    Brew install postgresql

## enable services 
    
    Brew services

#### create common user
    
    createuser -P -d -l pguser
password cals101

#### run postgres server at launch and in the background
    
    Brew services start postgres

    bundle exec rake db:create
 
    bin/rails db:migrate RAILS_ENV=development
  
    rake db:seed
