local  function hex_to_char(x)
  return string.char(tonumber(x, 16))
end
local function uri_decode(input)
  return input:gsub("%+", " "):gsub("%%(%x%x)", hex_to_char)
end
return function(request)
local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP")
if(method == nil)then
    _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP")
end
local _GET = {}
    if (vars ~= nil)then
        for kv in vars.gmatch(vars, "%s*&?([^=]+=[^&]+)") do
        local key, value = string.match(kv, "(.*)=(.*)")
            if(uri_decode(value) == nil) then
            _GET[key] =""
            else
            _GET[key] = uri_decode(value)
            end   
        end
    end
    return _GET
end