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

### profile
On `/api/user/profile/:user_id`, with a get request, you'll get the public informations
 of the user whose id you sent, or an error if the id you sent doesn't exist. 
#### map
##### interest points 

On `/api/map/interest_points/:lat/:lng` you'll get interest points and positions in a radius of 200km 
around the latitude and longitude specified.

On `/api/map/interest_points/icons` you'll get a list of the interestPointIcons.

#### position
Make a POST request on `/api/map/position/add/:lat/:lng/:token` you'll add your current position
on the map. The token is given by the API when you connect (see the user part
of the API). You'll get a 200 with the json : 

```json
{  
   "result": "success"
}
```

if the request is a success and a 401 if the token was invalid, with the following json : 

```json
{  
   "error": "wrong token"
}
```
.
