# Hammerspoon ssh picker

![Picking a Host](example.gif)

A simple ssh picker for Hammerspoon. This extension reads your defined hosts from your `~/.ssh/config` file and displays them. When pressing enter it launches your terminal and conntects to the host.

## Configuration

The default set Terminal is iTerm, to set another change the `ssh.terminal` variable in the lua file.  
You can use the picker by importing the file and calling the `pickHost` function.  
For example, assuming `sshpicker.lua` is in your `.hammerspoon` directory, add the following lines to your `~/.hammerspoon/init.lua` file:
```lua
local ssh_picker = require("sshpicker.lua")
hs.hotkey.bind({"cmd", "alt"}, "S", ssh_picker.pickHost)
```
Entering `cmd+alt+S` will now display your ssh hosts for you to pick from.

Since some terminals may take a little to start up (mine at least) there is a one second timer set before the ssh command will be executed. If your terminal is faster or slower you can adjust the `seconds` variable in the file to make it work better.
