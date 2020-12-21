
<!-- TABLE OF CONTENTS -->
# Table of Contents
- [About The Project](#about-the-project)
- [Getting Started](#getting-started)
- [Installation](#installation)
- [Deployment instructions](#deployment-instructions)
- [Services](#services)
- [Assumptions and Design Considerations](#assumptions-and-design-considerations) 
- [Contact](#contact)

<!-- ABOUT THE PROJECT -->
## About The Project
This is a URL shortener app similar to [bit.ly](http://bit.ly).

[![image](https://user-images.githubusercontent.com/7931750/102755404-a2b27500-436e-11eb-95a1-c703424a245c.png)](https://app-short-url.herokuapp.com)

<!-- GETTING STARTED -->
## Getting Started
To get a local copy up and running follow these simple steps.

##### Prerequisites

The setups steps expect following tools installed on the system.
```
git
ruby 2.6.0
rails 6.0.3.4
```

<!-- INSTALLATION -->
## Installation 
#### 1. Clone the repository

```bash
git clone https://github.com/ekumachidi/UrlShortenerApp.git
```

#### 2. Setup and configuration

```bash
cd UrlShortenerApp

bundle install && yarn

touch .env
```

Edit your .env to include the following keys:
```
HOST_URL=<YOUR_HOST_URL_HERE>
REDIS_URL=<LINK_TO_YOUR_REDIS_SERVER>
```

#### 3. Create and setup the database

Run the following commands to create and setup the database.

```ruby
bundle exec rake db:create
bundle exec rake db:setup
```


#### 4. Run the test suite

You can run the test suite using the command given below.

```ruby
bundle exec rspec
```

OR by simple running:

```ruby
rspec
```

#### 5. Start the Rails server

You can start the rails server using the command given below.

```ruby
bundle exec rails s
```

And now you can visit the site with the URL http://localhost:3000/

## Deployment instructions

#### Deploying to Heroku

```
heroku create
heroku addons:create heroku-redis:hobby-dev -a your-app-name
heroku addons:create heroku-postgresql:<PLAN_NAME>
heroku config:set HOST_URL=your_heroku_app_url
git push heroku master
heroku run rake db:migrate
heroku open
```


## Services 
- Redis
- Sidekiq

## Assumptions and Design Considerations:

  - Length of ShortenedUrls: we are using 6 characters because it allows us generate as much as 10^7 characters which is approximately 10million unique characters
  - SecureRandom: Instead of creating our own randomize function that uses base64 to generate characters we settled for this ruby library, that has been tested over time to have a very low collision rate. however, for added security and increased confidence, we add a unique index to the database column. That ensures that we cannot store duplicates in our database. The insertion will raise an `ActiveRecord::InvalidStatement` error
  - Traffic: Since this just a POC I assume we're not getting lots of hits
  - Scalability: Since we don't get much traffic no need for shadding considerations and design decisions for multiple instance scenarios

## Contact:
Ekuma, Chidi - [@ekumachidic](https://twitter.com/ekumachidic)

Project Link: [https://github.com/ekumachidi/UrlShortenerApp](https://github.com/ekumachidi/UrlShortenerApp)
