local wifiConfig= {}
wifiConfig.mode = wifi.STATIONAP
wifiConfig.accessPointConfig = {}
wifiConfig.accessPointConfig.ssid = "IOTMX-"..node.chipid()
wifiConfig.accessPointConfig.pwd = "IOTMX-"..node.chipid()
wifiConfig.accessPointIpConfig = {}
wifiConfig.accessPointIpConfig.ip = "192.168.111.1"
wifiConfig.accessPointIpConfig.netmask = "255.255.255.0"
wifiConfig.accessPointIpConfig.gateway = "192.168.111.1"
wifi.setmode(wifiConfig.mode)
wifi.ap.config(wifiConfig.accessPointConfig)
wifi.ap.setip(wifiConfig.accessPointIpConfig)
wifiConfig = nil
collectgarbage()
if  (not not wifi.ap.getip()) then
	--dofile("server_ap.lc")
	dofile("httpserver.lc")(80)
else
	dofile("init.lua")
end