# Cents us dollars them

Exploring the distribution of wealth in the United States with data from the [US Census API](http://www.census.gov/developers/) for the [Aaron Swartz Memorial Hackathon](https://www.noisebridge.net/wiki/Aaron_Swartz_Memorial_Hackathon)

See this live: [http://morning-reef-9378.herokuapp.com/](http://morning-reef-9378.herokuapp.com/)

## Setup

1. Clone a copy of the git repo to your local machine

    git clone git@github.com:cgcardona/cents_us.git

2. Make sure you [request an api key](http://www.census.gov/developers/tos/key_request.html)

3. We're gonna wanna stash that api key somewhere private so that noone else can get their hands on it

Because I'm running the app on [Heroku](http://www.heroku.com) I'm using [this method](https://devcenter.heroku.com/articles/config-vars)

Start by installing the `foreman` gem from heroku

    gem install foreman

> [Foreman](https://github.com/ddollar/foreman) is a command-line tool for running Procfile-backed apps. It’s installed
> automatically by the Heroku Toolbelt, and also available as a Ruby gem.

You need to create a `Procfile` with something similar to the following:

    web: bundle exec rails server -p $PORT

Now create a `.env` file with your config vars

    AUTH_KEY=1111111111333333333333333333333777777777777

Once you've got this set up then you start WEBrick with

    foreman start

Make sure to add `.env` to your `.gitignore` file so that your config vars don't
get checked into version control

## Sources of Data

[US Census API Homepage](http://www.census.gov/developers/)

[2010 Census Summary File 1 (SF1)](http://www.census.gov/developers/data/sf1.xml)

[American Community Survey 5 Year Data](http://www.census.gov/developers/data/acs_5yr_2011_var.xml)
