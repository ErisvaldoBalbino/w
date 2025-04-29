if not game:IsLoaded() then
    game.Loaded:Wait()
end

if _G.UILOADED then 
    return 
end

_G.UILOADED = true

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local VirtualInputManager = game:GetService("VirtualInputManager")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game.Workspace
local Players = game.Players
local player = Players.LocalPlayer

spawn(function()
    while true do
        pcall(function()
            VirtualInputManager:SendKeyEvent(true, 101, false, game)
            task.wait(0.1)
            VirtualInputManager:SendKeyEvent(false, 101, false, game)
        end)
        task.wait(120)
    end
end)

local Window = Fluent:CreateWindow({
    Title = "Anime Kingdom",
    SubTitle = "twvz",
    TabWidth = 100,
    Size = UDim2.fromOffset(480, 360),
    Acrylic = false,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    Infos = Window:AddTab({ Title = "Infos", Icon = "info" }),
    Setup = Window:AddTab({ Title = "Setup", Icon = "banana" }),
    Main = Window:AddTab({ Title = "Main", Icon = "loader" }),
    Easter = Window:AddTab({ Title = "Easter", Icon = "egg" }),
    Raid = Window:AddTab({ Title = "Raid", Icon = "swords" }),
    Dungeon = Window:AddTab({ Title = "Dungeon", Icon = "sword" }),
    Portal = Window:AddTab({ Title = "Portal", Icon = "target" }),
    Teleport = Window:AddTab({ Title = "Teleport", Icon = "map-pin" }),
    Roll = Window:AddTab({ Title = "Roll", Icon = "user" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" }),
}

local Options = Fluent.Options

task.wait(0.1)

getgenv().Settings = {
    DefaultDelay = 0.5,
    MinDelay = 0.1,
    MaxDelay = 5
}

local worldList = {
    "Slayer Town",
    "Giant District",
    "ABC City",
    "Cursed School",
    "Leveling Town",
    "Sand Empire",
    "Bizarre Desert"
}

local starList = {
    "Slayer Star",
    "Titan Star",
    "Punch Star",
    "Cursed Star",
    "Player Star",
    "Pirate Star",
    "Bizarre Star"
}

local worldMap = {
    [1] = "Slayer Town",
    [2] = "Giant District",
    [3] = "ABC City",
    [4] = "Cursed School",
    [5] = "Leveling Town",
    [6] = "Sand Empire",
    [7] = "Bizarre Desert"
}

local enemyList = {
    ["Slayer Town"] = {
        { Id = "Muzan", Name = "First Demon" },
        { Id = "Kokushibo", Name = "Upper Moon One" },
        { Id = "Douma", Name = "Upper Moon Two" },
        { Id = "Akaza", Name = "Upper Moon Three" },
        { Id = "Gyutaro", Name = "Upper Moon Six" },
        { Id = "Gyomei", Name = "Pillar of Stone [SECRET]"}
    },
    ["Giant District"] = {
        { Id = "ColossalTitan", Name = "Colossal Giant" },
        { Id = "BeastTitan", Name = "Beast Giant" },
        { Id = "ArmoredTitan", Name = "Armored Giant" },
        { Id = "FemaleTitan", Name = "Female Giant" },
        { Id = "JawTitan", Name = "Jaw Giant" },
        { Id = "YoungEren", Name = "Young Rogue [SECRET]"}
    },
    ["ABC City"] = {
        { Id = "Boros", Name = "The Alien" },
        { Id = "SeaKing", Name = "Sea King" },
        { Id = "Mosquito", Name = "Mosquito Girl" },
        { Id = "VaccineMan", Name = "Monster Man" },
        { Id = "Crab", Name = "Crab Man" },
        { Id = "Saitama", Name = "Caped Baldy [SECRET]"}
    },
    ["Cursed School"] = {
        { Id = "Sukuna", Name = "King of Curses" },
        { Id = "SuguruGeto", Name = "Curse Collector" },
        { Id = "Mahito", Name = "Sinister Hands" },
        { Id = "Jogo", Name = "Volcanic Wrath" },
        { Id = "Hanami", Name = "Floral Demon" },
        { Id = "Gojo", Name = "Strongest Sorcerer [SECRET]"}
    },
    ["Leveling Town"] = {
        { Id = "Antares", Name = "Strongest Monarch" },
        { Id = "Querehsha", Name = "Monarch of Plagues" },
        { Id = "Tarnak", Name = "Monarch of Iron Body" },
        { Id = "LiuZhigang", Name = "2nd Strongest Hunter" },
        { Id = "ChristopherReed", Name = "3rd Strongest Hunter" },
        { Id = "Beru", Name = "Ant King [SECRET]"}
    },
    ["Sand Empire"] = {
        { Id = "Crocodile", Name = "Mr. 0" },
        { Id = "DazBonez", Name = "Mr. 1" },
        { Id = "Bentham", Name = "Mr. 2" },
        { Id = "Galdino", Name = "Mr. 3" },
        { Id = "Babe", Name = "Mr. 4" },
        { Id = "Mihawk", Name = "Hawk Eyes [SECRET]"}
    },
    ["Bizarre Desert"] = {
        { Id = "Wamuu", Name = "3rd Pillar Man"},
        { Id = "Esidisi", Name = "2nd Pillar Man"},
        { Id = "Pucci", Name = "Whitesnake"},
        { Id = "Kars", Name = "1st Pillar Man"},
        { Id = "DioBrando", Name = "Vampire"},
        { Id = "DioOverHeaven", Name = "Vampire (Over Heaven)" }
    }
}

local dungeonMapList = { "RuinedPrison" }
local dungeonDifficultyList = { "Easy", "Medium", "Hard", "Insane", "Extreme", "Impossible" }

local dataRemoteEvent = ReplicatedStorage
    :WaitForChild("ffrostflame_bridgenet2@1.0.0")
    :WaitForChild("dataRemoteEvent")

_G.GetPlayerRoot = function()
    return player.Character and player.Character:FindFirstChild("HumanoidRootPart")
end

_G.currentWorldNumber = function()
    local mapFolder = workspace:FindFirstChild("_MAP")
    if mapFolder then
        for _, worldFolder in pairs(mapFolder:GetChildren()) do
            if worldFolder:FindFirstChild("Spawn") and worldFolder.Spawn:IsA("BasePart") then
                local worldNum = tonumber(worldFolder.Name)
                if worldNum and worldMap[worldNum] then
                    return worldNum
                end
            end
        end
    end
    return nil
end

_G.GetWorldName = function(worldNumber)
    return worldMap[worldNumber]
end

_G.GetWorldNumberFromName = function(worldName)
    for index, name in pairs(worldMap) do
        if name == worldName then
            return index
        end
    end
    return nil
end

_G.getMode = function()
    local modeAtt = player:GetAttribute("Mode")
    if modeAtt == "Raid" then
        return "Raid"
    elseif modeAtt == "Dungeon" then
        return "Dungeon"
    elseif modeAtt == "Portal" then
        return "Portal"
    elseif modeAtt == "EasterInvasion" then
        return "EasterInvasion"
    else
        return "None"
    end
end

_G.FindNearestMob = function(selectedMobNames, playerRoot)
    local nearestPart = nil
    local shortestDistance = math.huge

    local worldNumber = _G.currentWorldNumber()
    if not worldNumber then return nil, math.huge end

    local enemyServerFolder = workspace._ENEMIES.Server:FindFirstChild(tostring(worldNumber))
    if not enemyServerFolder then return nil, math.huge end

    local selectedMobIds = {}
    local worldName = Options.WorldDropdown.Value
    if enemyList[worldName] then
        for _, mob in ipairs(enemyList[worldName]) do
            if selectedMobNames[mob.Name] then
                selectedMobIds[mob.Id] = true
            end
        end
    end

    for _, part in pairs(enemyServerFolder:GetChildren()) do
        local hp = part:GetAttribute("HP")
        local enemyType = part:GetAttribute("Id")

        if enemyType and hp and hp > 0 then
            if selectedMobIds[enemyType] then
                local distance = (playerRoot.Position - part.Position).Magnitude
                if distance < shortestDistance then
                    shortestDistance = distance
                    nearestPart = part
                end
            end
        end
    end

    return nearestPart, shortestDistance
end

_G.RollRemote = function(starName, quant)
    local args = {
        [1] = {
            [1] = {
                [1] = "PetSystem",
                [2] = "Open",
                [3] = starName,
                [4] = quant or "One",
                ["n"] = 4
            },
            [2] = "\2"
        }
    }
    pcall(dataRemoteEvent.FireServer, dataRemoteEvent, unpack(args))
end

_G.TeleportPetsToEnemy = function(enemyPart)
    if not enemyPart then return end
    local rootPart = _G.GetPlayerRoot()
    if not rootPart then return end
    if (enemyPart.Position - rootPart.Position).Magnitude < 5 then return end

    if not _G.CachedPetUUIDs then
        _G.UpdatePetCache()
    end

    if (rootPart.Position - enemyPart.Position).Magnitude > 20 then return end

    for _, petId in ipairs(_G.CachedPetUUIDs or {}) do
        local args = {
            [1] = {
                [1] = {
                    [1] = "PetSystem",
                    [2] = "Equip",
                    [3] = petId,
                    [4] = true,
                    ["n"] = 4
                },
                [2] = "\2"
            }
        }
        pcall(dataRemoteEvent.FireServer, dataRemoteEvent, unpack(args))
        task.wait(0.01)
    end

    task.wait(0.05)

    local args = {
        [1] = {
            [1] = {
                [1] = "PetSystem",
                [2] = "EquipBest",
                ["n"] = 2
            },
            [2] = "\2"
        }
    }
    pcall(dataRemoteEvent.FireServer, dataRemoteEvent, unpack(args))
end

_G.UpdatePetCache = function()
    _G.CachedPetUUIDs = {}
    
    local playerPetsFolder = workspace._PETS:FindFirstChild(player.UserId)
    if not playerPetsFolder then return end

    for _, petFolder in pairs(playerPetsFolder:GetChildren()) do
        local petUUID = petFolder.Name
        if petUUID then
            table.insert(_G.CachedPetUUIDs, petUUID)
        end
    end
end

_G.AutoRollPetsLoop = function()
    while Options.AutoRollPets.Value do
        local starName = tostring(Options.RollStarDropdown.Value)
        local rollType = tostring(Options.RollTypeDropdown.Value)
        _G.RollRemote(starName, rollType)
        task.wait()
    end
end

_G.AutoFarmLoop = function()
    while Options.AutoFarm.Value do
        local rootPart = _G.GetPlayerRoot()
        if not rootPart then task.wait(1); continue end

        local inMode = _G.getMode()
        if inMode == "Raid" or inMode == "Dungeon" or inMode == "Portal" or inMode == "EasterInvasion" then
            task.wait(2);
            continue
        end

        local selectedWorldName = Options.WorldDropdown.Value
        local selectedWorldNumber = _G.GetWorldNumberFromName(selectedWorldName)
        local selectedMobs = Options.MobDropdown.Value
        local currentWorldNumber = _G.currentWorldNumber()
        local farmMode = Options.FarmModeDropdown.Value or "Teleport"

        if currentWorldNumber ~= selectedWorldNumber then
            task.wait(1)
            continue
        end

        if selectedMobs and type(selectedMobs) == "table" and next(selectedMobs) ~= nil then
            local nearestMob, distance = _G.FindNearestMob(selectedMobs, rootPart)

            if nearestMob and nearestMob.Parent and not (nearestMob:GetAttribute("Dead") or nearestMob:GetAttribute("HP") <= 0) then
                local enemyUuid = nearestMob.Name
                local needsToMove = distance > 8
                local moveSuccess = true

                if needsToMove then
                    if farmMode == "Teleport" then
                        pcall(function() rootPart.CFrame = CFrame.new(nearestMob.Position + Vector3.new(0, 3, 5)) end)
                        task.wait(0.15)
                        if (rootPart.Position - nearestMob.Position).Magnitude > 20 then moveSuccess = false end
                    elseif farmMode == "No Move" and distance > Options.FarmRangeSlider.Value then
                        moveSuccess = false
                    end
                end

                local petTargeting = false
                local playerPetsFolder = workspace._PETS:FindFirstChild(player.UserId)
                if playerPetsFolder then
                    for _, petFolder in pairs(playerPetsFolder:GetChildren()) do
                        if petFolder:GetAttribute("Target") == enemyUuid then petTargeting = true; break end
                    end
                end

                if moveSuccess and not petTargeting then
                    if Options.AutoTeleportPets.Value then
                        _G.TeleportPetsToEnemy(nearestMob)
                        task.wait(0.05)
                    end
                    local args = {
                        [1] = {
                            [1] = {
                                [1] = "PetSystem",
                                [2] = "Attack",
                                [3] = enemyUuid,
                                [4] = true,
                                ["n"] = 4
                            },
                            [2] = "\2"
                        }
                    }
                    pcall(dataRemoteEvent.FireServer, dataRemoteEvent, unpack(args))
                end
            end
        end
        task.wait(Options.AutoFarmDelaySlider.Value)
    end
end

_G.AutoRaidLoop = function()
    local priority = Options.AutomationPriority.Value

    if not _G.SavedWorldPosition then
        local rootPart = _G.GetPlayerRoot()
        if rootPart then
            _G.SavedWorldPosition = rootPart.CFrame
            _G.SavedWorld = _G.currentWorldNumber()
            _G.UpdateSavedPositionButtons()
        end
    elseif not _G.SavedWorld then
         _G.SavedWorld = _G.currentWorldNumber()
    end

    local wasInRaid = false
    local enemiesFolder = Workspace:FindFirstChild("_ENEMIES")

    while Options.AutoRaid.Value do
        local rootPart = _G.GetPlayerRoot()
        if not rootPart then task.wait(1); continue end

        local currentMode = _G.getMode()

        if wasInRaid and currentMode ~= "Raid" then
            if _G.SavedWorld and _G.SavedWorldPosition then
                local args = {
                    [1] = {
                        [1] = {
                            [1] = "TeleportSystem",
                            [2] = "To",
                            [3] = _G.SavedWorld,
                            ["n"] = 3
                        },
                        [2] = "\2"
                    }
                }
                pcall(dataRemoteEvent.FireServer, dataRemoteEvent, unpack(args))
                task.wait(2)
                rootPart = _G.GetPlayerRoot()
                if rootPart then pcall(function() rootPart.CFrame = _G.SavedWorldPosition end) end
            end
            task.wait(3)
            wasInRaid = false
            if not _G.CreateAndStartRaid() then task.wait(5) end
            continue
        end

        if currentMode ~= "Raid" then
             if not _G.CreateAndStartRaid() then task.wait(5) end
             task.wait(2)
             continue
        end

        wasInRaid = true
        local playerId = tostring(player.UserId)
        local currentPosition = rootPart.Position
        local raidFolder = enemiesFolder and enemiesFolder.Server and enemiesFolder.Server.Raid and enemiesFolder.Server.Raid:FindFirstChild(playerId)

        if not raidFolder or #raidFolder:GetChildren() == 0 then
            task.wait(0.5)
            continue
        end

        local bossEnemy, bossHasShield = nil, false
        for _, mob in ipairs(raidFolder:GetChildren()) do
            if mob:IsA("BasePart") and mob:GetAttribute("Shield") ~= nil then
                bossEnemy = mob
                bossHasShield = mob:GetAttribute("Shield") == true
                break
            end
        end

        local validTargets = {}
        if bossHasShield then
            for _, mob in ipairs(raidFolder:GetChildren()) do
                if mob:IsA("BasePart") and mob ~= bossEnemy and mob:GetAttribute("Dead") == false and (mob:GetAttribute("HP") or 0) > 0 then
                    table.insert(validTargets, mob)
                end
            end
        else
             if bossEnemy and bossEnemy:GetAttribute("Dead") == false and (bossEnemy:GetAttribute("HP") or 0) > 0 then
                 table.insert(validTargets, bossEnemy)
             end
             for _, mob in ipairs(raidFolder:GetChildren()) do
                 if mob:IsA("BasePart") and mob ~= bossEnemy and mob:GetAttribute("Dead") == false and (mob:GetAttribute("HP") or 0) > 0 then
                     table.insert(validTargets, mob)
                 end
             end
        end

        local nearestEnemy, shortestDistance = nil, math.huge
        for _, enemy in ipairs(validTargets) do
            local distance = (currentPosition - enemy.Position).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                nearestEnemy = enemy
            end
        end

        if nearestEnemy and nearestEnemy.Parent and not (nearestEnemy:GetAttribute("Dead") or nearestEnemy:GetAttribute("HP") <= 0) then
            local enemyUuid = nearestEnemy.Name
            local needsToMove = shortestDistance > 8
            local moveSuccess = true

            if needsToMove then
                pcall(function() rootPart.CFrame = CFrame.new(nearestEnemy.Position + Vector3.new(0, 3, 5)) end)
                task.wait(0.15)
                if (rootPart.Position - nearestEnemy.Position).Magnitude > 20 then moveSuccess = false end
            end

            local petTargeting = false
            local playerPetsFolder = workspace._PETS:FindFirstChild(player.UserId)
            if playerPetsFolder then
                for _, petFolder in pairs(playerPetsFolder:GetChildren()) do
                    if petFolder:GetAttribute("Target") == enemyUuid then petTargeting = true; break end
                end
            end

            if moveSuccess and not petTargeting then
                if Options.AutoTeleportPets.Value then
                    _G.TeleportPetsToEnemy(nearestEnemy)
                    task.wait(0.05)
                end
                local args = {
                    [1] = {
                        [1] = {
                            [1] = "PetSystem",
                            [2] = "Attack",
                            [3] = enemyUuid,
                            [4] = true,
                            ["n"] = 4
                        },
                        [2] = "\2"
                    }
                }
                pcall(dataRemoteEvent.FireServer, dataRemoteEvent, unpack(args))
            end
        else
            task.wait(0.5)
        end

        task.wait(0.3)
    end
end

_G.AutoDungeonLoop = function()
    local wasInDungeon = false
    local enemiesFolder = Workspace:FindFirstChild("_ENEMIES")

    while Options.AutoDungeonToggle.Value do
        local rootPart = _G.GetPlayerRoot()
        if not rootPart then task.wait(1); continue end

        local currentMode = _G.getMode()

        if wasInDungeon and currentMode ~= "Dungeon" then
            if _G.SavedWorld and _G.SavedWorldPosition then
                local args = {
                    [1] = {
                        [1] = {
                            [1] = "TeleportSystem",
                            [2] = "To",
                            [3] = _G.SavedWorld,
                            ["n"] = 3
                        },
                        [2] = "\2"
                    }
                }
                pcall(dataRemoteEvent.FireServer, dataRemoteEvent, unpack(args))
                task.wait(2)
                rootPart = _G.GetPlayerRoot()
                if rootPart then pcall(function() rootPart.CFrame = _G.SavedWorldPosition end) end
            end
            task.wait(5)
            wasInDungeon = false
            if not _G.CreateAndStartDungeon() then task.wait(10) end
            continue
        end

        if currentMode ~= "Dungeon" then
             if not _G.CreateAndStartDungeon() then task.wait(10) end
             task.wait(5)
             continue
        end

        wasInDungeon = true
        local playerId = tostring(player.UserId)
        local currentPosition = rootPart.Position

        local dungeonFolder = enemiesFolder and enemiesFolder.Server and enemiesFolder.Server.Dungeon and enemiesFolder.Server.Dungeon:FindFirstChild(playerId)

        if not dungeonFolder or #dungeonFolder:GetChildren() == 0 then
            task.wait(1.5)
            continue
        end

        local nearestEnemy, shortestDistance = _G.FindNearestDungeonEnemy(rootPart)

        if nearestEnemy and nearestEnemy.Parent and not (nearestEnemy:GetAttribute("Dead") or nearestEnemy:GetAttribute("HP") <= 0) then
            local enemyUuid = nearestEnemy.Name
            local needsToMove = shortestDistance > 8
            local moveSuccess = true
            local farmMode = Options.FarmModeDropdown.Value or "Teleport"

            if needsToMove then
                pcall(function() rootPart.CFrame = CFrame.new(nearestEnemy.Position + Vector3.new(0, 3, 5)) end)
                task.wait(0.15)
                if (rootPart.Position - nearestEnemy.Position).Magnitude > 20 then moveSuccess = false end
            end

            local petTargeting = false
            local playerPetsFolder = workspace._PETS:FindFirstChild(player.UserId)
            if playerPetsFolder then
                for _, petFolder in pairs(playerPetsFolder:GetChildren()) do
                    if petFolder:GetAttribute("Target") == enemyUuid then petTargeting = true; break end
                end
            end

            if moveSuccess and not petTargeting then
                if Options.AutoTeleportPets.Value then
                    _G.TeleportPetsToEnemy(nearestEnemy)
                    task.wait(0.05)
                end
                local args = {
                    [1] = {
                        [1] = {
                            [1] = "PetSystem",
                            [2] = "Attack",
                            [3] = enemyUuid,
                            [4] = true,
                            ["n"] = 4
                        },
                        [2] = "\2"
                    }
                }
                pcall(dataRemoteEvent.FireServer, dataRemoteEvent, unpack(args))
            end
        else
            task.wait(0.5)
        end

        local leaveOnStageStr = Options.LeaveOnStageDropdown.Value
        if leaveOnStageStr ~= "None" then
            local targetStage = tonumber(leaveOnStageStr)
            if targetStage then
                local currentStage = _G.GetCurrentDungeonStage()

                if currentStage >= targetStage then
                    if _G.SavedWorld and _G.SavedWorldPosition then
                        local args = {
                            [1] = {
                                [1] = {
                                    [1] = "TeleportSystem",
                                    [2] = "To",
                                    [3] = _G.SavedWorld,
                                    ["n"] = 3
                                },
                                [2] = "\2"
                            }
                        }
                        pcall(dataRemoteEvent.FireServer, dataRemoteEvent, unpack(args))
                        task.wait(3)
                        rootPart = _G.GetPlayerRoot()
                        if rootPart then pcall(function() rootPart.CFrame = _G.SavedWorldPosition end) end
                    end

                    wasInDungeon = false
                    if not _G.CreateAndStartDungeon() then task.wait(10) end
                    continue
                end
            end
        end

        task.wait(0.3)

    end
end


_G.CreateAndStartDungeon = function()
    if _G.getMode() == "Dungeon" then return false end

    local createArgs = {
        [1] = {
            [1] = {
                [1] = "DungeonSystem",
                [2] = "Create",
                ["n"] = 2
            },
            [2] = "\2"
        }
    }
    pcall(dataRemoteEvent.FireServer, dataRemoteEvent, unpack(createArgs))
    task.wait(0.5)

    local selectedMap = Options.DungeonMapDropdown.Value
    local selectMapArgs = {
        [1] = {
            [1] = {
                [1] = "DungeonSystem",
                [2] = "SelectMap",
                [3] = selectedMap,
                ["n"] = 3
            },
            [2] = "\2"
        }
    }
    pcall(dataRemoteEvent.FireServer, dataRemoteEvent, unpack(selectMapArgs))
    task.wait(0.5)

    if Options.PrivateDungeon.Value then
        local privateArgs = {
            [1] = {
                [1] = {
                    [1] = "DungeonSystem",
                    [2] = "MakePrivate",
                    ["n"] = 2
                },
                [2] = "\2"
            }
        }
        pcall(dataRemoteEvent.FireServer, dataRemoteEvent, unpack(privateArgs))
        task.wait(0.5)
    end

    local selectedDifficulty = Options.DungeonDifficultyDropdown.Value
    local selectDiffArgs = {
        [1] = {
            [1] = {
                [1] = "DungeonSystem",
                [2] = "SelectDiff",
                [3] = selectedDifficulty,
                ["n"] = 3
            },
            [2] = "\2"
        }
    }
    pcall(dataRemoteEvent.FireServer, dataRemoteEvent, unpack(selectDiffArgs))
    task.wait(0.5)

    local startArgs = {
        [1] = {
            [1] = {
                [1] = "DungeonSystem",
                [2] = "Start",
                ["n"] = 2
            },
            [2] = "\2"
        }
    }
    pcall(dataRemoteEvent.FireServer, dataRemoteEvent, unpack(startArgs))
    task.wait(7)

    return _G.getMode() == "Dungeon"
end

_G.FindNearestDungeonEnemy = function(playerRoot)
    local nearestEnemy = nil
    local shortestDistance = math.huge
    local playerId = tostring(player.UserId)

    local dungeonFolder = Workspace._ENEMIES.Server.Dungeon:FindFirstChild(playerId)
    if dungeonFolder then
        for _, enemy in pairs(dungeonFolder:GetChildren()) do
            if enemy:IsA("BasePart") and not (enemy:GetAttribute("Dead") or (enemy:GetAttribute("HP") or 0) <= 0) then
                local distance = (playerRoot.Position - enemy.Position).Magnitude
                if distance < shortestDistance then
                    shortestDistance = distance
                    nearestEnemy = enemy
                end
            end
        end
    end

    return nearestEnemy, shortestDistance
end

_G.SavedWorldPosition = nil
_G.SavedWorld = nil

_G.LoadSavedPosition = function()
    local success, fileContent = pcall(readfile, "twvz_kingdom_pos.txt")
    if success and fileContent and fileContent ~= "" then
        local success2, positionData = pcall(HttpService.JSONDecode, HttpService, fileContent)
        if success2 and positionData and positionData.World and positionData.CFrame then
            _G.SavedWorld = positionData.World
            local cf = positionData.CFrame
            _G.SavedWorldPosition = CFrame.new(cf.X, cf.Y, cf.Z) * CFrame.fromEulerAnglesXYZ(cf.RX or 0, cf.RY or 0, cf.RZ or 0)
            return true
        end
    end
    return false
end

_G.UpdateSavedPositionButtons = function()
    local worldName = "None"
    local posStr = "None"
    if _G.SavedWorld and _G.SavedWorldPosition then
        worldName = _G.GetWorldName(_G.SavedWorld) or ("World " .. _G.SavedWorld)
        local pos = _G.SavedWorldPosition.Position
        posStr = string.format("X: %.1f, Y: %.1f, Z: %.1f", pos.X, pos.Y, pos.Z)
    end
    local positionText = "World: " .. worldName .. "\nPosition: " .. posStr
    if Options.SavePositionButton then
        pcall(Options.SavePositionButton.SetDesc, Options.SavePositionButton, positionText)
    end
end

local function createStageList()
    local stages = {"None"}
    for i = 1, 50 do
        table.insert(stages, tostring(i))
    end
    return stages
end

local function createWaveList()
    local waves = {"None"}
    for i = 1, 100 do
        table.insert(waves, tostring(i))
    end
    return waves
end


_G.GetCurrentEasterStage = function()
    local waveNumber = 0
    local success, result = pcall(function()
        local playerGui = player:FindFirstChild("PlayerGui")
        local modeGui = playerGui and playerGui:FindFirstChild("Mode")
        local content = modeGui and modeGui:FindFirstChild("Content")
        local easterUi = content and content:FindFirstChild("EasterInvasion")
        local startUi = easterUi and easterUi:FindFirstChild("Start")
        local label = startUi and startUi:FindFirstChild("Label")

        if label and label:IsA("TextLabel") then
            local text = label.Text
            local numStr = string.match(text, "Wave:%s*(%d+)")
            if numStr then
                waveNumber = tonumber(numStr) or 0
            end
        end
    end)

    if not success then
        return 0
    end

    return waveNumber
end

_G.FindNearestEasterEnemy = function(playerRoot)
    local nearestEnemy = nil
    local shortestDistance = math.huge
    local playerId = tostring(player.UserId)
    local serverEnemiesFolder = Workspace._ENEMIES.Server

    if not serverEnemiesFolder then return nil, math.huge end

    local easterFolder = serverEnemiesFolder:FindFirstChild("EasterInvasion")
    if not easterFolder then return nil, math.huge end
    
    local playerEasterFolder = easterFolder:FindFirstChild(playerId)
    if not playerEasterFolder then return nil, math.huge end
    
    for _, enemy in pairs(playerEasterFolder:GetChildren()) do
        if enemy:IsA("BasePart") and not (enemy:GetAttribute("Dead") or (enemy:GetAttribute("HP") or 0) <= 0) then
            local distance = (playerRoot.Position - enemy.Position).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                nearestEnemy = enemy
            end
        end
    end

    return nearestEnemy, shortestDistance
end

_G.CreateAndStartEaster = function()
    if _G.getMode() == "EasterInvasion" then return false end

    local createArgs = {
        [1] = {
            [1] = {
                [1] = "EasterInvasionSystem",
                [2] = "Create",
                ["n"] = 2
            },
            [2] = "\2"
        }
    }
    pcall(dataRemoteEvent.FireServer, dataRemoteEvent, unpack(createArgs))
    task.wait(1.5)

    if Options.PrivateEaster and Options.PrivateEaster.Value then
        local privateArgs = {
            [1] = {
                [1] = {
                    [1] = "EasterInvasionSystem",
                    [2] = "MakePrivate",
                    ["n"] = 2
                },
                [2] = "\2"
            }
        }
        pcall(dataRemoteEvent.FireServer, dataRemoteEvent, unpack(privateArgs))
        task.wait(1)
    end

    local startArgs = {
        [1] = {
            [1] = {
                [1] = "EasterInvasionSystem",
                [2] = "Start",
                ["n"] = 2
            },
            [2] = "\2"
        }
    }
    pcall(dataRemoteEvent.FireServer, dataRemoteEvent, unpack(startArgs))
    task.wait(6)

    return _G.getMode() == "EasterInvasion"
end

_G.AutoEasterLoop = function()
    local wasInEaster = false
    local enemiesFolder = Workspace:FindFirstChild("_ENEMIES")

    while Options.AutoEasterToggle.Value do
        local rootPart = _G.GetPlayerRoot()
        if not rootPart then
            task.wait(1); continue
        end

        local currentMode = _G.getMode()

        if wasInEaster and currentMode ~= "EasterInvasion" then
            if _G.SavedWorld and _G.SavedWorldPosition then
                local args = {
                    [1] = {
                        [1] = {
                            [1] = "TeleportSystem",
                            [2] = "To",
                            [3] = _G.SavedWorld,
                            ["n"] = 3
                        },
                        [2] = "\2"
                    }
                }
                pcall(dataRemoteEvent.FireServer, dataRemoteEvent, unpack(args))
                task.wait(2)
                rootPart = _G.GetPlayerRoot()
                if rootPart then pcall(function() rootPart.CFrame = _G.SavedWorldPosition end) end
            end
            task.wait(5)
            wasInEaster = false
            if not _G.CreateAndStartEaster() then task.wait(10) end
            continue
        end

        if currentMode ~= "EasterInvasion" then
             if not _G.CreateAndStartEaster() then task.wait(10) end
             task.wait(5)
             continue
        end

        wasInEaster = true
        local playerId = tostring(player.UserId)
        local currentPosition = rootPart.Position

        local easterFolder = enemiesFolder and enemiesFolder.Server and enemiesFolder.Server.EasterInvasion
        local playerEasterFolder = easterFolder and easterFolder:FindFirstChild(playerId)

        if not playerEasterFolder then
             task.wait(1.5)
             continue
        elseif #playerEasterFolder:GetChildren() == 0 then
             task.wait(1.5)
             continue
        end

        local nearestEnemy, shortestDistance = _G.FindNearestEasterEnemy(rootPart)

        if nearestEnemy then
             if nearestEnemy.Parent and not (nearestEnemy:GetAttribute("Dead") or nearestEnemy:GetAttribute("HP") <= 0) then
                local enemyUuid = nearestEnemy.Name
                local needsToMove = shortestDistance > 8
                local moveSuccess = true
                local farmMode = Options.FarmModeDropdown.Value or "Teleport"

                if needsToMove then
                    pcall(function() rootPart.CFrame = CFrame.new(nearestEnemy.Position + Vector3.new(0, 3, 5)) end)
                    task.wait(0.15)
                    if (rootPart.Position - nearestEnemy.Position).Magnitude > 20 then moveSuccess = false end
                end

                local petTargeting = false
                local playerPetsFolder = workspace._PETS:FindFirstChild(player.UserId)
                if playerPetsFolder then
                    for _, petFolder in pairs(playerPetsFolder:GetChildren()) do
                        if petFolder:GetAttribute("Target") == enemyUuid then
                            petTargeting = true
                            break
                        end
                    end
                end

                if moveSuccess and not petTargeting then
                    if Options.AutoTeleportPets.Value then
                        _G.TeleportPetsToEnemy(nearestEnemy)
                        task.wait(0.05)
                    end
                    local args = {
                        [1] = {
                            [1] = {
                                [1] = "PetSystem",
                                [2] = "Attack",
                                [3] = enemyUuid,
                                [4] = true,
                                ["n"] = 4
                            },
                            [2] = "\2"
                        }
                    }
                    pcall(dataRemoteEvent.FireServer, dataRemoteEvent, unpack(args))
                end
            else
                 task.wait(0.1)
            end
        else
            task.wait(0.5)
        end

        local leaveOnWaveStr = Options.LeaveOnEasterWaveDropdown.Value
        if leaveOnWaveStr ~= "None" then
            local targetWave = tonumber(leaveOnWaveStr)
            if targetWave then
                local currentWave = _G.GetCurrentEasterStage()

                if currentWave >= targetWave then
                    if _G.SavedWorld and _G.SavedWorldPosition then
                        local args = {
                            [1] = {
                                [1] = {
                                    [1] = "TeleportSystem",
                                    [2] = "To",
                                    [3] = _G.SavedWorld,
                                    ["n"] = 3
                                },
                                [2] = "\2"
                            }
                        }
                        pcall(dataRemoteEvent.FireServer, dataRemoteEvent, unpack(args))
                        task.wait(3)
                        rootPart = _G.GetPlayerRoot()
                        if rootPart then pcall(function() rootPart.CFrame = _G.SavedWorldPosition end) end
                    end

                    wasInEaster = false
                    if not _G.CreateAndStartEaster() then task.wait(10) end
                    continue
                end
            end
        end

        task.wait(Options.AutoFarmDelaySlider.Value)
    end
end

_G.GetCurrentDungeonStage = function()
    local stageNumber = 0
    local success, result = pcall(function()
        local playerGui = player:FindFirstChild("PlayerGui")
        local modeGui = playerGui and playerGui:FindFirstChild("Mode")
        local content = modeGui and modeGui:FindFirstChild("Content")
        local dungeonUi = content and content:FindFirstChild("Dungeon")
        local startUi = dungeonUi and dungeonUi:FindFirstChild("Start")
        local label = startUi and startUi:FindFirstChild("Label")

        if label and label:IsA("TextLabel") then
            local text = label.Text
            local numStr = string.match(text, "Stage:%s*(%d+)")
            if numStr then
                stageNumber = tonumber(numStr) or 0
            end
        end
    end)

    if not success then
        return 0
    end

    return stageNumber
end

_G.GetCurrentPortalStage = function()
    local stageNumber = 0
    local success, result = pcall(function()
        local playerGui = player:FindFirstChild("PlayerGui")
        local modeGui = playerGui and playerGui:FindFirstChild("Mode")
        local content = modeGui and modeGui:FindFirstChild("Content")
        local portalUi = content and content:FindFirstChild("Portal")
        local startUi = portalUi and portalUi:FindFirstChild("Start")
        local label = startUi and startUi:FindFirstChild("Label")

        if label and label:IsA("TextLabel") then
            local text = label.Text
            local numStr = string.match(text, "Wave:%s*(%d+)")
            if numStr then
                stageNumber = tonumber(numStr) or 0
            end
        end
    end)

    if not success then
        return 0
    end

    return stageNumber
end

_G.CreateAndStartRaid = function()
    if _G.getMode() == "Raid" then return false end

    local createArgs = {
        [1] = {
            [1] = {
                [1] = "RaidSystem",
                [2] = "Create",
                ["n"] = 2
            },
            [2] = "\2"
        }
    }
    pcall(dataRemoteEvent.FireServer, dataRemoteEvent, unpack(createArgs))
    task.wait(0.5)

    local selectedWorldName = Options.RaidWorldDropdown.Value
    local worldNumber = _G.GetWorldNumberFromName(selectedWorldName)
    if not worldNumber then
        return false
    end

    local selectMapArgs = {
        [1] = {
            [1] = {
                [1] = "RaidSystem",
                [2] = "SelectMap",
                [3] = worldNumber,
                ["n"] = 3
            },
            [2] = "\2"
        }
    }
    pcall(dataRemoteEvent.FireServer, dataRemoteEvent, unpack(selectMapArgs))
    task.wait(0.5)

    if Options.PrivateRaid.Value then
        local privateArgs = {
            [1] = {
                [1] = {
                    [1] = "RaidSystem",
                    [2] = "MakePrivate",
                    ["n"] = 2
                },
                [2] = "\2"
            }
        }
        pcall(dataRemoteEvent.FireServer, dataRemoteEvent, unpack(privateArgs))
        task.wait(0.5)
    end

    local startArgs = {
        [1] = {
            [1] = {
                [1] = "RaidSystem",
                [2] = "Start",
                ["n"] = 2
            },
            [2] = "\2"
        }
    }
    pcall(dataRemoteEvent.FireServer, dataRemoteEvent, unpack(startArgs))
    task.wait(7)

    return _G.getMode() == "Raid"
end

task.spawn(function()
    task.wait(1)
    if _G.LoadSavedPosition() then
        _G.UpdateSavedPositionButtons()
    end
end)

local WorldDropdown, MobDropdown
local worldDropdownChangedConnection = nil

local function getMobNamesArrayForWorld(worldName)
    local names = {}
    if enemyList[worldName] then
        for _, mobData in ipairs(enemyList[worldName]) do
            table.insert(names, mobData.Name)
        end
    end
    return names
end

_G.AutoClickResultsReturn = function()
    local GuiService = game:GetService("GuiService")
    local VirtualInputManager = game:GetService("VirtualInputManager")
    local playerGui = player:FindFirstChild("PlayerGui")
    if not playerGui then return end

    local resultsScreenVisible = false

    while task.wait(1) do
        local success, returnButton, resultsEnabled = pcall(function()
            local results = playerGui:FindFirstChild("Results")
            if results and results.Enabled then
                local content = results:FindFirstChild("Content")
                local button = content and content:FindFirstChild("Return")
                return button, true
            end
            return nil, false
        end)

        if success and resultsEnabled and returnButton and returnButton.Visible then
            if not resultsScreenVisible then
                resultsScreenVisible = true

                local clickSuccess = pcall(function()
                    local previousSelection = GuiService.SelectedObject
                    GuiService.SelectedObject = returnButton
                    task.wait(0.1)

                    if GuiService.SelectedObject == returnButton then
                        local enterKeyCode = Enum.KeyCode.Return
                        for i = 1, 2 do
                            VirtualInputManager:SendKeyEvent(true, enterKeyCode, false, game)
                            task.wait(0.05)
                            VirtualInputManager:SendKeyEvent(false, enterKeyCode, false, game)
                            task.wait(0.15)
                            if not returnButton.Parent or not returnButton.Visible or returnButton.AbsoluteTransparency == 1 then
                                break
                            end
                        end
                    end
                    task.wait(0.1)
                    if previousSelection then
                       GuiService.SelectedObject = previousSelection
                    end
                end)
            end
        else
            if resultsScreenVisible then
                 resultsScreenVisible = false
            end
        end
    end
end

_G.CreateAndStartPortal = function()
    if _G.getMode() == "Portal" then return false end

    local portalMap = "EmptyThrone"
    local createArgs = {
        [1] = {
            [1] = {
                [1] = "PortalSystem",
                [2] = "Create",
                [3] = portalMap,
                ["n"] = 3
            },
            [2] = "\2"
        }
    }
    pcall(dataRemoteEvent.FireServer, dataRemoteEvent, unpack(createArgs))
    task.wait(1.5)

    if Options.PrivatePortal.Value then
        local privateArgs = {
            [1] = {
                [1] = {
                    [1] = "PortalSystem",
                    [2] = "MakePrivate",
                    ["n"] = 2
                },
                [2] = "\2"
            }
        }
        pcall(dataRemoteEvent.FireServer, dataRemoteEvent, unpack(privateArgs))
        task.wait(1)
    end

    local startArgs = {
        [1] = {
            [1] = {
                [1] = "PortalSystem",
                [2] = "Start",
                ["n"] = 2
            },
            [2] = "\2"
        }
    }
    pcall(dataRemoteEvent.FireServer, dataRemoteEvent, unpack(startArgs))
    task.wait(6)

    return _G.getMode() == "Portal"
end

_G.FindNearestPortalEnemy = function(playerRoot)
    local nearestEnemy = nil
    local shortestDistance = math.huge
    local playerId = tostring(player.UserId)
    local serverEnemiesFolder = Workspace._ENEMIES.Server

    if not serverEnemiesFolder then return nil, math.huge end

    for _, potentialPortalFolder in pairs(serverEnemiesFolder:GetChildren()) do
        if potentialPortalFolder.Name == "Portal" then
            local playerPortalFolder = potentialPortalFolder:FindFirstChild(playerId)
            if playerPortalFolder then
                for _, enemy in pairs(playerPortalFolder:GetChildren()) do
                    if enemy:IsA("BasePart") and not (enemy:GetAttribute("Dead") or (enemy:GetAttribute("HP") or 0) <= 0) then
                        local distance = (playerRoot.Position - enemy.Position).Magnitude
                        if distance < shortestDistance then
                            shortestDistance = distance
                            nearestEnemy = enemy
                        end
                    end
                end
            end
        end
    end

    return nearestEnemy, shortestDistance
end

_G.AutoPortalLoop = function()
    local wasInPortal = false
    local enemiesFolder = Workspace:FindFirstChild("_ENEMIES")

    while Options.AutoPortalToggle.Value do
        local rootPart = _G.GetPlayerRoot()
        if not rootPart then
            task.wait(1); continue
        end

        local currentMode = _G.getMode()

        if wasInPortal and currentMode ~= "Portal" then
            if _G.SavedWorld and _G.SavedWorldPosition then
                local args = {
                    [1] = {
                        [1] = {
                            [1] = "TeleportSystem",
                            [2] = "To",
                            [3] = _G.SavedWorld,
                            ["n"] = 3
                        },
                        [2] = "\2"
                    }
                }
                pcall(dataRemoteEvent.FireServer, dataRemoteEvent, unpack(args))
                task.wait(2)
                rootPart = _G.GetPlayerRoot()
                if rootPart then pcall(function() rootPart.CFrame = _G.SavedWorldPosition end) end
            end
            task.wait(5)
            wasInPortal = false
            if not _G.CreateAndStartPortal() then task.wait(10) end
            continue
        end

        if currentMode ~= "Portal" then
             if not _G.CreateAndStartPortal() then task.wait(10) end
             task.wait(5)
             continue
        end

        wasInPortal = true
        local playerId = tostring(player.UserId)
        local currentPosition = rootPart.Position

        local portalFolder = enemiesFolder and enemiesFolder.Server and enemiesFolder.Server.Portal and enemiesFolder.Server.Portal:FindFirstChild(playerId)

        if not portalFolder then
             task.wait(1.5)
             continue
        elseif #portalFolder:GetChildren() == 0 then
             task.wait(1.5)
             continue
        end

        local nearestEnemy, shortestDistance = _G.FindNearestPortalEnemy(rootPart)

        if nearestEnemy then
             if nearestEnemy.Parent and not (nearestEnemy:GetAttribute("Dead") or nearestEnemy:GetAttribute("HP") <= 0) then
                local enemyUuid = nearestEnemy.Name
                local needsToMove = shortestDistance > 8
                local moveSuccess = true
                local farmMode = Options.FarmModeDropdown.Value or "Teleport"

                if needsToMove then
                    pcall(function() rootPart.CFrame = CFrame.new(nearestEnemy.Position + Vector3.new(0, 3, 5)) end)
                    task.wait(0.15)
                    if (rootPart.Position - nearestEnemy.Position).Magnitude > 20 then moveSuccess = false end
                end

                local petTargeting = false
                local playerPetsFolder = workspace._PETS:FindFirstChild(player.UserId)
                if playerPetsFolder then
                    for _, petFolder in pairs(playerPetsFolder:GetChildren()) do
                        if petFolder:GetAttribute("Target") == enemyUuid then
                            petTargeting = true
                            break
                        end
                    end
                end

                if moveSuccess and not petTargeting then
                    if Options.AutoTeleportPets.Value then
                        _G.TeleportPetsToEnemy(nearestEnemy)
                        task.wait(0.05)
                    end
                    local args = {
                        [1] = {
                            [1] = {
                                [1] = "PetSystem",
                                [2] = "Attack",
                                [3] = enemyUuid,
                                [4] = true,
                                ["n"] = 4
                            },
                            [2] = "\2"
                        }
                    }
                    pcall(dataRemoteEvent.FireServer, dataRemoteEvent, unpack(args))
                end
            else
                 task.wait(0.1)
            end
        else
            task.wait(0.5)
        end

        local leaveOnWaveStr = Options.LeaveOnWaveDropdown.Value
        if leaveOnWaveStr ~= "None" then
            local targetWave = tonumber(leaveOnWaveStr)
            if targetWave then
                local currentWave = _G.GetCurrentPortalStage()

                if currentWave >= targetWave then
                    if _G.SavedWorld and _G.SavedWorldPosition then
                        local args = {
                            [1] = {
                                [1] = {
                                    [1] = "TeleportSystem",
                                    [2] = "To",
                                    [3] = _G.SavedWorld,
                                    ["n"] = 3
                                },
                                [2] = "\2"
                            }
                        }
                        pcall(dataRemoteEvent.FireServer, dataRemoteEvent, unpack(args))
                        task.wait(3)
                        rootPart = _G.GetPlayerRoot()
                        if rootPart then pcall(function() rootPart.CFrame = _G.SavedWorldPosition end) end
                    end

                    wasInPortal = false
                    if not _G.CreateAndStartPortal() then task.wait(10) end
                    continue
                end
            end
        end

        task.wait(Options.AutoFarmDelaySlider.Value)

    end
end

local isInitializingConfig = true

do
    Tabs.Main:AddSection("Farm Options")

    WorldDropdown = Tabs.Main:AddDropdown("WorldDropdown", {
        Title = "Select World",
        Values = worldList,
        Multi = false,
        Default = worldList[1]
    })

    local initialMobNames = getMobNamesArrayForWorld(WorldDropdown.Default)
    MobDropdown = Tabs.Main:AddDropdown("MobDropdown", {
        Title = "Select Mob(s)",
        Values = initialMobNames,
        Multi = true,
        Default = {}
    })

    worldDropdownChangedConnection = WorldDropdown:OnChanged(function()
        if isInitializingConfig then return end

        local selectedWorld = Options.WorldDropdown.Value
        local mobNamesArray = getMobNamesArrayForWorld(selectedWorld)
        Options.MobDropdown:SetValues(mobNamesArray)
        Options.MobDropdown:SetValue({})
    end)

    Tabs.Main:AddDropdown("FarmModeDropdown", {
        Title = "Farm Mode",
        Values = {"Teleport", "No Move"},
        Multi = false,
        Default = "Teleport"
    })

    Tabs.Main:AddSlider("FarmRangeSlider", {
        Title = "Attack Range (No Move)",
        Default = 75, Min = 10, Max = 150, Rounding = 0
    })

    Tabs.Main:AddSlider("AutoFarmDelaySlider", {
        Title = "Auto Farm Delay",
        Default = getgenv().Settings.DefaultDelay,
        Min = getgenv().Settings.MinDelay,
        Max = getgenv().Settings.MaxDelay,
        Rounding = 1
    })

    local AutoFarmToggle = Tabs.Main:AddToggle("AutoFarm", {
        Title = "Auto Farm",
        Default = false
    })
    AutoFarmToggle:OnChanged(function()
        if Options.AutoFarm.Value then
            task.spawn(_G.AutoFarmLoop)
        end
    end)

    Tabs.Setup:AddSection("Setup")
    local AutoClickToggle = Tabs.Setup:AddToggle("AutoClick", {
        Title = "Auto Click",
        Default = false
    })
    AutoClickToggle:OnChanged(function()
        if Options.AutoClick.Value then
            task.spawn(function()
                while Options.AutoClick.Value do
                    local args = {
                        [1] = {
                            [1] = {
                                [1] = "PetSystem",
                                [2] = "Click",
                                ["n"] = 2
                            },
                            [2] = "\2"
                        }
                    }
                    pcall(dataRemoteEvent.FireServer, dataRemoteEvent, unpack(args))
                    task.wait()
                end
            end)
        end
    end)

    Tabs.Setup:AddToggle("AutoTeleportPets", {
        Title = "Auto Teleport Pets",
        Default = false
    })

    Tabs.Setup:AddButton({
        Title = "Update Pet Cache",
        Description = "Update the list of pets for teleport feature",
        Callback = function()
            _G.UpdatePetCache()
            local count = _G.CachedPetUUIDs and #_G.CachedPetUUIDs or 0
            Fluent:Notify({
                Title = "Pet Cache Updated",
                Content = string.format("Found %d pets in your inventory", count),
                Duration = 3
            })
        end
    })

    Tabs.Setup:AddSection("World Position")
    local SavePositionButton = Tabs.Setup:AddButton({
        Title = "Save Current Position",
        Description = "No position saved yet",
        Callback = function()
            local rootPart = _G.GetPlayerRoot()
            if rootPart then
                _G.SavedWorldPosition = rootPart.CFrame
                _G.SavedWorld = _G.currentWorldNumber()
                local positionData = {
                    World = _G.SavedWorld,
                    CFrame = {
                        X = rootPart.CFrame.X, Y = rootPart.CFrame.Y, Z = rootPart.CFrame.Z,
                        RX, RY, RZ = rootPart.CFrame:ToEulerAnglesXYZ()
                    }
                }
                local success, jsonData = pcall(HttpService.JSONEncode, HttpService, positionData)
                if success then
                    local successWrite, err = pcall(writefile, "twvz_kingdom_pos.txt", jsonData)
                    if not successWrite then
                        -- Optionally notify user about file write error
                    end
                else
                     -- Optionally notify user about JSON encode error
                end
                _G.UpdateSavedPositionButtons()
            else
                -- Optionally notify user about character not found
            end
        end
    })
    Options.SavePositionButton = SavePositionButton

    Tabs.Roll:AddSection("Auto Roll Pets")
    Tabs.Roll:AddDropdown("RollStarDropdown", {
        Title = "Select Star",
        Values = starList,
        Multi = false,
        Default = starList[1]
    })
    Tabs.Roll:AddDropdown("RollTypeDropdown", {
        Title = "Roll Type",
        Values = {"One", "All"},
        Multi = false,
        Default = "One"
    })
    local AutoRollPetsToggle = Tabs.Roll:AddToggle("AutoRollPets", {
        Title = "Auto Roll Pets",
        Default = false
    })
    AutoRollPetsToggle:OnChanged(function()
        if Options.AutoRollPets.Value then
            task.spawn(_G.AutoRollPetsLoop)
        end
    end)

    Tabs.Raid:AddSection("Raid Options")
    Tabs.Raid:AddDropdown("RaidWorldDropdown", {
        Title = "Select Raid World",
        Values = worldList,
        Multi = false,
        Default = worldList[1]
    })
    Tabs.Raid:AddToggle("PrivateRaid", {
        Title = "Make Raid Private",
        Default = true
    })

    local AutoRaidToggle = Tabs.Raid:AddToggle("AutoRaid", {
        Title = "Auto Raid",
        Default = false
    })

    Tabs.Dungeon:AddSection("Dungeon Options")
    Tabs.Dungeon:AddDropdown("DungeonMapDropdown", {
        Title = "Select Dungeon Map",
        Values = dungeonMapList,
        Multi = false,
        Default = dungeonMapList[1]
    })

    Tabs.Dungeon:AddDropdown("DungeonDifficultyDropdown", {
        Title = "Select Difficulty",
        Values = dungeonDifficultyList,
        Multi = false,
        Default = dungeonDifficultyList[1]
    })
    Tabs.Dungeon:AddDropdown("LeaveOnStageDropdown", {
        Title = "Leave on Stage",
        Values = createStageList(),
        Multi = false,
        Default = "None"
    })
    Tabs.Dungeon:AddToggle("PrivateDungeon", {
        Title = "Make Dungeon Private",
        Default = true
    })

    Tabs.Portal:AddSection("Portal Options")

    Tabs.Portal:AddDropdown("LeaveOnWaveDropdown", {
        Title = "Leave on Wave",
        Values = createWaveList(),
        Multi = false,
        Default = "None"
    })

    Tabs.Portal:AddToggle("PrivatePortal", {
        Title = "Make Portal Private",
        Default = true
    })

    local AutoPortalToggle = Tabs.Portal:AddToggle("AutoPortalToggle", {
        Title = "Auto Portal",
        Default = false
    })

    local AutoDungeonToggle = Tabs.Dungeon:AddToggle("AutoDungeonToggle", {
        Title = "Auto Dungeon",
        Default = false
    })

    AutoRaidToggle:OnChanged(function()
        if Options.AutoRaid.Value then
            task.spawn(_G.AutoRaidLoop)
        end
    end)

    AutoDungeonToggle:OnChanged(function()
        if Options.AutoDungeonToggle.Value then
            task.spawn(_G.AutoDungeonLoop)
        end
    end)

    AutoPortalToggle:OnChanged(function()
        if Options.AutoPortalToggle.Value then
            task.spawn(_G.AutoPortalLoop)
        end
    end)

    Tabs.Teleport:AddSection("Worlds")
    for worldNumber, worldName in pairs(worldMap) do
        Tabs.Teleport:AddButton({
            Title = worldName:gsub("^%l", string.upper),
            Callback = function()
                local args = {
                    [1] = {
                        [1] = {
                            [1] = "TeleportSystem",
                            [2] = "To",
                            [3] = worldNumber,
                            ["n"] = 3
                        },
                        [2] = "\2"
                    }
                }
                pcall(dataRemoteEvent.FireServer, dataRemoteEvent, unpack(args))
                task.wait(2)
            end
        })
    end
    Tabs.Teleport:AddSection("Teleport")
    Tabs.Teleport:AddButton({
        Title = "Teleport to Saved Position",
        Callback = function()
            local rootPart = _G.GetPlayerRoot()
            -- verifique se já esta no mundo salvo, se estiver, apenas use o teleporte normal, do cframe salvo
            if _G.SavedWorld == _G.currentWorldNumber() then
                if rootPart then pcall(function() rootPart.CFrame = _G.SavedWorldPosition end) end
            else
                local args = {
                    [1] = {
                        [1] = {
                            [1] = "TeleportSystem",
                            [2] = "To",
                            [3] = _G.SavedWorld,
                            ["n"] = 3
                        },
                        [2] = "\2"
                    }
                }
                pcall(dataRemoteEvent.FireServer, dataRemoteEvent, unpack(args))
                task.wait(2)
                rootPart = _G.GetPlayerRoot()
                if rootPart then pcall(function() rootPart.CFrame = _G.SavedWorldPosition end) end
            end
        end
    })
    Tabs.Teleport:AddSection("Server")
    Tabs.Teleport:AddButton({
        Title = "Server Hop",
        Description = "Teleport to least full server.",
        Callback = function()
            local TPS = game:GetService("TeleportService")
            local Api = "https://games.roblox.com/v1/games/"
            local _place = game.PlaceId
            local _servers = Api .. _place .. "/servers/Public?sortOrder=Asc&limit=100"
            local function ListServers(cursor)
                local Raw = game:HttpGet(_servers .. ((cursor and "&cursor=" .. cursor) or ""))
                return HttpService:JSONDecode(Raw)
            end
            local Server, Next;
            local success, result = pcall(function()
                repeat
                    local Servers = ListServers(Next);
                    Server = Servers.data[1];
                    Next = Servers.nextPageCursor
                until Server or not Next
            end)
            if success and Server then
                pcall(TPS.TeleportToPlaceInstance, TPS, _place, Server.id, player)
            end
        end
    })

    Tabs.Infos:AddSection("Support")
    Tabs.Infos:AddParagraph({
        Title = "Version 2.0",
        Content = ""
    })
    Tabs.Infos:AddParagraph({
        Title = "Anti-AFK",
        Content = "Anti-AFK is automatically enabled."
    })
    Tabs.Infos:AddButton({
        Title = "Bug report",
        Description = "Click to copy discord invite",
        Callback = function()
            pcall(setclipboard, "https://discord.com/invite/NxVkhKEr3Y")
        end
    })

    Tabs.Settings:AddSection("Automation Priority")
    Tabs.Settings:AddDropdown("AutomationPriority", {
        Title = "Priority",
        Values = { "Raid First", "Dungeon First" },
        Multi = false,
        Default = "Raid First"
    })

    Tabs.Easter:AddSection("Easter Invasion Options")

    Tabs.Easter:AddDropdown("LeaveOnEasterWaveDropdown", {
        Title = "Leave on Wave",
        Values = createWaveList(),
        Multi = false,
        Default = "None"
    })

    Tabs.Easter:AddToggle("PrivateEaster", {
        Title = "Make Easter Invasion Private",
        Default = true
    })

    local AutoEasterToggle = Tabs.Easter:AddToggle("AutoEasterToggle", {
        Title = "Auto Easter Invasion",
        Default = false
    })

    Tabs.Easter:AddButton({
        Title = "Start Easter Invasion",
        Callback = function()
            _G.CreateAndStartEaster()
        end
    })

    AutoEasterToggle:OnChanged(function()
        if Options.AutoEasterToggle.Value then
            task.spawn(_G.AutoEasterLoop)
        end
    end)

end

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("twvz")
SaveManager:SetFolder("twvz/animekingdom")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

Window:SelectTab(1)

isInitializingConfig = true

SaveManager:LoadAutoloadConfig()

local manuallyLoadedMobSelection = nil
local autoloadConfigFile = SaveManager.Folder .. "/settings/autoload.txt"
local configToLoadName = nil
if isfile(autoloadConfigFile) then configToLoadName = readfile(autoloadConfigFile) end

if configToLoadName then
    local configFilePath = SaveManager.Folder .. "/settings/" .. configToLoadName .. ".json"
    if isfile(configFilePath) then
        local successRead, fileContent = pcall(readfile, configFilePath)
        if successRead and fileContent then
            local successDecode, decodedData = pcall(HttpService.JSONDecode, HttpService, fileContent)
            if successDecode and decodedData and decodedData.objects then
                for _, optionData in ipairs(decodedData.objects) do
                    if optionData.idx == "MobDropdown" and optionData.type == "Dropdown" then
                        if optionData.value and type(optionData.value) == "table" then
                             manuallyLoadedMobSelection = optionData.value
                        end
                        break
                    end
                end
            end
        end
    end
end
if not manuallyLoadedMobSelection then manuallyLoadedMobSelection = {} end

task.wait(0.1)

local targetWorld = Options.WorldDropdown.Value
if not targetWorld or not table.find(worldList, targetWorld) then
    targetWorld = Options.WorldDropdown.Default or worldList[1]
    Options.WorldDropdown:SetValue(targetWorld)
    task.wait(0.1)
    targetWorld = Options.WorldDropdown.Value
end

local correctMobList = getMobNamesArrayForWorld(targetWorld)
Options.MobDropdown:SetValues(correctMobList)

task.wait(0.3)

local validatedSelection = {}
if type(manuallyLoadedMobSelection) == "table" and next(manuallyLoadedMobSelection) ~= nil then
    local mobLookup = {}
    for _, name in ipairs(correctMobList) do mobLookup[name] = true end
    for mobName, isSelected in pairs(manuallyLoadedMobSelection) do
        if isSelected and mobLookup[mobName] then
            validatedSelection[mobName] = true
        end
    end
end

Options.MobDropdown:SetValue(validatedSelection)

task.wait(0.1)
isInitializingConfig = false

local framePosition = UDim2.new(0, 100, 0, 100)
local dragConnection = nil

local function createMinimizeFrame()
    local existingGui = player.PlayerGui:FindFirstChild("MinimizeGui")
    if existingGui then pcall(existingGui.Destroy, existingGui) end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "MinimizeGui"
    screenGui.Parent = player.PlayerGui
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local frame = Instance.new("TextButton")
    frame.Name = "MinimizeButton"
    frame.Size = UDim2.new(0, 50, 0, 50)
    frame.Position = framePosition
    frame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    frame.BorderSizePixel = 0
    frame.Text = "twvz"
    frame.TextColor3 = Color3.new(1, 1, 1)
    frame.TextSize = 14
    frame.Font = Enum.Font.SourceSansBold
    frame.Parent = screenGui

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 8)
    uiCorner.Parent = frame

    frame.MouseButton1Click:Connect(function() Window:Minimize() end)

    local dragging, dragInput, dragStart, startPos, currentTween = false, nil, nil, nil, nil
    local RunService = game:GetService("RunService")

    if dragConnection then dragConnection:Disconnect(); dragConnection = nil end

    frame.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            dragging = true; dragStart = input.Position; startPos = frame.Position
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
        end
    end)
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    frame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    dragConnection = RunService.RenderStepped:Connect(function()
        if dragging and dragInput then
            local delta = dragInput.Position - dragStart
            local newPosition = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            if currentTween then currentTween:Cancel() end
            local tweenInfo = TweenInfo.new(0.05, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            currentTween = TweenService:Create(frame, tweenInfo, {Position = newPosition})
            currentTween:Play()
            framePosition = newPosition
        end
    end)
    frame.AncestryChanged:Connect(function()
        if not frame:IsDescendantOf(game) and dragConnection then
            dragConnection:Disconnect();
            dragConnection = nil
        end
    end)
end

createMinimizeFrame()
player.CharacterAdded:Connect(createMinimizeFrame)
task.spawn(_G.AutoClickResultsReturn)

task.spawn(function()
    task.wait(2)
    _G.UpdatePetCache()
    
    player.CharacterAdded:Connect(function()
        task.wait(1)
        _G.UpdatePetCache()
    end)
end)
