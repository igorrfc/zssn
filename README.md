# zssn
Zombie Survival Social Network

# Configure your /etc/hosts file:
To simulate a development enviroment, we have to do some modifications on /etc/hosts file. On this documentation I'll use the api.zssn-dev.com domain:

/etc/hosts
127.0.0.1       zssn-dev.com
127.0.0.1       api.zssn-dev.com

NOTE: Be sure to use the port 3000 (api.zssn-dev.com:3000)

-> Add survivor
curl -H "Content-Type: application/json" -X POST -d '{"survivor":{"name":nil,  "age":18, "gender":"m", "last_location_attributes":{"latitude":"15.465465864","longitude":"15.465465999"}}}' http://api.zssn-dev.com:3000/survivors

-> Update survivor location
curl -H "Content-Type: application/json" -X PATCH -d '{"survivor":{"last_location_attributes":{"latitude":"15.1217", "longitude":"15.2222"}}}' http://api.zssn-dev.com:3000/survivors/1/update_location
