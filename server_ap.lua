local srv=net.createServer(net.TCP)
srv:listen(80,function(conn)
conn:on("receive", function(client,request)

local function write(ssid,pass)
    file.open("db.txt","w")
    file.write("")
    file.writeline(ssid.."|"..pass)
    file.close()
    tmr.wdclr()
    node.restart()
end  
local _GET=dofile("get.lc")(request)
if _GET.ssid == nil then
_GET.ssid =""
end
if _GET.password == nil then
_GET.password = ""
end
if(_GET.ssid ~= "" and _GET.ssid ~= nil ) then
  write(_GET.ssid,_GET.password)
end
wifi.sta.getap(function (t)
local scaneos={}
local rows ={}
    if t ~= nil then
        for ssid,v in pairs(t) do
           local authmode, rssi, bssid, channel = string.match(v, "([^,]+),([^,]+),([^,]+),([^,]+)")
            local row={ 
                        SSID      = string.format("%32s",ssid)
                        ,BSSID    = bssid
                        ,RSSI     = rssi
                        ,AUTHMODE = authmode
                        ,CHANNEL  = channel
                        }
            table.insert(rows,row)
        end
    end
    local serializedString = cjson.encode(rows)
  client:send(serializedString)
  client:close()
  collectgarbage()
end)
end)
end)

 

