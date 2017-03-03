local srv=net.createServer(net.TCP)
srv:listen(80,function(conn)
conn:on("receive", function(client,request)
local _GET=dofile("get.lc")(request)
  if(_GET.pin ~= nil) then
    local led1 = 3;
    gpio.mode(led1, gpio.OUTPUT)
    if(_GET.pin == "ON1")then
    gpio.write(led1, gpio.HIGH)
    elseif(_GET.pin == "OFF1")then
    gpio.write(led1, gpio.LOW)
    end  
  end 
  print(wifi.sta.getip())
  client:send("OK"..wifi.sta.getip())
  client:close()
end)
end)
collectgarbage()
 

