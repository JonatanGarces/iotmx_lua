return function (connection, req, args)
     dofile("httpserver-header.lc")(connection, 200, 'html')
        node.restart()
        collectgarbage()
end

