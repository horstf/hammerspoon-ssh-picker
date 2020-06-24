local ssh = {}

-- change to name of your terminal if not iTerm (like "Terminal" or "Hyper")
ssh.terminal = "iTerm"

function ssh.readHosts()
    local hostPattern = "Host%s+([%w%.-_]+)"
    local home = os.getenv("HOME")
    local file = io.open(home.."/.ssh/config", "r")
    if not file then return nil end
    local hosts = {}
    for line in file:lines() do
        if line:find(hostPattern) then
            hosts[#hosts+1] = {["text"] = line:match(hostPattern),}
        end
    end
    return hosts
end

function ssh.pickHost()
    local chooser = hs.chooser.new(function(choice)
        if not choice then return end
        local seconds
        
        hs.application.enableSpotlightForNameSearches(true)
        term = hs.application.find(ssh.terminal)

        -- wait 1 second for Terminal to fully activate when not already open
        -- change this to adjust for your terminal startup time
        if term == nil then seconds = 1 else seconds = 0 end

        hs.application.launchOrFocus(ssh.terminal)

        hs.timer.doAfter(seconds, function() 
            hs.eventtap.keyStrokes("ssh "..choice.text.."\n")
        end)

    end)

    chooser:choices(ssh.readHosts())

    chooser:show()
end

return ssh