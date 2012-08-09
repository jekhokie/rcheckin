# RCheckin

[![Build Status](https://secure.travis-ci.org/jekhokie/rcheckin.png)](http://travis-ci.org/jekhokie/rcheckin)

Although social media and things like Google hangouts provide a slew of capabilities to track someone (location, status, etc.), it is often not appropriate to use these tools in a professional work environment. RCheckin aims to provide a simple web-based service for team members to report their current status, such as when they are in or out of the office, out to lunch, sick, etc. Doing so with a more simple user interface through a self-managed product is more conducive to keeping management informed about team members' whereabouts.

WARNING: If you receive a browser warning about Session variables (specifically 'Moped'), you may need to delete all of your temporary browser data if you had previously used RCheckin when it was implemented using Mongoid.

Screenshot
--------
The homepage in a standard PC browser:

![alt text](https://github.com/jekhokie/rcheckin/raw/master/public/images/RCheckin_web.jpg "RCheckin Home Page - Web")

The homepage in a mobile browser:

![alt text](https://github.com/jekhokie/rcheckin/raw/master/public/images/RCheckin_mobi.jpg "RCheckin Home Page - Mobile")

PostgreSQL Prerequisites
--------

RCheckin assumes the use of a PostgreSQL database. Install PostgreSQL per your OS's installation instructions, and ensure the following lines are in the PostgreSQL access configuration file:

    # TYPE  DATABASE  USER      ADDRESS        METHOD
    local   all       postgres                 peer
    local   all       all                      peer
    host    all       all       127.0.0.1/32   md5
    host    all       all       ::1/128        md5

Then, restart the PostgreSQL service (as root):

    service postgresql restart

Switch to the postgres user and create the rcheckin user:

    su postgres
    createuser rcheckin
    # Ensure to click 'y' when asked if user should be a superuser

Log into the management console:

    psql

Change the user's password (NOTE: These will correspond to your database.yml):

    template1=# ALTER USER rcheckin WITH PASSWORD '<PASSWORD>';
    template1=# \q

NOTE: Now you must update you config/database.yml file (if you have not yet already done so) to correspond to the above values.

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

Create the databases and perform all migrations:

    bundle exec rake db:create:all
    bundle exec rake db:migrate
    bundle exec rake db:migrate RAILS_ENV=test

Once the dependencies have been installed and fulfilled, the server can be started:

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
