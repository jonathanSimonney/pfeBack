# README

This README would normally document whatever steps are necessary to get the
application up and running.

    bundle install
    rake db:migrate

## known and interesting existing routes

### admin

go to `/admin`

### api
#### map

On `/api/interestPoints/:lat/:lng` you'll get interest points in a radius of 200km 
around the latitude and longitude specified.

On `/api/interestPointsIcons` you'll get a list of the interestPointIcons.

### 
