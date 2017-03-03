local function pushTheButton(connection, pin)
   
   --gpio.mode(3, gpio.OUTPUT)
   --gpio.mode(4, gpio.INT,gpio.PULLUP)
   -- gpio.mode(pin, gpio.OUTPUT)
   local reading = gpio.read(pin)
   if(reading ==1) then
      connection:send('{"error":0, "message":"NO PRENDIDO"}')
   elseif(reading ==0) then
        connection:send('{"error":0, "message":"PRENDIDO"}')

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
