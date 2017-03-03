return function (connection, req, args)
     dofile("httpserver-header.lc")(connection, 200, 'html')
        local function write(ssid,pass)
        file.open("db.txt","w")
        file.write("")
        file.writeline(ssid.."|"..pass)
        file.close()
        --node.restart()
        end  
         local rows,row={},{}
        if args.ssid == nil then
        args.ssid =""
        end
        if args.password == nil then
        args.password = ""
        end

        if(args.ssid ~= "" and args.password ~= "" ) then    
            row={ connection = "OK"} 
            table.insert(rows,row)
            connection:send(cjson.encode(rows))
            write(args.ssid,args.password)
            print(cjson.encode(rows))
            --node.restart()
            --dofile("init.lua")
        else
            row={ connection = "ERROR1"} 
            table.insert(rows,row)  
            connection:send(cjson.encode(rows))
            print(cjson.encode(rows))
        end
        collectgarbage()
end

