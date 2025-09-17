# Steps to get data
## Version 1: [API User](https://api.postman.com/collections/17938966-ea2d8b48-8eee-402c-8cc6-97757761af8f?access_key=PMAT-01K5N7GP3C3ASG5FB3KC3BTBAA)  (please access url and read its response first)

**1. Create user**
- First sign up (please remember your credentials) 
- Create your [consumer key](http://localhost:8080/consumer-registration)  
Now you will get a response like this:
<img width="2560" height="1600" alt="image" src="https://github.com/user-attachments/assets/50bf2b67-b4da-4b5e-9c0f-a0a283db2e66" />
<div align="center"><i>This is just an example, not a real key</i></div>

**2. Login / Direct**
```
curl -X POST 'http://localhost:8080/my/logins/direct' -H 'Authorization: DirectLogin username={USER},password={PSSWD},consumer_key={APIKEY}' -H 'Content-Type: application/json'
```
OR you can use [Postman](https://www.getpostman.com/) to do it  
Now you will get a response like this:
```
{
    "token": "{TOKEN}"
}
```
**3. Get user**
```
curl -X GET 'http://localhost:8080/obp/v5.1.0/users/current' -H 'Content-Type: application/json' -H 'Authorization: DirectLogin token={TOKEN}'
```
Response:
```
{
  "user_id": "{ID}",
  "email": "{EMAIL}",
  "provider_id": "{PROVIDER}",
  "provider": "http://localhost:8080",
  "username": "{USER}",
  "entitlements": {
    "list": []
  },
  "views": {
    "list": []
  }
}
```
