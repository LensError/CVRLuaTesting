UnityEngine = require("UnityEngine")

-- Cooldown management
local spawnCooldown = 10.0  -- Cooldown time in seconds
local nextSpawnTime = 0     -- Timestamp of the next allowed spawn

DEBUG = true

local function Debug(message)
    if DEBUG then
      print(message)
    end
  end

-- Function to spawn the object with CVR Interactable LuaFunctionCall
function SpawnObject()
    if UnityEngine.Time.time >= nextSpawnTime then
        local prefabToSpawn = BoundObjects.PrefabToSpawn -- Get the prefab to spawn

        -- Get the object defining the spawn location.
        -- To make it easy to align make an empty, place the empty in the prefab object and 0 all locations and rotations
        -- move the prefab where you want it to spawn and then place the empty in the hierarchy where you want outside of the prefab.
        local spawnLocationObject = BoundObjects.SpawnLocation

        if prefabToSpawn and spawnLocationObject then
            -- Get the spawn position and rotation from the SpawnLocation object's transform
            local spawnPosition = spawnLocationObject.transform.position
            local spawnRotation = spawnLocationObject.transform.rotation

            -- Instantiate the prefab at the spawn location
            UnityEngine.GameObject.Instantiate(prefabToSpawn, spawnPosition, spawnRotation)

            -- Update the next allowed spawn time
            nextSpawnTime = UnityEngine.Time.time + spawnCooldown
        else
            Debug("Either PrefabToSpawn or SpawnLocation is not bound correctly. Please check the CVRLuaClientBehaviour component.")
        end
    else
        Debug("SpawnObject is on cooldown!") -- Optional feedback
    end
end

