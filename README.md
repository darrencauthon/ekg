# EKG [![Build Status](https://secure.travis-ci.org/darrencauthon/ekg.png?branch=master)](http://travis-ci.org/darrencauthon/ekg)
[![Coverage Status](https://coveralls.io/repos/darrencauthon/ekg/badge.png?branch=master)](https://coveralls.io/r/darrencauthon/ekg?branch=master)

## Installation

Add this line to your application's Gemfile:

    gem 'ekg'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ekg

## Usage

1. Provide some setup.

````
Ekg.config = { name: 'YOUR APP NAME',
               firebase_url: 'https://YOURDB.firebaseio.com' }

````

2. Call "lub_dub" whenever you want to fire a note that your app is alive.

````
Ekg.lub_dub
````

3. Check your firebase database.  You'll find that a note in /heartbeats will be updated with the current timestamp.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
