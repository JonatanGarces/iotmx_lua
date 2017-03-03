local function pushTheButton(connection, pin)
require('ds18b20.lc')
ds18b20.setup(pin)
 connection:send("HTTP/1.0 200 OK\r\nContent-Type: application/json\r\nCache-Control: private, no-store\r\n\r\n")
   connection:send('{"temp":'..ds18b20.read()..', "message":"NO PRENDIDO"}')    
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
