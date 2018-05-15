# Setup

## Requirement
- Ruby `2.2.2` (using `2.5.1` for development)
- Bundler (`gem install bundler`)
- Docker
- Docker compose
- PostgreSQL (for install gem `pg`)

## Installation
1. `$ git clone git@github.com:VLMH/ggpet.git`
2. `$ cd ggpet`
3. `$ docker-compose up -d db redis`
4. `$ bundle`
5. `$ rails db:create`
6. `$ rails db:migrate`
7. `$ rails s`

## How to test API?
1. Install Postman https://www.getpostman.com/apps
2. Import Postman collection `/postman/GGPet.postman_collection`

## Insert seed data
Run `$ rails db:seed`
This will create 6 pets, 8 customers according to `/app-root/db/seeds.rb`

## Extension 1 - Realtime matching
1. copy `.env` from email to `/app-root/.env`
2. `$ bundle exec sidekiq`
3. `$ open /app-root/public/matching.html` or open `/app-root/public/matching.html` in browser
4. Input customer ID and click subscribe
5. Add new pet via Postman
6. You should see new pet appended to the list if the pet matches the customer

> There is an issue that the list of customers who adopted pets cannot be updated.

## Extension 2 - Geolocation
Since I don't have time for this, I briefly explain how it can be implemented.

**Backend**
- Add `latitude`, `longitude` to Pet
- Get customer location `(lat, lon)`
- By using gem 'geocoder', query pets near customer (https://github.com/alexreisner/geocoder#for-activerecord-models)
- Make use of `/v1/customers/:id/matches` and return result

**Frontend**
- When open `matching.html`, get permission to retrieve geolocation
- Pass `(lat, lon)` to API server, when subscribe to a customer
- Display pet locations in map (e.g. Google Map) and result should be sorted by distance

## Extension 3 - Scaling
To handle increacing requests, we have to protect the database so that we can scale up server instances.

The first thing to do is to impose repository as a way to access data.

With repository, we can enable the followings with minimum code affected
1. create database read replica
    - handle multiple database connection
2. add caching layer before hit database
    - e.g. get data from Memcache

However, my code extracted services, drivers to separate logic but not repository and is still highly rely on ORM (ActiveRecord). Better do a refactoring before scale up.

Reference: https://blog.lelonek.me/why-is-your-rails-application-still-coupled-to-activerecord-efe34d657c91
