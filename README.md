# zssn
Zombie Survival Social Network

# Configure your /etc/hosts file:
To simulate a development environment, we have to do some modifications on /etc/hosts file. On this documentation I'll use the api.zssn-dev.com domain:

/etc/hosts

127.0.0.1       zssn-dev.com

127.0.0.1       api.zssn-dev.com

NOTE: Be sure to use the port 3000 (api.zssn-dev.com:3000)

#Populating Database
Run rake db:seed to create the main resources.

#API resources
NOTE: Using curl to send requests.

-> Add survivor

curl -H "Content-Type: application/json" -X POST -d '{"survivor":{"name":"First Survivor",  "age":18, "gender":"m", "last_location_attributes":{"latitude":"15.465465864","longitude":"15.465465999"}}}' http://api.zssn-dev.com:3000/survivors

-> Update survivor location

curl -H "Content-Type: application/json" -X PATCH -d '{"survivor":{"last_location_attributes":{"latitude":"15.1217", "longitude":"15.2222"}}}' http://api.zssn-dev.com:3000/survivors/1/update_location

-> Report infected survivor

curl -H "Content-Type: application/json" -X POST -d '{"survivor":{"survivor_id":1}}' http://api.zssn-dev.com:3000/infected_reports/

-> Trade resources

curl -H "Content-Type: application/json" -X PATCH -d '{"resources":[{"id":"56", "inventory_id":"1", "resource_type_id":"2"}, {"id":"57", "inventory_id":"1", "resource_type_id":"2"}], "survivor":{"id":"2", "resources":[{"id":"58", "inventory_id":"2", "resource_type_id":"1"}, {"id":"59", "inventory_id":"2", "resource_type_id":"3"}]}}' http://api.zssn-dev.com:3000/survivors/1/trade
