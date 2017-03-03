local html = {}
local wifiConfig= {}
local joinCounter=0
local joinMaxAttempts = 5
local joinCounter = 0
local pases  =  dofile("lectura.lc")(html)
if pases == nil then
  pases[1]=""
  pases[2]=""
end
if pases[2] == nil then
pases[2] = ""
end
if pases[1] == nil then
pases[1] = ""
end
wifiConfig.mode = wifi.STATION
wifiConfig.stationPointConfig = {}
wifiConfig.stationPointConfig.ssid = pases[1]        -- Name of the WiFi network you want to join
wifiConfig.stationPointConfig.pwd =pases[2] 
wifi.setmode(wifiConfig.mode)
wifi.sta.config(wifiConfig.stationPointConfig.ssid, wifiConfig.stationPointConfig.pwd)
wifiConfig = nil
collectgarbage()
tmr.alarm(0, 3000, 1, function()
        if joinCounter < joinMaxAttempts then
            if wifi.sta.getip() == nil then
                joinCounter = joinCounter +1
            else
                tmr.stop(0)
                dofile("httpserver.lc")(80)  
                --dofile("server_sta.lc")
            end
        else
                tmr.stop(0)  
                dofile("init_ap.lc")
        end
end)