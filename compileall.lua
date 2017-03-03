local compileAndRemoveIfNeeded = function(f)
   if file.open(f) then
      file.close()
      print('Compiling:', f)
      node.compile(f)
      file.remove(f)
      collectgarbage()
   end
end

local renamehttpfile = function(f)
   if file.open(f) then
      file.close()
      print('Renaming:', f)
local begining = 0
local ending = string.len(f)
local middle = string.find(f, "%.")
local name  = string.sub(f,begining,middle-1)
local extension  = string.sub(f,middle+1,ending)

print(begining.."|"..middle.."|"..ending.."|")
if(extension == "lua") then
   compileAndRemoveIfNeeded(f)
   file.remove("http/"..name..".lua")
   file.remove("http/"..name..".lc")
   file.rename(name..".lc","http/"..name..".lc")
   file.remove(name..".lc")
else
   file.remove("http/"..f)
   file.rename(f,"http/"..f)
   file.remove(f)
end
      
      collectgarbage()
   end
end



local serverFiles = {
   'httpserver.lua'
   ,'httpserver-b64decode.lua'
   ,'httpserver-basicauth.lua'
   ,'httpserver-conf.lua'
   ,'httpserver-connection.lua'
   ,'httpserver-error.lua'
   ,'httpserver-header.lua'
   ,'httpserver-request.lua'
   ,'httpserver-static.lua'
   ,'get.lua'
   ,'init_ap.lua'
   ,'init_sta.lua'
   ,'lectura.lua'
   ,'server_ap.lua'
   ,'server_sta.lua'
   ,'ds18b20.lua'
}
local httpFiles={
   'boton.html'
   ,'contact.lua'
   ,'index.html'
   ,'motion.lua'
   ,'register.lua'
   ,'temp.lua'

}
for i, f in ipairs(serverFiles) do compileAndRemoveIfNeeded(f) end
for i, f in ipairs(httpFiles) do renamehttpfile(f) end

compileAndRemoveIfNeeded = nil
serverFiles = nil
httpFiles = nil
renamehttpfile = nil

collectgarbage()
