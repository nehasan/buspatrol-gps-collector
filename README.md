# buspatrol-gps-collector
## Run application : local machine
### Prerequisites
* Ruby version 2.7.3
* Docker

### Commands to run the server
* Clone the project from github using git clone https://github.com/nehasan/buspatrol-gps-collector.git
* move to the root directory using cd /path_to/buspatrol-gps-collector
* Type: gem install bundler
* Type: bundle install
* Modify the docker compose as per your need such as ports (e.g., 5432:5432)
* Type: docker-compose up -d db
* Type: irb
* Type (in irb console): require_relative './config/migrations'
* Type (in ir console): Migrations.new.create_table_geoms (this will create our required table to postgis database)
* Type (in irb console): exit
* Type: bundle exec rackup config.ru -p 3000

Now the server is running on port 3000.

