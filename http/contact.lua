-- garage_door_opener.lua
-- Part of nodemcu-httpserver, example.
-- Author: Marcos Kirsch

local function pushTheButton(connection, pin)

   -- push the button!
   -- Note that the relays connected to the garage door opener are wired
   -- to close when the GPIO pin is low. This way they don't activate when
   -- the chip is reset and the GPIO pins are in input mode.
   gpio.mode(pin, gpio.OUTPUT)
   local reading = gpio.read(pin)
  
   if(reading ==1) then
      gpio.write(pin, gpio.LOW)
      print("LOW")
   elseif(reading ==0) then
      gpio.write(pin, gpio.HIGH)
       print("HIGH")
   end


   -- Send back JSON response.
   connection:send("HTTP/1.0 200 OK\r\nContent-Type: application/json\r\nCache-Control: private, no-store\r\n\r\n")
   connection:send('{"error":0, "message":"OK"}')

end

return function (connection, req, args)
   print('Garage door button was pressed!', args.door)
   if     args.door ~= nil then pushTheButton(connection,  args.door)   -- GPIO1
   elseif args.door ~= "" then pushTheButton(connection,  args.door)   -- GPIO2
   else
      connection:send("HTTP/1.0 400 OK\r\nContent-Type: application/json\r\nCache-Control: private, no-store\r\n\r\n")
      connection:send('{"error":-1, "message":"Bad door"}')
   end
end
