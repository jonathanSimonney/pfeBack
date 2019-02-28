# README

This README would normally document whatever steps are necessary to get the
application up and running.

    bundle install
    rake db:migrate

## known and interesting existing routes

### admin

go to `/admin`

### api
### user (not yet implemented)
#### creation (Doc will be written when it will be done...)
#### map
##### interest points 

On `/api/map/interestPoints/:lat/:lng` you'll get interest points in a radius of 200km 
around the latitude and longitude specified.

On `/api/map/interestPoints/icons` you'll get a list of the interestPointIcons.

#### position (not yet implemented)
On `/api/map/position/add/:lat/:lng/:token` you'll add your current position
on the map. The token is given by the API when you connect (see the user part
of the API)
