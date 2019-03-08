# README

This README would normally document whatever steps are necessary to get the
application up and running.

    bundle install
    rake db:migrate

## known and interesting existing routes

### admin

go to `/admin`

### api
### user (not yet finished implementation)
#### creation 
On `/api/user/create`, send a raw json (for example, like this 
```json
{  
    "user": {
        "email": "me@gmail.com",
        "password": "password11",
        "password_confirmation": "password11"
    }
}
```
). In case something is wrong, you'll get a 403 error, along with an array of error (encoded
in json). Otherwhise, you'll get a 200 answer with the created user in json.

### login
On `/api/user/login`, send a raw json (for example, like this 
```json
{  
    "user": {
        "email": "me@gmail.com",
        "password": "password11"
    }
}
```
). In case something is wrong, you'll get a 403 error, along with an array of error (encoded
   in json). Otherwhise, you'll get a 200 answer with the token in a json like this : 
```json
{  
   "auth_token": "token_value"
}
```
.
#### map
##### interest points 

On `/api/map/interest_points/:lat/:lng` you'll get interest points in a radius of 200km 
around the latitude and longitude specified.

On `/api/map/interest_points/icons` you'll get a list of the interestPointIcons.

#### position (not yet implemented)
On `/api/map/position/add/:lat/:lng/:token` you'll add your current position
on the map. The token is given by the API when you connect (see the user part
of the API)
