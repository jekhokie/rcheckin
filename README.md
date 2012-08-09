# RCheckin

[![Build Status](https://secure.travis-ci.org/jekhokie/rcheckin.png)](http://travis-ci.org/jekhokie/rcheckin)

Although social media and things like Google hangouts provide a slew of capabilities to track someone (location, status, etc.), it is often not appropriate to use these tools in a professional work environment. RCheckin aims to provide a simple web-based service for team members to report their current status, such as when they are in or out of the office, out to lunch, sick, etc. Doing so with a more simple user interface through a self-managed product is more conducive to keeping management informed about team members' whereabouts.

Screenshot
--------
The homepage in a standard PC browser:

![alt text](https://github.com/jekhokie/rcheckin/raw/master/public/images/RCheckin_web.jpg "RCheckin Home Page - Web")

The homepage in a mobile browser:

![alt text](https://github.com/jekhokie/rcheckin/raw/master/public/images/RCheckin_mobi.jpg "RCheckin Home Page - Mobile")

Install
--------

This product is a Ruby on Rails 3.x product. This means that the server on which the product is installed will require Ruby 1.9.3+ and Rails 3.x+ in order to get started. I also recommend using a Ruby version management software such as RVM to keep the environment for RCheckin isolated from other Ruby/Rails instances you might have on the machine.

In addition, this product requires a MongoDB instance. Please refer to the MongoDB installation instructions for installing the product.

Also, these installation instructions require the use of the bundler gem (and assume that it has been installed prior to proceeding). Please refer to the installation instrcutions for installing bundler prior to proceeding.

In order to run RCheckin, the following should be performed (this is obviously still in development and, thus, will not be 'deployable' in the traditional sense):

    git clone https://github.com/jekhokie/rcheckin.git

Once a copy of this repository has been created, navigate into the rcheckin directory:

    cd rcheckin/

Then, install the required dependencies using bundler:

    bundle install

Once the dependencies have been installed, the server can be started:

    bundle exec rails server

Finally, if all has gone well, you can navigate to http://localhost:3000 (dev default) to start interacting with the product.

NOTE: Real deployment steps/infrastructure will be incorporated and used for product deployment once the product becomes mature enough to warrant coding the infrastructure.

Usage
--------

TODO - will be written once the product matures to the point that it warrants a user-guide.

Credits
--------

* Thanks to Daniel Kehoe's tutorial on [Rails 3 using Mongoid and Devise](https://github.com/RailsApps/rails3-mongoid-devise) from which many of the Spec and Feature tests are taken

MIT License
--------

[MIT License](http://www.opensource.org/licenses/mit-license)
