A sidekiq worker that closes auctions
=====================================

Closing auctions in ths case means: "Setting the winner on the auction"

To run
------

Install redis:

```
$ brew install redis
```

Add sidekiq to the Gemfile

```ruby
gem 'sidekiq',      '~> 4.0.0'
```

Setup the Rails shit:

```
$ bundle install
$ bundle exec rake db:setup
```

Window 1: Start Redis

(this worked on mine, idk if it's general, or where I got it from)

```
$ redis-server /usr/local/etc/redis.conf
```

Window 2: Start the Rails server

```
$ rails s
```

Window 3: start sidekiq

```
$ bundle exec sidekiq
```

Window 4: Check the data

(`jq` pretty prints the JSON response,
if you don't it, get it with `brew install jq`)

```
$ curl localhost:3000/auctions | jq .
```

Window 5: Open a console

To fake out events that would happen in the controller in a real app.

```ruby
# $ rails console
irb> binding.pry

# The worker is defined in app/workers/hard_worker.rb
# To call it, we need to give it whatever the `perform`
pry> show-source HardWorker#perform

From: /Users/josh/deleteme/redis-fucking-around/redising/app/workers/hard_worker.rb @ line 3:
Owner: HardWorker
Visibility: public
Number of lines: 3

def perform(auction_id)
  CloseAuction.call(auction_id)
end

# Tell it to close auction 1 in 10 seconds
pry> HardWorker.perform_in(10.seconds, 1)
```

Now, keep curling localhost, in 10 seconds,
you should see the window with sidekiq update as it begins processing the work.
And if you curl the endpoint again, afterwards, you should see that the
Auction number 1 now has a `winner_id` set on it.

```
$ curl localhost:3000/auctions | jq .
```

Obviously you'll make a few changes, but this shows
that it's not too much work, and it looks like Heroku
has some manner in which to add redis support for free
below 30 mb.
