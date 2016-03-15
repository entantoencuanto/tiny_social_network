# Tiny Social Network

A tiny social network with users, messages and followers!

From the app we want to provide these features:

* A user can register using his email, a selected password and a user name. The user name has to be unique.
* One user can publish messages no longer than 160 characters.
* One user can follow what other users publish. When the user accesses the application, he will see the messages published by the users he follow.
* Everyone can see the users followed by any user.
* Everyone can see the users that follow one user.

In addition, some features has been added to make things funnier:

* A not logged in user have access only to register page and login page.
* A logged in user:
  * Sees a layout with a link to close session and log out.
  * Can access the show action of other users and follow/unfollow them.

But other developers should be able to build their own applications using these public information. So, provide an API access to allow:

* See one user messages.
* See the users followed by one user.
* See the users that follow one user.

Some features should be added:

* Pagination for all lists (users, messages, followers and followed)
