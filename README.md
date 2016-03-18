# Tiny Social Network

A tiny social network with users, messages and followers!

From the app we want to provide these features:

* A user can register using his email, a selected password and a user name. The user name has to be unique.
* One user can publish messages no longer than 160 characters.
* One user can follow what other users publish. When the user accesses the application, he will see the messages published by the users he follow.
* Everyone can see the users followed by any user.
* Everyone can see the users that follow one user.

But other developers should be able to build their own applications using these public information. So, provide an API access to allow:

* See one user messages.
* See the users followed by one user.
* See the users that follow one user.

In addition, some features has been added to make things funnier:

* A not logged in user can register and sign in and visit users and messages,
  but not create messages or follow/unfollow users.
* A logged in user:
  * Sees a layout with a link to close session and log out.
  * Can access the show action of other users and follow/unfollow them.

Some features should be added:

* Pagination for all lists (users, messages, followers and followed), in web and API
* Secure API with an access token. This can be managed with doorkeper
* By default a user should follow himself
* Registration should be more complex, maybe validating uniqueness of email and
  checking the email existence delivering an activation message

I've decided to create API separated from web application, using controllers
inherited from ActionController::API. The JSON returned by the API is generated
using ActiveModelSerializers gem, with JsonAPI adapter.

About routes and controllers, I've decided to nest messages, followers and
followed users under user_controller. Nesting one level only makes cleaner
routes and allows the reuse of code in index.

## Installation

master branch contains the version working with Rails 4.2, but you can try
a rails5 branch

1. Clone the repo and set the ruby version to 2.3.0
2. Install bundler gem
2. Run `bundle install`
3. Set database (database adapter is mysql2):
  * Create database: `rake db:create`
  * Migrate database: `rake db:migrate`
  * Initialize database with some example data: `rake db:seed`
4. start server `rails s`
5. Visit the local page at http://localhost:3000

## API endpoints

* Users index:
```shell
curl -v -H 'Accept: application/json' -X GET 'http://localhost:3000/api/users'
```

* User show
```shell
curl -v -H 'Accept: application/json' -X GET 'http://localhost:3000/api/users/1'
```

* Users followed by a user
```shell
curl -v -H 'Accept: application/json' -X GET 'http://localhost:3000/api/users/1/followed'
```

* Users that follow one user
```shell
curl -v -H 'Accept: application/json' -X GET 'http://localhost:3000/api/users/1/followers'
```

* Messages of a user
```shell
curl -v -H 'Accept: application/json' -X GET 'http://localhost:3000/api/users/1/messages'
```

* Message show
```shell
curl -v -H 'Accept: application/json' -X GET 'http://localhost:3000/api/messages/1'
```
