# README

## Setup
This is the front end of the [pubs-portal-api](https://github.com/natyconnor/pubs-portal-api "pubs-portal-api") project. As such, it needs to connect to the API's database if you ever want to access it. As a front-end, this should not be necessary in general, but it might be nice.

Heroku is already set up for this, but for local development it's a bit trickier. First setup the API project, including the database. See it's README for the details.

This should give you a `pubs-portal_development` database. Feel free to use PGAdmin to examine this database.

This project has the same `database.yml` so it will connect to the same one. However for Active Record to work, the `schema.rb` and `models` folders need to be the same as `pubs-portal-api`. There is a script called `copy-files-from-api` that will copy these over, when you give it the path to the api project.

Once you have done that, you need both `pubs-portal-api` and `pubs-portal-front-end` to be running. The config is set up to look for the API at `http://localhost:3001` so start that server with 
>`rails s -p 3001`

 You can start the server for the front-end as normal `rails s`.

Everything should now work. Use the browser to go to `http://localhost:3000` and the app should work, successfully making API calls to the API app. If things seem funny, try using the console and make sure it's accessing the same database.

## Heroku
The project is already up and running on Heroku, but if you have multiple heroku projects on your machine, it's confusing on how to make that folder a proper Heroku folder. Use

> `$ heroku info`

to see if your folder is configured correctly. If it's not, you will have to specify the app you're using every time which is annoying. Basically you need to associate the git project with it's corresponding heroku git repo. While we no longer need to make a heroku remote to push to heroku, we need one for the folder to know which heroku project it belongs to. So we need to make a remote for heroku and then add the repo url to our git config.

```
$ heroku info --app pubs-portal-front-end
=== pubs-portal-front-end
Git Url:       git@heroku.com:pubs-portal-front-end.git
Web Url:       https://pubs-portal-front-end.herokuapp.com/
Addons:        heroku-postgresql:hobby-dev
Dynos:         { web: 1 }
Owner:         natyconnor@gmail.com
Region:        us
Repo Size:     0 B
Slug Size:     28 MB
Stack:         cedar-14
$ git remote add heroku git@heroku.com:pubs-portal-front-end.git
$ git config heroku.remote heroku
```

This will set the new `heroku` remote to the `heroku.remote` config and now heroku will know which app to use. These steps work with any projects.

