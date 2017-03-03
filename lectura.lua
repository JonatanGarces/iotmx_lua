return function (html)
local begining = 0
local middle  = 0
local ending = 0
local line = ""
local ssid_ =""
local pass_ = ""
local str = ""
local t={}
files = file.list()
if(files["db.txt"]) then
	file.open("db.txt","r")	
	str=file.read()
	str:gsub("(.-)\r?\n",function(c) table.insert(t,c) end)
	if t  ~= nil then
		for i=1,1 do
			line = t[i] 
			if line== nil or line == "" then
			table.insert(html,"")
			table.insert(html,"")
			break
			else
			ending = string.len(line)
			middle = string.find(line, "|")
			ssid_  = string.sub(line,begining,middle-1)
			pass_  = string.sub(line,middle+1,ending)
			table.insert(html,ssid_)
			table.insert(html,pass_)
			end
		end
	else
		table.insert(html,"")
		table.insert(html,"")
	end
	file.close()
	tmr.wdclr()
end
collectgarbage()
return html
end