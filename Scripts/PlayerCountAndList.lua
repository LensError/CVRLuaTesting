UnityEngine = require("UnityEngine")
UI = require("UnityEngine.UI")

local updateTime = 60.0 -- Update time in seconds for player list
local lastUpdateTime = 0.0 -- Tracks the time of the last update (player list)

DEBUG = false

local function Debug(message, ...)
    -- Check DEBUG flag
    if DEBUG then
      -- Concatenate message with any additional arguments using ...
      local fullMessage = message
      for _, arg in ipairs({...}) do
        fullMessage = fullMessage .. tostring(arg) -- Convert arguments to strings
      end
      print(fullMessage)
    end
  end

function Update()
    local currentTime = UnityEngine.Time.time

    -- Update info every 60 seconds
    if currentTime - lastUpdateTime >= updateTime then
      lastUpdateTime = currentTime
      getPlayerCount()
      getplayerList()
    end
end

function getPlayerCount()
    PlayerCount = BoundObjects.PlayerCountText
    if not PlayerCount then
        Debug("Error! PlayerCountText not bound in ChilloutVR inspector.")
        return
      end

    playerCount = PlayerAPI.PlayerCount
    Debug("Player Count: ", playerCount)
    PlayerCount.GetComponent("UnityEngine.UI.Text").text = "Player Count: " .. playerCount
end

function getplayerList()
    PlayerList = BoundObjects.PlayerListText
    if not PlayerList then
        Debug("Error! PlayerListText not bound in ChilloutVR inspector.")
        return
      end

    playerList = {} -- Clear the player list array
  
    for _, player in ipairs(PlayerAPI.AllPlayers) do
      local username = player.Username or "Unknown Player"
      table.insert(playerList, username) -- Add username to the playerList array
    end
  
    Debug("Players in the world:" .. table.concat(playerList, ", "))

    PlayerList.GetComponent("UnityEngine.UI.Text").text = "Players:\n" .. table.concat(playerList, "\n") -- Update player list text with newlines
end