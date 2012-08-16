web: bundle exec rails server thin -p $PORT -e $RACK_ENV
pubsub: bundle exec thin start -p 9292 -R ./faye.ru -e $RACK_ENV
