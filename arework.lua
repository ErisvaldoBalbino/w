if not game:IsLoaded() then
    game.Loaded:Wait()
end

if _G.UILOADED then 
    return 
end

_G.UILOADED = true

local cloneref = cloneref or function(o) return o end

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Players = cloneref(game:GetService("Players"))
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local player = Players.LocalPlayer
local playerRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
local dataRemoteEvent = ReplicatedStorage:WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent")
local queueteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
local TeleportCheck = false
local PlayerGui = player:WaitForChild("PlayerGui")

spawn(function()
    while true do
        VirtualInputManager:SendKeyEvent(true, 101, false, game)
        task.wait(0.1)
        VirtualInputManager:SendKeyEvent(false, 101, false, game)
        task.wait(120)
    end
end)


_G.ActivityPriority = _G.ActivityPriority or "None"
_G.AriseSettings = _G.AriseSettings or {
    Toggles = {},
    FarmMoveMode = "Teleport",
    FarmTweenSpeed = 150
}
_G.CloseAnyOpenMenu = _G.CloseAnyOpenMenu or function()
end

getgenv().worldList = {"SoloWorld", "NarutoWorld", "OPWorld", "BleachWorld", "BCWorld", "ChainsawWorld", "JojoWorld", "DBWorld", "OPMWorld", "DanWorld"}
getgenv().enemyList = {
    SoloWorld = {"Soondoo", "Gonshee", "Daek", "Longln", "Anders", "Largalgan"},
    NarutoWorld = {"Snake Man", "Blossom", "Black Crow"},
    OPWorld = {"Shark Man", "Eminel", "Light Admiral"},
    BleachWorld = {"Luryu", "Fyakuya", "Genji"},
    BCWorld = {"Sortudo", "Michille", "Wind"},
    ChainsawWorld = {"Heaven", "Zere", "Ika"},
    JojoWorld = {"Diablo", "Gosuke", "Golyne"},
    DBWorld = {"Turtle", "Green", "Sky"},
    OPMWorld = {"Rider", "Cyborg", "Hurricane"},
    DanWorld = {"Shrimp", "Baira", "Lomo"}
}

getgenv().worldMap = {
    ["SoloWorld"] = "1", ["NarutoWorld"] = "2", ["OPWorld"] = "3",
    ["BleachWorld"] = "4", ["BCWorld"] = "5", ["ChainsawWorld"] = "6",
    ["JojoWorld"] = "7", ["DBWorld"] = "8", ["OPMWorld"] = "9",
    ["DanWorld"] = "10"
}

getgenv().enemyIdMap = {
    ['JB1'] = 'Diablo',['JB2'] = 'Gosuke',['JB3'] = 'Golyne',['JBB1'] = 'Diablo',['JBB2'] = 'Gosuke',['JBB3'] = 'Golyne',
    ['CH1'] = 'Heaven', ['CH2'] = 'Zere', ['CH3'] = 'Ika', ['CHB1'] = 'Heaven', ['CHB2'] = 'Zere', ['CHB3'] = 'Ika',
    ['BC1'] = 'Sortudo', ['BC2'] = 'Michille', ['BC3'] = 'Wind', ['BCB1'] = 'Sortudo', ['BCB2'] = 'Michille', ['BCB3'] = 'Wind',
    ['BL1'] = 'Luryu', ['BL2'] = 'Fyakuya', ['BL3'] = 'Genji', ['BLB1'] = 'Luryu', ['BLB2'] = 'Fyakuya', ['BLB3'] = 'Genji',
    ['OP1'] = 'Shark Man', ['OP2'] = 'Eminel', ['OP3'] = 'Light Admiral', ['OPB1'] = 'Shark Man', ['OPB2'] = 'Eminel', ['OPB3'] = 'Light Admiral',
    ['NR1'] = 'Snake Man', ['NR2'] = 'Blossom', ['NR3'] = 'Black Crow', ['NRB1'] = 'Snake Man', ['NRB2'] = 'Blossom', ['NRB3'] = 'Black Crow',
    ['SL1'] = 'Soondoo', ['SL2'] = 'Gonshee', ['SL3'] = 'Daek', ['SL4'] = 'LongIn', ['SL5'] = 'Anders', ['SL6'] = 'Largalgan',
    ['SLB1'] = 'Soondoo', ['SLB2'] = 'Gonshee', ['SLB3'] = 'Daek', ['SLB4'] = 'LongIn', ['SLB5'] = 'Anders', ['SLB6'] = 'Largalgan',
    ['JJ1'] = 'Red Ant', ['JJ2'] = 'Royal Red Ant', ['JJ3'] = 'Ant Queen', 
    ['DB1'] = 'Kame', ['DB2'] = 'Piccolo', ['DB3'] = 'Cell', ['DBB1'] = 'Kame', ['DBB2'] = 'Piccolo', ['DBB3'] = 'Cell',
    ['OPM1'] = 'Mumem', ['OPM2'] = 'Genos', ['OPM3'] = 'Tornado', ['OPMB1'] = 'Mumem', ['OPMB2'] = 'Genos', ['OPMB3'] = 'Tornado',  
    ['DAM1'] = 'Mantis', ['DAM2'] = 'Aira', ['DAM3'] = 'Momo', ['DAMB1'] = 'Mantis', ['DAMB2'] = 'Aira', ['DAMB3'] = 'Momo',
    ['WElf1'] = 'Elf Soldier', ['WElf2'] = 'High Frost', ['WBoss'] = 'Laruda', ['WBoss2'] = 'Snow Monarch', ['WIron'] = 'Metal', ['WBear'] = 'Winter Bear',
    -- Bosses
    ['JJ4'] = 'Ant King', ['JinWoo'] = 'Monarch', ['Pain'] = 'Dor', ['Mihalk'] = 'Mifalcon', 
    ['Ulquiorra'] = 'Murcielago', ['Julius'] = 'Time King', ['Denji'] = 'Chainsaw', ['Pucci'] = 'Gucci', ['Igris'] = 'Vermillion',
    ['Freeza'] = 'Frioo', ['Esil'] = 'Wesil', ['Vulcan'] = 'Magma', ['Metus'] = 'Litch', ['Baran'] = 'White Flame', ['Saitama'] = 'Paitama', ['Okarun'] = 'Tuturum'
}

getgenv().winterIgnoreMobs = {
    ['Elf Soldier'] = {'WElf1'},
    ['High Frost'] = {'WElf2'},
    ['Laruda'] = {'WBoss'},
    ['Snow Monarch'] = {'WBoss2'}, 
    ['Metal'] = {'WIron'},
    ['Winter Bear'] = {'WBear'}
}

_G.worldSpawns = {
    SoloWorld = CFrame.new(577.96826171875, 24.96237564086914, 261.4522705078125),
    NarutoWorld = CFrame.new(-3380.2373046875, 26.826528549194336, 2257.261962890625), 
    OPWorld = CFrame.new(-2851.106201171875, 46.89878845214844, -2011.395263671875),
    BleachWorld = CFrame.new(2641.795166015625, 42.92652893066406, -2645.07568359375),
    BCWorld = CFrame.new(198.33868408203125, 36.207679748535156, 4296.109375),
    ChainsawWorld = CFrame.new(199.94813537597656, 33.89651107788086, -4899.25537109375),
    JojoWorld = CFrame.new(4816.31640625, 27.442340850830078, -120.22998046875),
    DBWorld = CFrame.new(-6929.5224609375, 124.94865417480469, -76.53571319580078),
    OPMWorld = CFrame.new(6044.72998046875, 25.593618392944336, 4889.79345703125),
    DanWorld = CFrame.new(-4390.06689453125, 21.47457504272461, 5974.93017578125)
}

local uniqueEnemyBaseNamesForDropdown = {}
local tempNameSetDropdown = {}
for id, name in pairs(getgenv().enemyIdMap or {}) do
    if not tempNameSetDropdown[name] then
        tempNameSetDropdown[name] = true
        table.insert(uniqueEnemyBaseNamesForDropdown, name)
    end
end
table.sort(uniqueEnemyBaseNamesForDropdown)
getgenv().enemyBaseNamesForDropdown = uniqueEnemyBaseNamesForDropdown

local function getPlayerRoot()
    return player.Character and player.Character:FindFirstChild("HumanoidRootPart")
end

_G.hasFreePet = function()
    local pf = workspace:FindFirstChild("__Main") and workspace.__Main:FindFirstChild("__Pets") and workspace.__Main.__Pets:FindFirstChild(player.UserId)
    if pf then
        for _, p in pairs(pf:GetChildren()) do
            if p and (not p:GetAttribute("Target") or p:GetAttribute("Target") == nil) then
                return true
            end
        end
    end
    return false
end

_G.AttackEnemy = function(enemyId)
    local args = {
        [1] = {
            [1] = {
                ["PetPos"] = {},
                ["AttackType"] = "All",
                ["Event"] = "Attack",
                ["Enemy"] = enemyId
            },
            [2] = ""
        }
    }
    args[1][2] = "\n"  dataRemoteEvent:FireServer(unpack(args))
    args[1][2] = "\t"  dataRemoteEvent:FireServer(unpack(args))
    args[1][2] = "\7"  dataRemoteEvent:FireServer(unpack(args))
    args[1][2] = "\8"  dataRemoteEvent:FireServer(unpack(args))
    args[1][2] = "\5"  dataRemoteEvent:FireServer(unpack(args))
    args[1][2] = "\6"  dataRemoteEvent:FireServer(unpack(args))
    args[1][2] = "\11"  dataRemoteEvent:FireServer(unpack(args))
end

_G.IsInDungeon = function()
    local world = workspace:FindFirstChild("__Main") and workspace.__Main:FindFirstChild("__World")
    if not world then
        return false
    end
    for _, child in pairs(world:GetChildren()) do
        if child:IsA("Model") and string.find(child.Name, "Room") then
            return true
        end
    end
    return false
end

_G.IsInCastle = function()
    local success, result = pcall(function()
        local playerGui = player:FindFirstChild("PlayerGui")
        local Hud = playerGui and playerGui:FindFirstChild("Hud")
        local UpContainer = Hud and Hud:FindFirstChild("UpContanier")
        local roomLabel = UpContainer and UpContainer:FindFirstChild("Room")

        if roomLabel then
            return string.find(string.lower(roomLabel.Text), "floor") ~= nil
        end
        return false
    end)

    return success and result or false
end

_G.MoveToEnemy = function(targetPosition, mode, speedOrDuration, addOffset)
    local player = game.Players.LocalPlayer
    local root = getPlayerRoot()
    if not root or not player then return end

    local mainFolder = workspace:FindFirstChild("__Main")
    if not mainFolder then return end

    local playersFolder = mainFolder:FindFirstChild("__Players")
    local allPetsFolder = mainFolder:FindFirstChild("__Pets")
    if not playersFolder or not allPetsFolder then return end

    local playerModel = playersFolder:FindFirstChild(player.Name)
    local petsFolder = allPetsFolder:FindFirstChild(tostring(player.UserId))

    local finalPosition = targetPosition
    if addOffset == nil or addOffset == true then
        finalPosition = targetPosition + Vector3.new(4, 2, 0)
    end
    local targetCFrame = CFrame.new(finalPosition)

    if mode == "Teleport" or mode == "Fast" then
        if playerModel then playerModel:SetAttribute("InTp", true) end
        root.CFrame = targetCFrame
    elseif mode == "Tween" then
        if playerModel then playerModel:SetAttribute("InTp", true) end
        local duration = tonumber(speedOrDuration) or 150
        duration = math.max(0.1, duration / 1000)
        local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
        local goal = { CFrame = targetCFrame }
        local tween = TweenService:Create(root, tweenInfo, goal)
        root.Anchored = true
        tween:Play()
        tween.Completed:Wait()
        root.Anchored = false
    else
        if playerModel then playerModel:SetAttribute("InTp", true) end
        root.CFrame = targetCFrame
    end

    if petsFolder then
        local children = petsFolder:GetChildren()
        local totalPets = #children
        if totalPets == 0 then return end

        local playerScale = 1
        if root.Parent then
             local scaleSuccess, scaleResult = pcall(function() return root.Parent:GetScale() end)
             if scaleSuccess then
                 playerScale = scaleResult
             end
        end

        for index, pet in ipairs(children) do
            local angleDegrees = index / totalPets * 360 - 180
            local radiusMultiplier = (math.floor(totalPets / 10) + 4) * math.max(playerScale / (1 + (0.3) * (playerScale / 2)), 1)
            local offsetVector = (root.CFrame.RightVector * math.sin(math.rad(angleDegrees)) + root.CFrame.LookVector * -math.cos(math.rad(angleDegrees))) * radiusMultiplier
            local petPosition = root.Position + offsetVector

            local targetPetCFrame = CFrame.new(petPosition)

            pcall(function()
                local petRoot = pet:FindFirstChild("HumanoidRootPart", true)
                if petRoot and petRoot:IsA("BasePart") then
                    petRoot.CFrame = targetPetCFrame
                end
            end)
        end
    end
end


_G.StepTeleport = function(targetPosition)
    -- Get root dynamically
    local humanoidRootPart = getPlayerRoot() -- Use the helper function
    if not humanoidRootPart then
        Rayfield:Notify({ Title = "Error", Content = "StepTeleport: Character not loaded!", Duration = 2, Image="alert-circle" })
        return nil -- Return nil if no root
    end

    local playerObject = workspace.__Main.__Players:FindFirstChild(player.Name)
    if not playerObject then
         Rayfield:Notify({ Title = "Error", Content = "StepTeleport: Player object not found!", Duration = 2, Image="alert-circle" })
        return nil -- Return nil if no player object
    end

    local originalInTp = playerObject:GetAttribute("InTp")
    -- Ensure attribute exists before trying to restore it later
    if originalInTp == nil then
        playerObject:SetAttribute("InTp", false)
        originalInTp = false
    end
    playerObject:SetAttribute("InTp", true)

    humanoidRootPart.Anchored = true
    local targetCFrame = CFrame.new(targetPosition + Vector3.new(4, 2, 0)) -- Apply offset here if needed for StepTeleport
    humanoidRootPart.CFrame = targetCFrame

    local maxWaitTime = 2
    local waitStart = tick()
    local groundLoaded = false

    -- Simplified wait logic (Raycast might not be necessary depending on game)
    task.wait(0.2) -- Small delay often helps

    humanoidRootPart.Anchored = false

    -- Return the restore function
    return function()
        -- Check if playerObject still exists before setting attribute
        if playerObject and playerObject.Parent then
            playerObject:SetAttribute("InTp", originalInTp)
        end
    end
end

_G.TeleportTo = function(position)
    local root = getPlayerRoot()
    if not root then
        return 
    end

    local targetCFrame = (typeof(position) == "CFrame" and position) or CFrame.new(position)

    local playerModel = workspace:WaitForChild("__Main"):WaitForChild("__Players"):WaitForChild(player.Name)
    if not playerModel then
        return
    end

    local originalInTp = playerModel:GetAttribute("InTp")
    local hadInTp = originalInTp ~= nil

    playerModel:SetAttribute("InTp", true)

    local restoreInTp = _G.StepTeleport(targetCFrame.Position)

    root.CFrame = targetCFrame

    if hadInTp then
        playerModel:SetAttribute("InTp", originalInTp)
    else
        playerModel:SetAttribute("InTp", nil)
    end

    if restoreInTp then
        pcall(restoreInTp)
    end
end

_G.FindNearestWorld = function(islandCFrame)
    local nearestWorld = nil
    local minDistance = math.huge
    for worldName, spawnCFrame in pairs(_G.worldSpawns) do
        local distance = (islandCFrame.Position - spawnCFrame.Position).Magnitude
        if distance < minDistance then
            minDistance = distance
            nearestWorld = worldName
        end
    end
    return nearestWorld
end

local function getCurrentWorld()
    local r = getPlayerRoot()
    if not r then return nil end
    local p = r.Position
    local n = nil
    local m = math.huge
    for w, s in pairs(_G.worldSpawns) do
        local d = (p - s.Position).Magnitude
        if d < m then
            m = d
            n = w
        end
    end
    return n
end

local Window = Rayfield:CreateWindow({
    Name = "Arise Crossover - twvz",
    LoadingTitle = "Arise Crossover",
    LoadingSubtitle = "by twvz",
    Theme = "DarkBlue",
    Icon = "loader",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "AriseRayfieldTest",
        FileName = "AutofarmConfig"
    },
    KeySystem = false
})

local Tab_Infos = Window:CreateTab("Infos")
Tab_Infos:CreateSection("Infos")

Tab_Infos:CreateLabel("Important!", "info")
Tab_Infos:CreateParagraph({Title = "Read me!", Content = "This script has automatic saving of the configs.\nSave your position on Teleport tab."})

local Tab_Main = Window:CreateTab("Main")
Tab_Main:CreateSection("Farming Options")

_G.Dropdown_World = Tab_Main:CreateDropdown({
    Name = "Select World",
    Options = getgenv().worldList,
    CurrentOption = {getgenv().worldList[1] or "SoloWorld"},
    Flag = "WorldDropdown",
    Callback = function(SelectedWorldTable)
        local SelectedWorld = nil
        if type(SelectedWorldTable) == "table" and #SelectedWorldTable > 0 then
            SelectedWorld = SelectedWorldTable[1]
        else
            warn("[CB] World Error: Invalid data")
            return
        end
        if not _G.Dropdown_Enemy then
            warn("[CB] World Error: Enemy Dropdown nil")
            return
        end
        local newEnemyList = getgenv().enemyList[SelectedWorld] or {}
        local sR, eR = pcall(_G.Dropdown_Enemy.Refresh, _G.Dropdown_Enemy, newEnemyList)
        if not sR then warn("[CB] World Error Refresh:", eR) end
        local sS, eS = pcall(_G.Dropdown_Enemy.Set, _G.Dropdown_Enemy, {})
        if not sS then warn("[CB] World Error Set:", eS) end
    end,
})

_G.Dropdown_Enemy = Tab_Main:CreateDropdown({
    Name = "Select Enemies",
    Options = getgenv().enemyList[_G.Dropdown_World.CurrentOption[1]] or {},
    CurrentOption = {},
    MultipleOptions = true,
    Flag = "EnemyDropdown",
    Callback = function(_) end
})

local Dropdown_MobType = Tab_Main:CreateDropdown({
    Name = "Enemy Type",
    Options = {"Normal", "Big"},
    CurrentOption = {"Normal"},
    MultipleOptions = true,
    Flag = "MobTypeDropdown",
    Callback = function(_) end
})

local Slider_FarmDelay = Tab_Main:CreateSlider({
    Name = "Farm Delay",
    Range = {0, 5},
    Increment = 0.1,
    Suffix = "s",
    CurrentValue = 0.1,
    Flag = "FarmDelaySlider",
    Callback = function(_) end
})

local Dropdown_MoveMode = Tab_Main:CreateDropdown({
    Name = "Farm Move Mode",
    Options = {"Teleport", "Tween"},
    CurrentOption = {_G.AriseSettings.FarmMoveMode},
    Flag = "FarmMoveModeDropdown",
    Callback = function(Value)
        if type(Value) == "table" and #Value > 0 then
            _G.AriseSettings.FarmMoveMode = Value[1]
        end
    end
})

local Slider_TweenSpeed = Tab_Main:CreateSlider({
    Name = "Tween Speed/Duration",
    Range = {50, 1000},
    Increment = 10,
    Suffix = " (Higher=Slower)",
    CurrentValue = _G.AriseSettings.FarmTweenSpeed,
    Flag = "FarmTweenSpeedSlider",
    Callback = function(Value)
        _G.AriseSettings.FarmTweenSpeed = Value
    end
})

Tab_Main:CreateSection("Auto Farm")

_G.Toggle_AutoFarm = Tab_Main:CreateToggle({
    Name = "Auto Farm",
    CurrentValue = false,
    Flag = "AutoFarmToggle",
    Callback = function(Value)
        _G.AriseSettings.Toggles.AutoFarmToggle = Value

        if Value then
            if _G.ActivityPriority == "None" then
                _G.ActivityPriority = "Farming"
            else
                return
            end

            spawn(function()
                while _G.Toggle_AutoFarm.CurrentValue do
                    local playerRoot = getPlayerRoot()

                    if not playerRoot then
                        task.wait(0.5)
                        continue
                    end

                    if _G.ActivityPriority ~= "Farming" then
                        task.wait(1)
                        continue
                    end

                    local selectedWorldTable = _G.Dropdown_World.CurrentOption
                    local selectedWorld = nil
                    if type(selectedWorldTable) == "table" and #selectedWorldTable > 0 then
                        selectedWorld = selectedWorldTable[1]
                    else
                        task.wait(2)
                        continue
                    end

                    local currentWorld = getCurrentWorld()
                    if not currentWorld then
                        task.wait(2)
                        continue
                    end

                    if currentWorld ~= selectedWorld then
                        task.wait(1)
                        continue
                    end

                    local selectedEnemiesTable = _G.Dropdown_Enemy.CurrentOption
                    local selectedEnemiesLookup = {}
                    for _, enemyName in ipairs(selectedEnemiesTable) do selectedEnemiesLookup[enemyName] = true end

                    local selectedMobTypesTable = Dropdown_MobType.CurrentOption
                    local selectedMobTypesLookup = {}
                    for _, typeName in ipairs(selectedMobTypesTable) do selectedMobTypesLookup[typeName] = true end

                    if not next(selectedEnemiesLookup) then
                        task.wait(2)
                        continue
                    end
                     if not next(selectedMobTypesLookup) then
                        task.wait(2)
                        continue
                    end

                    local worldFolderName = getgenv().worldMap[currentWorld] or "1"
                    local mainFolder = workspace:FindFirstChild("__Main")
                    local enemiesFolder = mainFolder and mainFolder:FindFirstChild("__Enemies")
                    local serverFolder = enemiesFolder and enemiesFolder:FindFirstChild("Server")
                    local worldFolder = serverFolder and serverFolder:FindFirstChild(worldFolderName)

                    if not worldFolder then
                        task.wait(1)
                        continue
                    end

                    local serverEnemies = worldFolder:GetChildren()
                    local nearestEnemyInstance = nil
                    local minDistance = math.huge

                    for _, enemyInstance in ipairs(serverEnemies) do
                        if not enemyInstance or not enemyInstance:IsA("BasePart") then continue end

                        local isDead = enemyInstance:GetAttribute("Dead") or false
                        local enemyId = enemyInstance:GetAttribute("Id") or "nil"

                        if isDead or enemyId == "nil" then continue end

                        local enemyPosition = enemyInstance.Position
                        local distance = (playerRoot.Position - enemyPosition).Magnitude

                        local enemyIndex = tonumber(string.match(enemyId, "%d+$"))
                        local enemyName = "Unknown"
                        if enemyIndex and getgenv().enemyList[currentWorld] and getgenv().enemyList[currentWorld][enemyIndex] then
                            enemyName = getgenv().enemyList[currentWorld][enemyIndex]
                        end

                        local scale = enemyInstance:GetAttribute("Scale") or 1
                        local isBig = scale == 2
                        local matchesType = (selectedMobTypesLookup["Normal"] and not isBig) or (selectedMobTypesLookup["Big"] and isBig)

                        if selectedEnemiesLookup[enemyName] and matchesType then
                            if distance < minDistance then
                                minDistance = distance
                                nearestEnemyInstance = enemyInstance
                            end
                        end
                    end

                    if nearestEnemyInstance then
                        local nearestEnemyPosition = nearestEnemyInstance.Position
                        local needsToMove = minDistance > 5

                        if needsToMove then
                            _G.MoveToEnemy(nearestEnemyPosition, _G.AriseSettings.FarmMoveMode, _G.AriseSettings.FarmTweenSpeed, true)
                        end

                        if _G.hasFreePet() then
                            _G.AttackEnemy(nearestEnemyInstance.Name)
                        end
                    end

                    local delay = Slider_FarmDelay.CurrentValue
                    task.wait(delay)
                end

                if _G.ActivityPriority == "Farming" then
                    _G.ActivityPriority = "None"
                end
                local finalRoot = getPlayerRoot()
                if finalRoot and finalRoot.Anchored then
                    finalRoot.Anchored = false
                end
            end)

            spawn(function()
                while _G.Toggle_AutoFarm.CurrentValue and _G.ActivityPriority == "Farming" do
                   _G.CloseAnyOpenMenu()
                   task.wait(1)
                end
            end)

        else
            if _G.ActivityPriority == "Farming" then
                _G.ActivityPriority = "None"
            end
            local finalRoot = getPlayerRoot()
            if finalRoot and finalRoot.Anchored then
                finalRoot.Anchored = false
            end
        end
    end,
})

local Slider_AutoClickDelay = Tab_Main:CreateSlider({
    Name = "Auto Click Delay",
    Range = {0, 2},
    Increment = 0.1,
    Suffix = "s",
    CurrentValue = 0,
    Flag = "AutoClickDelaySlider",
    Callback = function(_) end
})

_G.Toggle_AutoClick = Tab_Main:CreateToggle({
    Name = "Auto Click",
    CurrentValue = false,
    Flag = "AutoClickToggle",
    Callback = function(Value)
        if Value then
            spawn(function()
                while _G.Toggle_AutoClick.CurrentValue do
                    local playerRoot = getPlayerRoot()
                    local nearestEnemy = nil
                    local minDistance = 45
                        
                        player:SetAttribute("AutoClick", true)

                        player.leaderstats.Passes:SetAttribute("AutoClicker", true)
                        
                        if _G.IsInDungeon() then
                            local serverEnemies = workspace.__Main.__Enemies.Server:GetChildren()
                            for _, enemy in ipairs(serverEnemies) do
                                local isDead = enemy:GetAttribute("Dead") or false
                                if not isDead then
                                    local distance = (playerRoot.Position - enemy.Position).Magnitude
                                    if distance < minDistance then
                                        minDistance = distance
                                        nearestEnemy = enemy
                                    end
                                end
                            end
                        else
                            local serverEnemies = workspace.__Main.__Enemies.Server:GetChildren()
                            for _, enemy in ipairs(serverEnemies) do
                                if not enemy:GetAttribute("Dead") and enemy:IsA("BasePart") then
                                    local distance = (playerRoot.Position - enemy.Position).Magnitude
                                    if distance < minDistance then
                                        minDistance = distance
                                        nearestEnemy = enemy
                                    end
                                end
                            end
                            
                            local currentWorld = getCurrentWorld()
                            local worldFolderName = getgenv().worldMap[currentWorld] or "1"
                            local worldFolder = workspace.__Main.__Enemies.Server:FindFirstChild(worldFolderName)
                            if worldFolder then
                                for _, enemy in ipairs(worldFolder:GetChildren()) do
                                    local isDead = enemy:GetAttribute("Dead") or false
                                    if not isDead then
                                        local distance = (playerRoot.Position - enemy.Position).Magnitude
                                        if distance < minDistance then
                                            minDistance = distance
                                            nearestEnemy = enemy
                                        end
                                    end
                                end
                            end
                        end
                        
                        
                        if nearestEnemy then
                            local args = {
                                [1] = {
                                    [1] = {
                                        ["Event"] = "PunchAttack",
                                        ["Enemy"] = nearestEnemy.Name
                                    },
                                    [2] = "\5"
                                }
                            }
                            game:GetService("ReplicatedStorage"):WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer(unpack(args))
                        end
                        
                    task.wait(Slider_AutoClickDelay.CurrentValue)
                end
            end)
        end
    end,
})

Tab_Main:CreateSection("Filtered Action Options")

task.wait()

_G.Dropdown_AriseEnemies = Tab_Main:CreateDropdown({
    Name = "Arise",
    Options = getgenv().enemyBaseNamesForDropdown or {},
    CurrentOption = {},
    MultipleOptions = true,
    Flag = "AriseEnemiesDropdown",
    Callback = function(_) end
})

task.wait()

_G.Dropdown_AriseEnemyTypes = Tab_Main:CreateDropdown({
    Name = "Arise - Sizes",
    Options = {"Normal", "Big"},
    CurrentOption = {"Normal", "Big"},
    MultipleOptions = true,
    Flag = "AriseEnemyTypesDropdown",
    Callback = function(_) end
})

task.wait()

_G.Dropdown_DestroyEnemies = Tab_Main:CreateDropdown({
    Name = "Destroy",
    Options = getgenv().enemyBaseNamesForDropdown or {},
    CurrentOption = {},
    MultipleOptions = true,
    Flag = "DestroyEnemiesDropdown",
    Callback = function(_) end
})

task.wait()

_G.Dropdown_DestroyEnemyTypes = Tab_Main:CreateDropdown({
    Name = "Destroy - Sizes",
    Options = {"Normal", "Big"},
    CurrentOption = {"Normal", "Big"},
    MultipleOptions = true,
    Flag = "DestroyEnemyTypesDropdown",
    Callback = function(_) end
})

task.wait()

_G.Toggle_Action = Tab_Main:CreateToggle({
    Name = "Activate Filtered Action",
    CurrentValue = false,
    Flag = "ActionToggle",
    Callback = function(Value)
        if Value then
            if _G.Toggle_SimpleAction and _G.Toggle_SimpleAction.CurrentValue then
                _G.Toggle_SimpleAction:Set(false)
                Rayfield:Notify({
                    Title = "Warning",
                    Content = "Simple Action cannot be used with Filtered Action",
                    Duration = 3,
                    Image = "alert-triangle"
                })
                return
            end
            spawn(function()
                local deadEnemies = {}

                local function updateDeadEnemies()
                    deadEnemies = {}
                    local clientEnemies = workspace.__Main.__Enemies.Client:GetChildren()
                    for _, enemy in ipairs(clientEnemies) do
                        local humanoidRootPart = enemy:FindFirstChild("HumanoidRootPart")
                        if humanoidRootPart and (humanoidRootPart:FindFirstChild("ArisePrompt") or humanoidRootPart:FindFirstChild("DestroyPrompt")) then
                            if enemy.Parent then
                                deadEnemies[enemy.Name] = enemy
                            end
                        end
                    end
                end

                while _G.Toggle_Action.CurrentValue do    
                    updateDeadEnemies()
                    local playerRoot = getPlayerRoot()
                    if not playerRoot then
                        task.wait(0.5)
                        continue
                    end

                    if next(deadEnemies) then
                        local nearestEnemy = nil
                        local minDistance = math.huge

                        for enemyName, enemyInstance in pairs(deadEnemies) do
                            local enemyRoot = enemyInstance:FindFirstChild("HumanoidRootPart")
                            if enemyRoot and enemyInstance.Parent then
                                local distance = (playerRoot.Position - enemyRoot.Position).Magnitude
                                if distance < minDistance then
                                    minDistance = distance
                                    nearestEnemy = enemyInstance
                                end
                            else
                                deadEnemies[enemyName] = nil
                            end
                        end

                        if nearestEnemy then
                            local enemyInstanceName = nearestEnemy.Name
                            local enemyId = nearestEnemy:GetAttribute("ID")
                            local scale = nearestEnemy:GetAttribute("Scale") or 1
                            local isBig = (scale >= 2)
                            local enemySizeTypeStr = isBig and "Big" or "Normal"
                            local readableEnemyName = getgenv().enemyIdMap and getgenv().enemyIdMap[enemyId]

                            if readableEnemyName then
                                local readableNameLower = string.lower(readableEnemyName)
                                local ariseEnemies = {}
                                for _, name in ipairs(_G.Dropdown_AriseEnemies.CurrentOption) do
                                    ariseEnemies[name] = true
                                end
                                local ariseTypes = {}
                                for _, typeName in ipairs(_G.Dropdown_AriseEnemyTypes.CurrentOption) do
                                    ariseTypes[typeName] = true
                                end
                                local destroyEnemies = {}
                                for _, name in ipairs(_G.Dropdown_DestroyEnemies.CurrentOption) do
                                    destroyEnemies[name] = true
                                end
                                local destroyTypes = {}
                                for _, typeName in ipairs(_G.Dropdown_DestroyEnemyTypes.CurrentOption) do
                                    destroyTypes[typeName] = true
                                end

                                local argsToSend = nil

                                if ariseEnemies[readableEnemyName] and ariseTypes[enemySizeTypeStr] then
                                    argsToSend = { [1] = { [1] = { ["Event"] = "EnemyCapture", ["Enemy"] = enemyInstanceName }, [2] = "\5" } }
                                elseif destroyEnemies[readableEnemyName] and destroyTypes[enemySizeTypeStr] then
                                    argsToSend = { [1] = { [1] = { ["Event"] = "EnemyDestroy", ["Enemy"] = enemyInstanceName }, [2] = "\5" } }
                                end

                                if argsToSend then
                                    local success, err = pcall(function()
                                        dataRemoteEvent:FireServer(unpack(argsToSend))
                                    end)
                                end

                                deadEnemies[enemyInstanceName] = nil
                            else
                                warn("Could not find readable name for ID:", enemyId)
                                deadEnemies[enemyInstanceName] = nil
                            end
                        end
                    end
                    task.wait(0.1)
                end

                deadEnemies = nil
            end)
        end
    end
})

task.wait()

Tab_Main:CreateSection("Simple Action Options")

task.wait()

_G.Dropdown_Action = Tab_Main:CreateDropdown({
    Name = "Action",
    Options = {"Arise", "Destroy"},
    CurrentOption = {"Arise"},
    Flag = "ActionDropdown",
    Callback = function(_) end
})

task.wait()

_G.Toggle_SimpleAction = Tab_Main:CreateToggle({
    Name = "Activate Simple Action",
    CurrentValue = false,
    Flag = "SimpleActionToggle",
    Callback = function(Value)
        if Value then
            if _G.Toggle_Action and _G.Toggle_Action.CurrentValue then
                _G.Toggle_SimpleAction:Set(false)
                Rayfield:Notify({
                    Title = "Warning",
                    Content = "Filtered Action cannot be used with Simple Action",
                    Duration = 3,
                    Image = "alert-triangle"
                })
                return
            end 
            spawn(function()
                local connections = {}
                local deadEnemies = {}
                
                local function setupEnemy(enemy)
                    local humanoidRootPart = enemy:FindFirstChild("HumanoidRootPart")
                    if not humanoidRootPart then return end
                    local connection = humanoidRootPart.ChildAdded:Connect(function(child)
                        if (child.Name == "ArisePrompt" or child.Name == "DestroyPrompt") and not deadEnemies[enemy.Name] then
                            deadEnemies[enemy.Name] = enemy
                        end
                    end)
                    table.insert(connections, connection)
                end
                
                local function updateDeadEnemies()
                    deadEnemies = {}
                    for _, enemy in ipairs(workspace.__Main.__Enemies.Client:GetChildren()) do
                        local humanoidRootPart = enemy:FindFirstChild("HumanoidRootPart")
                        if humanoidRootPart and (humanoidRootPart:FindFirstChild("ArisePrompt") or humanoidRootPart:FindFirstChild("DestroyPrompt")) then
                            if enemy.Parent then
                                deadEnemies[enemy.Name] = enemy
                            end
                        end
                    end
                end
                
                for _, enemy in ipairs(workspace.__Main.__Enemies.Client:GetChildren()) do
                    setupEnemy(enemy)
                end
                local childAddedConnection = workspace.__Main.__Enemies.Client.ChildAdded:Connect(setupEnemy)
                table.insert(connections, childAddedConnection)
                
                while _G.Toggle_SimpleAction.CurrentValue do
                    updateDeadEnemies()
                    local playerRoot = getPlayerRoot()
                    if not playerRoot then
                        task.wait(0.5)
                        continue
                    end

                    if next(deadEnemies) then
                        local nearestEnemy = nil
                        local minDistance = math.huge
                        for enemyName, enemy in pairs(deadEnemies) do
                            local enemyRoot = enemy:FindFirstChild("HumanoidRootPart")
                            if enemyRoot and enemy.Parent then
                                local distance = (playerRoot.Position - enemyRoot.Position).Magnitude
                                if distance < minDistance then
                                    minDistance = distance
                                    nearestEnemy = enemy
                                end
                            else
                                deadEnemies[enemyName] = nil
                            end
                        end
                        if nearestEnemy then
                            local enemyName = nearestEnemy.Name
                            local enemyHash = enemyName
                            local action = _G.Dropdown_Action.CurrentOption[1]

                            if action == "Arise" then
                                local ariseArgs = {
                                    [1] = {
                                        [1] = {
                                            ["Event"] = "EnemyCapture",
                                            ["Enemy"] = enemyHash
                                        },
                                        [2] = "\5"
                                    }
                                }
                                game:GetService("ReplicatedStorage"):WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer(unpack(ariseArgs))
                            elseif action == "Destroy" then
                                local destroyArgs = {
                                    [1] = {
                                        [1] = {
                                            ["Event"] = "EnemyDestroy",
                                            ["Enemy"] = enemyHash
                                        },
                                        [2] = "\5"
                                    }
                                }
                                game:GetService("ReplicatedStorage"):WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer(unpack(destroyArgs))
                            end

                            deadEnemies[enemyName] = nil
                            task.wait()
                        end
                    end
                    task.wait(0.1)
                end
                
                for _, conn in ipairs(connections) do
                    conn:Disconnect()
                end
            end)
        end
    end
})

task.wait()

Tab_Dungeon = Window:CreateTab("Dungeon")

Tab_Dungeon:CreateSection("Dungeon Options")

local Dropdown_SearchWorlds = Tab_Dungeon:CreateDropdown({
    Name = "Worlds to Search",
    Options = getgenv().worldList,
    MultipleOptions = true,
    CurrentOption = {"BCWorld"},
    Flag = "SearchWorldsDropdown",
    Callback = function(_) end
})

local Dropdown_DungeonRank = Tab_Dungeon:CreateDropdown({
    Name = "Ranks to Search",
    Options = {"E", "D", "C", "B", "A", "S", "SS"},
    MultipleOptions = true,
    CurrentOption = {"S"},
    Flag = "DungeonRankDropdown",
    Callback = function(_) end
})

local Slider_DungeonActionDelay = Tab_Dungeon:CreateSlider({
    Name = "Action Delay",
    Range = {0.1, 5},
    Increment = 0.1,
    Suffix = "s",
    CurrentValue = 1,
    Flag = "DungeonActionDelaySlider",
    Callback = function(Value)
        _G.AriseSettings.DungeonActionDelay = Value
    end
})

local function createDungeon(dungeonId)
    local args = {
        [1] = {
            [1] = {
                ["Event"] = "DungeonAction",
                ["Action"] = "Create"
            },
            [2] = ""
        }
    }
    args[1][2] = "\n"  dataRemoteEvent:FireServer(unpack(args))
    args[1][2] = "\t"  dataRemoteEvent:FireServer(unpack(args))
    args[1][2] = "\7"  dataRemoteEvent:FireServer(unpack(args))
    args[1][2] = "\8"  dataRemoteEvent:FireServer(unpack(args))
    args[1][2] = "\5"  dataRemoteEvent:FireServer(unpack(args))
    args[1][2] = "\11"  dataRemoteEvent:FireServer(unpack(args))
end

local function addRune(dungeonId)
    local selectedRune = _G.Dropdown_DungeonRune.CurrentOption
    local runeString = (type(selectedRune) == "table" and #selectedRune > 0) and selectedRune[1] or ""
    local args = {
        [1] = {
            [1] = {
                ["Dungeon"] = player.UserId,
                ["Action"] = "AddItems",
                ["Slot"] = 1,
                ["Event"] = "DungeonAction",
                ["Item"] = tostring(runeString)
            },
            [2] = ""
        }
    }
    args[1][2] = "\n"  dataRemoteEvent:FireServer(unpack(args))
    args[1][2] = "\t"  dataRemoteEvent:FireServer(unpack(args))
    args[1][2] = "\7"  dataRemoteEvent:FireServer(unpack(args))
    args[1][2] = "\8"  dataRemoteEvent:FireServer(unpack(args))
    args[1][2] = "\5"  dataRemoteEvent:FireServer(unpack(args))
    args[1][2] = "\11"  dataRemoteEvent:FireServer(unpack(args))
end

local function startDungeon(dungeonId)
    local args = {
        [1] = {
            [1] = {
                ["Event"] = "DungeonAction",
                ["Action"] = "Start"
            },
            [2] = ""
        }
    }

    args[1][2] = "\n"  dataRemoteEvent:FireServer(unpack(args))
    args[1][2] = "\t"  dataRemoteEvent:FireServer(unpack(args))
    args[1][2] = "\7"  dataRemoteEvent:FireServer(unpack(args))
    args[1][2] = "\8"  dataRemoteEvent:FireServer(unpack(args))
    args[1][2] = "\5"  dataRemoteEvent:FireServer(unpack(args))
    args[1][2] = "\11"  dataRemoteEvent:FireServer(unpack(args))
end

local dungeonRankMap = {
    [1] = "E", [2] = "D", [3] = "C", [4] = "B",
    [5] = "A", [6] = "S", [7] = "SS"
}

_G.Toggle_AutoDungeon = Tab_Dungeon:CreateToggle({
    Name = "Auto Dungeon",
    CurrentValue = false,
    Flag = "AutoDungeonToggle",
    Callback = function(Value)
        _G.AriseSettings.Toggles.AutoDungeon = Value
        local playerRoot = getPlayerRoot()

        if Value then
            spawn(function()
                local function createLookupTable(optionsList)
                    local lookup = {}
                    if type(optionsList) == "table" then
                        for _, item in ipairs(optionsList) do
                            lookup[item] = true
                        end
                    end
                    return lookup
                end

                local function searchForDungeonFast(selectedWorldsLookup, selectedRanksLookup)
                    local foundDungeon = false
                    local foundDungeonWorld = nil
                    local foundDungeonInstance = nil
                    local checkedWorlds = {}

                    local preferredWorld = _G.AriseSettings.PreferredDungeonWorld

                    if preferredWorld and selectedWorldsLookup[preferredWorld] then
                        if _G.ActivityPriority == "Raiding" then
                             checkedWorlds[preferredWorld] = true
                        else
                            checkedWorlds[preferredWorld] = true
                            local restoreInTp = _G.StepTeleport(_G.worldSpawns[preferredWorld].Position)
                            task.wait(_G.AriseSettings.DungeonActionDelay or 1)

                            local dungeonInstance = workspace:FindFirstChild("__Main") and workspace.__Main:FindFirstChild("__Dungeon") and workspace.__Main.__Dungeon:FindFirstChild("Dungeon")
                            if dungeonInstance then
                                local dungeonWorldAttr = dungeonInstance:GetAttribute("Dungeon")
                                local dungeonRankAttr = dungeonInstance:GetAttribute("DungeonRank")
                                local rankName = dungeonRankMap[dungeonRankAttr] or tostring(dungeonRankAttr)

                                if dungeonWorldAttr == preferredWorld and selectedRanksLookup[rankName] then
                                    foundDungeon = true
                                    foundDungeonWorld = preferredWorld
                                    foundDungeonInstance = dungeonInstance
                                end
                            end
                            if restoreInTp then pcall(restoreInTp) end
                        end
                    end

                    if not foundDungeon then
                        for worldName, isSelected in pairs(selectedWorldsLookup) do
                            if not _G.Toggle_AutoDungeon.CurrentValue then break end
                            if isSelected and not checkedWorlds[worldName] then
                                if _G.ActivityPriority == "Raiding" then
                                else
                                    checkedWorlds[worldName] = true
                                    local restoreInTp = _G.StepTeleport(_G.worldSpawns[worldName].Position)
                                    task.wait(_G.AriseSettings.DungeonActionDelay or 1)

                                    local dungeonInstance = workspace:FindFirstChild("__Main") and workspace.__Main:FindFirstChild("__Dungeon") and workspace.__Main.__Dungeon:FindFirstChild("Dungeon")
                                    if dungeonInstance then
                                        local dungeonWorldAttr = dungeonInstance:GetAttribute("Dungeon")
                                        local dungeonRankAttr = dungeonInstance:GetAttribute("DungeonRank")
                                        local rankName = dungeonRankMap[dungeonRankAttr] or tostring(dungeonRankAttr)

                                        if dungeonWorldAttr == worldName and selectedRanksLookup[rankName] then
                                            foundDungeon = true
                                            foundDungeonWorld = worldName
                                            foundDungeonInstance = dungeonInstance
                                            _G.AriseSettings.PreferredDungeonWorld = worldName
                                        end
                                    end
                                    if restoreInTp then pcall(restoreInTp) end
                                    if foundDungeon then break end
                                end
                            end
                        end
                    end
                    return foundDungeon, foundDungeonWorld, foundDungeonInstance
                end

                while _G.Toggle_AutoDungeon.CurrentValue do
                    if _G.IsInDungeon() then
                        break
                    end

                    playerRoot = getPlayerRoot()
                    if not playerRoot then
                        Rayfield:Notify({ Title = "Error", Content = "Player character not loaded!", Duration = 3, Image="alert-circle" })
                        task.wait(5)
                        continue
                    end

                    if _G.ActivityPriority == "Raiding" then
                        task.wait(5)
                        continue
                    end

                    local currentTime = os.date("*t")
                    local minutes = currentTime.min
                    local seconds = currentTime.sec

                    local isActiveWindow = (minutes % 15 < 14) or (minutes % 15 == 14 and seconds < 59)

                    if isActiveWindow then
                        local selectedWorldsLookup = createLookupTable(Dropdown_SearchWorlds.CurrentOption)
                        local selectedRanksLookup = createLookupTable(Dropdown_DungeonRank.CurrentOption)

                        if not next(selectedWorldsLookup) then
                            Rayfield:Notify({ Title = "Error", Content = "No worlds selected to search!", Duration = 5, Image="alert-triangle" })
                            task.wait(5); continue
                        end
                        if not next(selectedRanksLookup) then
                            Rayfield:Notify({ Title = "Error", Content = "No ranks selected!", Duration = 5, Image="alert-triangle" })
                            task.wait(5); continue
                        end

                        local currentWorld = getCurrentWorld()
                        local foundAndEntered = false

                        if currentWorld and selectedWorldsLookup[currentWorld] then
                            local dungeon = workspace:FindFirstChild("__Main") and workspace.__Main:FindFirstChild("__Dungeon") and workspace.__Main.__Dungeon:FindFirstChild("Dungeon")
                            if dungeon then
                                local dungeonWorldAttr = dungeon:GetAttribute("Dungeon")
                                local dungeonRankAttr = dungeon:GetAttribute("DungeonRank")
                                local rankName = dungeonRankMap[dungeonRankAttr] or tostring(dungeonRankAttr)

                                if dungeonWorldAttr == currentWorld and selectedRanksLookup[rankName] then
                                    pcall(createDungeon)
                                    task.wait(0.2)
                                    if _G.Toggle_DungeonRune.CurrentValue then
                                        pcall(addRune)
                                    end
                                    task.wait(0.2)
                                    pcall(startDungeon)
                                    foundAndEntered = true
                                    break
                                end
                            end
                        end

                        if not foundAndEntered then
                            local foundDungeon, foundDungeonWorld, foundDungeonInstance = searchForDungeonFast(selectedWorldsLookup, selectedRanksLookup)

                            if foundDungeon and foundDungeonInstance then
                                local foundRankName = dungeonRankMap[foundDungeonInstance:GetAttribute("DungeonRank")] or "??"
                                if getCurrentWorld() ~= foundDungeonWorld then
                                     local restore = _G.StepTeleport(_G.worldSpawns[foundDungeonWorld].Position)
                                     task.wait(_G.AriseSettings.DungeonActionDelay or 1)
                                     if restore then pcall(restore) end
                                end
                                pcall(createDungeon)
                                task.wait(0.2)
                                if _G.Toggle_DungeonRune.CurrentValue then
                                    pcall(addRune)
                                end
                                task.wait(0.2)
                                pcall(startDungeon)
                                foundAndEntered = true
                                break
                            end
                        end

                        if not foundAndEntered then
                            local waitSeconds = 0
                            local targetMinute = (math.floor(minutes / 15) * 15 + 14)
                            local targetHour = currentTime.hour

                            waitSeconds = (targetMinute - minutes) * 60 + (59 - seconds)
                            if waitSeconds < 0 then
                                targetMinute = (math.floor(minutes / 15) + 1) * 15 + 14
                                if targetMinute >= 60 then targetMinute = 14; targetHour = (targetHour + 1) % 24 end
                                waitSeconds = (targetMinute - minutes + (targetMinute < minutes and 60 or 0)) * 60 + (59 - seconds)
                            end
                            waitSeconds = math.max(1, waitSeconds)

                            local targetDisplayMinute = (targetMinute + 1) % 60
                            local targetDisplayHour = targetHour
                            if targetMinute == 59 then targetDisplayHour = (targetHour + 1) % 24 end

                            Rayfield:Notify({ Title = "Auto Dungeon", Content = "No suitable dungeon. Waiting " .. math.ceil(waitSeconds) .. "s until " .. string.format("%02d:%02d", targetDisplayHour, targetDisplayMinute) .. "", Duration = 5, Image="timer" })

                            if _G.Toggle_AutoFarm and _G.Toggle_AutoFarm.CurrentValue then
                                if _G.ActivityPriority == "None" then _G.ActivityPriority = "Farming" end
                                if _G.SavedFarmPosition then
                                    local currentCheckWorld = getCurrentWorld()
                                    local targetWorld = _G.FindNearestWorld(_G.SavedFarmPosition)
                                    if currentCheckWorld ~= targetWorld then
                                        _G.TeleportTo(_G.SavedFarmPosition)
                                        task.wait(0.5)
                                        local currentRoot = getPlayerRoot()
                                        if currentRoot then currentRoot.Anchored = false end
                                    end
                                end
                            end

                            local waitEndTime = tick() + waitSeconds
                            while tick() < waitEndTime and _G.Toggle_AutoDungeon.CurrentValue do
                                task.wait(1)
                            end
                        end
                    else
                        local waitSeconds = 60 - seconds
                        local targetMinute = (minutes + 1) % 60
                        local targetHour = currentTime.hour
                        if minutes == 59 then targetHour = (targetHour + 1) % 24 end

                        Rayfield:Notify({ Title = "Auto Dungeon Paused", Content = "Waiting " .. math.ceil(waitSeconds) .. "s until " .. string.format("%02d:%02d", targetHour, targetMinute) .. "", Duration = 5, Image="pause-circle" })

                        if _G.Toggle_AutoFarm and _G.Toggle_AutoFarm.CurrentValue then
                             if _G.ActivityPriority == "None" then _G.ActivityPriority = "Farming" end
                             if _G.SavedFarmPosition then
                                 local currentCheckWorld = getCurrentWorld()
                                 local targetWorld = _G.FindNearestWorld(_G.SavedFarmPosition)
                                 if currentCheckWorld ~= targetWorld then
                                     _G.TeleportTo(_G.SavedFarmPosition)
                                     task.wait(0.5)
                                     local currentRoot = getPlayerRoot()
                                     if currentRoot then currentRoot.Anchored = false end
                                 end
                             end
                        end

                        local waitEndTime = tick() + waitSeconds
                        while tick() < waitEndTime and _G.Toggle_AutoDungeon.CurrentValue do
                            task.wait(1)
                        end
                    end

                    task.wait(0.1)
                end

                playerRoot = getPlayerRoot()
                if playerRoot and playerRoot.Anchored then playerRoot.Anchored = false end

            end)
        else
            playerRoot = getPlayerRoot()
            if playerRoot and playerRoot.Anchored then
                playerRoot.Anchored = false
            end
        end
    end
})

Tab_Dungeon:CreateSection("Dungeon Rune Options")

local DgRunes = {
    "DgTimeRune",
    "DgRoomRune",
    "DgMoreRoomRune",
    "DgCashRune",
    "DgGemsRune",
    "DgHealthRune",
    "DgRankUpRune",
    "DgURankUpRune",
    "DgRankDownRune",
    "DgSoloRune",
    "DgNarutoRune",
    "DgOPRune",
    "DgBleachRune",
    "DgBCRune",
    "DgChainsawRune",
    "DgJojoRune",
    "DgDbRune",
    "DgOPMRune",
    "DgDanRune"
}

_G.Dropdown_DungeonRune = Tab_Dungeon:CreateDropdown({
    Name = "Choose Dungeon Rune",
    Options = DgRunes,
    MultipleOptions = false,
    CurrentOption = {DgRunes[1] or "None"},
    Flag = "DungeonRuneDropdown",
    Callback = function(_) end
})

_G.Toggle_DungeonRune = Tab_Dungeon:CreateToggle({
    Name = "Use Rune",
    CurrentValue = false,
    Flag = "DungeonRuneToggle",
    Callback = function(Value)
        _G.AriseSettings.Toggles.DungeonRune = Value
    end
})

_G.Toggle_DungeonRuneOnRejoin = Tab_Dungeon:CreateToggle({
    Name = "Use Rune On Auto Rejoin",
    CurrentValue = false,
    Flag = "DungeonRuneOnRejoinToggle",
    Callback = function(Value)
        _G.AriseSettings.Toggles.DungeonRuneOnRejoin = Value
    end
})

Tab_Dungeon:CreateSection("Dungeon Settings")

local function resetDungeon()
    local args = {
        [1] = {
            [1] = {
                ["Type"] = "Gems",
                ["Event"] = "DungeonAction",
                ["Action"] = "BuyTicket"
            },
            [2] = ""
        }
    }
    args[1][2] = "\n"  dataRemoteEvent:FireServer(unpack(args))
    args[1][2] = "\t"  dataRemoteEvent:FireServer(unpack(args))
    args[1][2] = "\7"  dataRemoteEvent:FireServer(unpack(args))
    args[1][2] = "\8"  dataRemoteEvent:FireServer(unpack(args))
    args[1][2] = "\5"  dataRemoteEvent:FireServer(unpack(args))
    args[1][2] = "\11"  dataRemoteEvent:FireServer(unpack(args))
end

local Toggle_AutoResetDungeon = Tab_Dungeon:CreateToggle({
    Name = "Auto Reset Dungeon",
    CurrentValue = false,
    Flag = "AutoResetDungeonToggle",
    Callback = function(Value)
        _G.AriseSettings.Toggles.AutoResetDungeon = Value
        if Value then
            pcall(resetDungeon)
        end
    end
})

_G.Toggle_LeaveFast = Tab_Dungeon:CreateToggle({
    Name = "Leave Fast",
    CurrentValue = false,
    Flag = "LeaveFastToggle",
    Callback = function(Value)
        _G.AriseSettings.Toggles.LeaveFastToggle = Value
    end
})

local Toggle_WaitDoubleDungeon = Tab_Dungeon:CreateToggle({
    Name = "Wait for Double Dungeon",
    CurrentValue = false,
    Flag = "WaitDoubleDungeonToggle",
    Callback = function(Value)
        _G.AriseSettings.Toggles.WaitDoubleDungeonToggle = Value
    end
})

_G.Toggle_AutoRejoinDungeon = Tab_Dungeon:CreateToggle({
    Name = "Auto Rejoin",
    CurrentValue = false,
    Flag = "AutoRejoinDungeonToggle",
    Callback = function(Value)
        _G.AriseSettings.Toggles.AutoRejoinDungeon = Value
    end
})

Tab_Dungeon:CreateSection("Dungeon Farm")

local Dropdown_DungeonMoveMode = Tab_Dungeon:CreateDropdown({
    Name = "Move Mode",
    Options = {"Tween", "Teleport"},
    CurrentOption = {"Teleport"},
    Flag = "DungeonMoveModeDropdown",
    Callback = function(Value)
        if type(Value) == "table" and #Value > 0 then
            _G.AriseSettings.DungeonMoveMode = Value[1]
        end
    end
})

local Slider_DungeonFarmTweenSpeed = Tab_Dungeon:CreateSlider({
    Name = "Tween Speed",
    Range = {100, 1000},
    Increment = 10,
    Suffix = " (Higher=Slower)",
    CurrentValue = 150,
    Flag = "DungeonFarmTweenSpeedSlider",
    Callback = function(Value)
        _G.AriseSettings.DungeonFarmTweenSpeed = Value
    end
})

local Slider_DungeonFarmDelay = Tab_Dungeon:CreateSlider({
    Name = "Dungeon Farm Delay",
    Range = {0, 5},
    Increment = 0.1,
    Suffix = "s (No kick >= 0.7)",
    CurrentValue = 0.1,
    Flag = "DungeonFarmDelaySlider",
    Callback = function(Value)
        _G.AriseSettings.DungeonFarmDelay = Value
    end
})

local GuiService = game:GetService("GuiService")

_G.findLeaveButtonRegion = function()
    local topbar = PlayerGui:FindFirstChild("TopbarStandard")
    if not topbar then return nil end

    local rightHolder = topbar:FindFirstChild("Holders") and topbar.Holders:FindFirstChild("Right")
    if not rightHolder then return nil end

    for _, widget in ipairs(rightHolder:GetChildren()) do
        local iconLabel = widget:FindFirstChild("IconLabel", true)

        if iconLabel and iconLabel.Text == "Leave" then
            local iconButton = widget:FindFirstChild("IconButton")
            local menu = iconButton and iconButton:FindFirstChild("Menu")
            local iconSpot = menu and menu:FindFirstChild("IconSpot")
            local clickRegion = iconSpot and iconSpot:FindFirstChild("ClickRegion")

            if clickRegion and clickRegion:IsA("GuiButton") and clickRegion.Selectable then
                 return clickRegion
            elseif iconButton and iconButton:IsA("GuiButton") and iconButton.Selectable then
                 return iconButton
            end
        end
    end
    return nil
end

_G.executeLeaveSequence = function()
    task.wait(0.5)

    if _G.Toggle_LeaveFast.CurrentValue then
        local successLeave, errLeave = pcall(function()
            local leaveButton = _G.findLeaveButtonRegion()

            if leaveButton then
                local previousSelection = GuiService.SelectedObject

                GuiService.SelectedObject = leaveButton
                task.wait(0.1)

                if GuiService.SelectedObject == leaveButton then
                    local enterKeyCode = Enum.KeyCode.Return

                    for i = 1, 3 do
                        VirtualInputManager:SendKeyEvent(true, enterKeyCode, false, game)
                        task.wait(0.05)
                        VirtualInputManager:SendKeyEvent(false, enterKeyCode, false, game)
                        task.wait(0.15)
                    end
                end

                task.wait(0.1)
                GuiService.SelectedObject = previousSelection

            else
                 warn("Fast Leave: Button not found")
            end
        end)

        if not successLeave then
            warn("Fast Leave Error:", errLeave)
        end
    end
end

_G.HandleDungeonEnd = function()
    if _G.Toggle_AutoRejoinDungeon.CurrentValue then

            local function createDungeonLocal(dungeonId)
                local args = {
                    [1] = {
                        [1] = {
                            ["Event"] = "DungeonAction",
                            ["Action"] = "Create"
                        },
                        [2] = "\11"
                    }
                }
                if dungeonId then
                    args[1][1]["Dungeon"] = dungeonId
                end

                dataRemoteEvent:FireServer(unpack(args))
            end

            local function startDungeonLocal(dungeonId)
                if not dungeonId then
                    return
                end

                local args = {
                    [1] = {
                        [1] = {
                            ["Event"] = "DungeonAction",
                            ["Action"] = "Start",
                            ["Dungeon"] = dungeonId
                        },
                        [2] = "\11"
                    }
                }

                dataRemoteEvent:FireServer(unpack(args))
            end
    
            resetDungeon()

            createDungeonLocal()

            if _G.Toggle_DungeonRuneOnRejoin.CurrentValue then
                addRune()
            end

            task.wait(2)

            local testDungeonId = "81654360"
            startDungeonLocal(testDungeonId)

    else
        _G.executeLeaveSequence()
    end
end

_G.Toggle_AutoFarmDungeon = Tab_Dungeon:CreateToggle({
    Name = "Auto Farm Dungeon",
    CurrentValue = false,
    Flag = "AutoFarmDungeonToggle",
    Callback = function(Value)
        _G.AriseSettings.Toggles.AutoFarmDungeon = Value
        local playerRoot = getPlayerRoot()

        if Value then
            spawn(function()
                while _G.Toggle_AutoFarmDungeon.CurrentValue do
                    if _G.IsInCastle then
                         if _G.IsInCastle() then
                            break
                         end
                    end

                    if _G.IsInDungeon then
                        if _G.IsInDungeon() then
                            if not getgenv().isInDungeonForTracking then
                            end
                        else
                            break
                        end
                    else
                         break
                    end

                    local isPotentiallyEnding = false
                    local dungeonInfoLabel = nil

                    local successInfo, labelResult = pcall(function()
                        local hud = player.PlayerGui:FindFirstChild("Hud")
                        local upContainer = hud and hud:FindFirstChild("UpContanier")
                        if not upContainer then upContainer = hud and hud:FindFirstChild("UpContainer") end
                        return upContainer and upContainer:FindFirstChild("DungeonInfo") and upContainer.DungeonInfo:FindFirstChild("TextLabel")
                    end)

                    if successInfo and labelResult then
                         dungeonInfoLabel = labelResult
                         if string.find(string.lower(dungeonInfoLabel.Text), "dungeon ends in", 1, true) then
                             isPotentiallyEnding = true
                         end
                    end

                    if isPotentiallyEnding then
                        if Toggle_WaitDoubleDungeon.CurrentValue then
                            local checkStartTime = tick()
                            local isDoubleDungeon = false
                            local WAIT_FOR_DOUBLE_DURATION = 2
                            local stopFarmingCompletely = false

                            while tick() - checkStartTime < WAIT_FOR_DOUBLE_DURATION and _G.Toggle_AutoFarmDungeon.CurrentValue do
                                if dungeonInfoLabel and dungeonInfoLabel.Parent then
                                     local currentText = dungeonInfoLabel.Text
                                     if string.find(currentText, "Double Dungeon Appear", 1, true) then
                                         isDoubleDungeon = true
                                         Rayfield:Notify({ Title = "Double Dungeon", Content = "Continuing farm...", Duration = 3, Image="check-circle" })
                                         isPotentiallyEnding = false
                                         break
                                     end

                                else
                                    _G.HandleDungeonEnd()
                                    stopFarmingCompletely = true
                                    break
                                end
                                task.wait()
                            end

                            if stopFarmingCompletely then
                                break
                            end

                            if not isDoubleDungeon then
                                _G.HandleDungeonEnd()
                                break
                            end

                        else
                            task.wait(2.5)
                            _G.HandleDungeonEnd()
                            break
                        end

                    else
                        playerRoot = getPlayerRoot()
                        if playerRoot then
                            local serverFolder = workspace:FindFirstChild("__Main") and workspace.__Main:FindFirstChild("__Enemies") and workspace.__Main.__Enemies:FindFirstChild("Server")
                            if serverFolder then
                                local serverEnemies = serverFolder:GetChildren()
                                local nearestEnemyInstance = nil
                                local minDistance = math.huge

                                for _, enemySource in ipairs(serverEnemies) do
                                    if enemySource:IsA("Folder") or enemySource:IsA("Model") then
                                        for _, enemyInstance in ipairs(enemySource:GetChildren()) do
                                            if enemyInstance and enemyInstance:IsA("BasePart") then
                                                local isDead = enemyInstance:GetAttribute("Dead") or false
                                                if not isDead then
                                                    local distance = (playerRoot.Position - enemyInstance.Position).Magnitude
                                                    if distance < minDistance then
                                                        minDistance = distance
                                                        nearestEnemyInstance = enemyInstance
                                                    end
                                                end
                                            end
                                        end
                                    elseif enemySource:IsA("BasePart") then
                                         local isDead = enemySource:GetAttribute("Dead") or false
                                         if not isDead then
                                             local distance = (playerRoot.Position - enemySource.Position).Magnitude
                                             if distance < minDistance then
                                                 minDistance = distance
                                                 nearestEnemyInstance = enemySource
                                             end
                                         end
                                    end
                                end

                                if nearestEnemyInstance then
                                    local nearestEnemyPosition = nearestEnemyInstance.Position
                                    local needsToMove = minDistance > 5

                                    if needsToMove then
                                        local moveMode = _G.AriseSettings.DungeonMoveMode or "Teleport"
                                        local tweenSpeed = _G.AriseSettings.DungeonFarmTweenSpeed or 150
                                        _G.MoveToEnemy(nearestEnemyPosition, moveMode, tweenSpeed, true)
                                    end

                                    if _G.hasFreePet() then
                                        _G.AttackEnemy(nearestEnemyInstance.Name)
                                    end
                                end
                            else
                                task.wait(1)
                            end
                        else
                            task.wait(1)
                        end
                    end

                    local delay = Slider_DungeonFarmDelay.CurrentValue
                    task.wait(delay)

                end

                playerRoot = getPlayerRoot()
                if playerRoot and playerRoot.Anchored then playerRoot.Anchored = false end

            end)
        else
            playerRoot = getPlayerRoot()
            if playerRoot and playerRoot.Anchored then playerRoot.Anchored = false end
        end
    end,
})

    Tab_Dungeon:CreateSection("Bypass")

    Tab_Dungeon:CreateButton({
        Name = "Bypass",
        Callback = function()

                local ReplicatedStorage = game:GetService("ReplicatedStorage")
                local dataRemoteEvent = ReplicatedStorage:WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent")
    
                local function createDungeonLocal(dungeonId)
                    local args = {
                        [1] = {
                            [1] = {
                                ["Event"] = "DungeonAction",
                                ["Action"] = "Create"
                            },
                            [2] = "\11"
                        }
                    }
                    if dungeonId then
                        args[1][1]["Dungeon"] = dungeonId
                    end
    
                    local success, err = pcall(function()
                        dataRemoteEvent:FireServer(unpack(args))
                    end)
    
                    if not success then
                    end
                end
        
                    local function startDungeonLocal(dungeonId)
                        if not dungeonId then
                            return
                        end
        
                        local args = {
                            [1] = {
                                [1] = {
                                    ["Event"] = "DungeonAction",
                                    ["Action"] = "Start",
                                    ["Dungeon"] = dungeonId
                                },
                                [2] = "\11"
                            }
                        }
        
                        local success, err = pcall(function()
                            dataRemoteEvent:FireServer(unpack(args))
                        end)
        
                        if not success then
                        end
                    end
                
                    resetDungeon()
        
                    createDungeonLocal()
        
                    task.wait(2)
        
                    local testDungeonId = "81654360"
                    startDungeonLocal(testDungeonId)
        
        end,
    })


local Tab_Castle = Window:CreateTab("Castle")

-- == Castle Options Section ==
Tab_Castle:CreateSection("Castle Options")

-- Forward declare the toggles so they can reference each other in callbacks
_G.Toggle_AutoCastle = Tab_Castle:CreateToggle({
    Name = "Auto Castle",
    CurrentValue = false,
    Flag = "AutoCastleToggle",
    Callback = function(value)
        _G.AriseSettings.Toggles.AutoCastle = value

        -- Mutual exclusivity: If this is turned ON, turn the other OFF
        if value and _G.Toggle_AutoCastleNoCheckpoint and _G.Toggle_AutoCastleNoCheckpoint.CurrentValue then
            _G.Toggle_AutoCastleNoCheckpoint:Set(false)
            _G.AriseSettings.Toggles.AutoCastleNoCheckpoint = false -- Update setting state too
        end

        if value then
            spawn(function()
                while _G.Toggle_AutoCastle.CurrentValue do -- Check Rayfield toggle state

                    if _G.IsInCastle() or _G.IsInDungeon() then
                        break
                    end

                    if _G.ActivityPriority == "Dungeon" then
                        task.wait(5)
                        continue
                    end

                    local currentTime = os.date("*t")
                    local minutes = currentTime.min
                    local seconds = currentTime.sec -- Get seconds for wait calculation
                    local isActiveWindow = minutes >= 45 -- Window starts at xx:45:00

                    if isActiveWindow then
                        if _G.ActivityPriority == "Farming" or _G.ActivityPriority == "None" then
                            _G.ActivityPriority = "Castle"
                        end

                        if _G.ActivityPriority == "Castle" then
                            local args = {
                                [1] = {
                                    [1] = {
                                        ["Check"] = true, -- Use Checkpoint
                                        ["Event"] = "CastleAction",
                                        ["Action"] = "Join"
                                    },
                                    [2] = "\11" -- Keep original second arg if needed
                                }
                            }
                            local success, err = pcall(function() dataRemoteEvent:FireServer(unpack(args)) end)
                            if not success then warn("[ACastle Loop] Error firing Castle Join event:", err) end
                            task.wait(5) -- Wait after attempting to join
                            -- Assume joining breaks the loop or changes IsInCastle state
                            -- break -- Removed break, let IsInCastle check handle loop exit
                        else
                             task.wait(1) -- Wait a bit if priority is wrong
                        end
                    else
                        -- Outside active window, calculate wait time
                        local waitSeconds = 0
                        local targetMinute = 45
                        local targetHour = currentTime.hour

                        -- Calculate seconds until xx:45:00
                        waitSeconds = (44 - minutes) * 60 + (60 - seconds)
                        if waitSeconds < 0 then -- We are already past xx:44:59, aim for next hour
                             targetHour = (targetHour + 1) % 24
                             waitSeconds = ( (44 + 60) - minutes) * 60 + (60 - seconds)
                        end
                        waitSeconds = math.max(1, waitSeconds) -- Ensure at least 1s wait

                        local targetTimeString = string.format("%02d:%02d", targetHour, targetMinute)
                        Rayfield:Notify({
                            Title = "Auto Castle Paused",
                            Content = "Waiting " .. math.ceil(waitSeconds) .. "s until " .. targetTimeString,
                            Duration = 5,
                            Image = "timer"
                        })

                        if _G.ActivityPriority == "None" then _G.ActivityPriority = "Farming" end
                        if _G.SavedFarmPosition then
                            local currentCheckWorld = getCurrentWorld()
                            local targetWorld = _G.FindNearestWorld(_G.SavedFarmPosition)
                            if currentCheckWorld ~= targetWorld then
                                pcall(_G.TeleportTo, _G.SavedFarmPosition)
                                task.wait(0.5)
                                local currentRoot = getPlayerRoot()
                                if currentRoot then currentRoot.Anchored = false end
                            end
                        end

                        -- Wait loop
                        local waitEndTime = tick() + waitSeconds
                        while tick() < waitEndTime and _G.Toggle_AutoCastle.CurrentValue do
                            task.wait(1)
                        end
                    end
                    task.wait(0.1) -- Small delay at end of main loop iteration
                end -- End of while loop

                if _G.ActivityPriority == "Castle" then
                    _G.ActivityPriority = "None"
                end
                local playerRoot = getPlayerRoot()
                if playerRoot and playerRoot.Anchored then playerRoot.Anchored = false end
            end)
        else
            if _G.ActivityPriority == "Castle" then
                _G.ActivityPriority = "None"
            end
            local playerRoot = getPlayerRoot()
            if playerRoot and playerRoot.Anchored then
                playerRoot.Anchored = false
            end
        end
    end
})

_G.Toggle_AutoCastleNoCheckpoint = Tab_Castle:CreateToggle({
    Name = "Auto Castle (No Checkpoint)",
    CurrentValue = false,
    Flag = "AutoCastleNoCheckpointToggle",
    Callback = function(value)
        _G.AriseSettings.Toggles.AutoCastleNoCheckpoint = value

        -- Mutual exclusivity: If this is turned ON, turn the other OFF
        if value and _G.Toggle_AutoCastle and _G.Toggle_AutoCastle.CurrentValue then
            _G.Toggle_AutoCastle:Set(false)
            _G.AriseSettings.Toggles.AutoCastle = false -- Update setting state too
        end

        if value then
            spawn(function()
                while _G.Toggle_AutoCastleNoCheckpoint.CurrentValue do -- Check Rayfield toggle state

                    if _G.IsInCastle() or _G.IsInDungeon() then
                        break
                    end

                    if _G.ActivityPriority == "Dungeon" then
                        task.wait(5)
                        continue
                    end

                    local currentTime = os.date("*t")
                    local minutes = currentTime.min
                    local seconds = currentTime.sec
                    local isActiveWindow = minutes >= 45

                    if isActiveWindow then
                        if _G.ActivityPriority == "Farming" or _G.ActivityPriority == "None" then
                            _G.ActivityPriority = "Castle"
                        end

                        if _G.ActivityPriority == "Castle" then
                            local args = {
                                [1] = {
                                    [1] = {
                                        ["Check"] = false, -- No Checkpoint
                                        ["Event"] = "CastleAction",
                                        ["Action"] = "Join"
                                    },
                                    [2] = "\11"
                                }
                            }
                            local success, err = pcall(function() dataRemoteEvent:FireServer(unpack(args)) end)
                            if not success then warn("[ACastleNC Loop] Error firing Castle Join event:", err) end
                            task.wait(5)
                            -- break -- Removed break
                        else
                             task.wait(1)
                        end
                    else
                        -- Outside active window, wait logic (same as above)
                        local waitSeconds = 0
                        local targetMinute = 45
                        local targetHour = currentTime.hour

                        waitSeconds = (44 - minutes) * 60 + (60 - seconds)
                        if waitSeconds < 0 then
                             targetHour = (targetHour + 1) % 24
                             waitSeconds = ( (44 + 60) - minutes) * 60 + (60 - seconds)
                        end
                        waitSeconds = math.max(1, waitSeconds)

                        local targetTimeString = string.format("%02d:%02d", targetHour, targetMinute)
                        Rayfield:Notify({
                            Title = "Auto Castle Paused",
                            Content = "Waiting " .. math.ceil(waitSeconds) .. "s until " .. targetTimeString,
                            Duration = 5,
                            Image = "timer"
                        })

                        -- Optional: Resume farming
                        if _G.Toggle_AutoFarm and _G.Toggle_AutoFarm.CurrentValue then
                            if _G.ActivityPriority == "None" then _G.ActivityPriority = "Farming" end
                            if _G.SavedFarmPosition then
                                local currentCheckWorld = getCurrentWorld()
                                local targetWorld = _G.FindNearestWorld(_G.SavedFarmPosition)
                                if currentCheckWorld ~= targetWorld then
                                    pcall(_G.TeleportTo, _G.SavedFarmPosition)
                                    task.wait(0.5)
                                    local currentRoot = getPlayerRoot()
                                    if currentRoot then currentRoot.Anchored = false end
                                end
                            end
                        end

                        -- Wait loop
                        local waitEndTime = tick() + waitSeconds
                        while tick() < waitEndTime and _G.Toggle_AutoCastleNoCheckpoint.CurrentValue do
                            task.wait(1)
                        end
                    end
                    task.wait(0.1)
                end -- End of while loop

                if _G.ActivityPriority == "Castle" then
                    _G.ActivityPriority = "None"
                end
                local playerRoot = getPlayerRoot()
                if playerRoot and playerRoot.Anchored then playerRoot.Anchored = false end
            end)
        else
            -- Toggle turned OFF
            if _G.ActivityPriority == "Castle" then
                _G.ActivityPriority = "None"
            end
            local playerRoot = getPlayerRoot()
            if playerRoot and playerRoot.Anchored then
                playerRoot.Anchored = false
            end
        end
    end
})

local function resetCastle()
    local args = {
        [1] = {
            [1] = {
                ["Type"] = "Gems",
                ["Event"] = "CastleAction",
                ["Action"] = "BuyTicket"
            },
            [2] = ""
        }
    }
    args[1][2] = "\n"  dataRemoteEvent:FireServer(unpack(args))
    args[1][2] = "\t"  dataRemoteEvent:FireServer(unpack(args))
    args[1][2] = "\7"  dataRemoteEvent:FireServer(unpack(args))
    args[1][2] = "\8"  dataRemoteEvent:FireServer(unpack(args))
    args[1][2] = "\5"  dataRemoteEvent:FireServer(unpack(args))
    args[1][2] = "\11"  dataRemoteEvent:FireServer(unpack(args))
end

local Toggle_AutoResetCastle = Tab_Castle:CreateToggle({
    Name = "Auto Reset Castle (Gems)",
    CurrentValue = false,
    Flag = "AutoResetCastleToggle",
    Callback = function(Value)
        _G.AriseSettings.Toggles.AutoResetCastle = Value
        if Value then
            pcall(resetCastle) -- Assumes resetCastle exists
        end
    end
})

-- == Castle Settings Section ==
Tab_Castle:CreateSection("Castle Settings")

local function createFloorList()
    local rooms = {"None"}
    for i = 1, 100 do
        table.insert(rooms, tostring(i))
    end
    return rooms
end

local Dropdown_CastleFloor = Tab_Castle:CreateDropdown({
    Name = "Choose a Floor",
    Options = createFloorList(), -- Assumes createFloorList exists and returns a list
    MultipleOptions = false,
    CurrentOption = {"None"}, -- Default from snippet
    Flag = "CastleFloorDropdown",
    Callback = function(_) end -- Value read when needed
})

local Dropdown_ActionOnFloor = Tab_Castle:CreateDropdown({
    Name = "What to Do",
    Options = {"Leave Castle", "Do Nothing"}, -- Added "Rejoin Castle" based on farm logic? No, stick to snippet.
    MultipleOptions = false,
    CurrentOption = {"Do Nothing"}, -- Default from snippet
    Flag = "ActionOnFloorDropdown",
    Callback = function(_) end -- Value read when needed
})

-- == Castle Farm Section ==
Tab_Castle:CreateSection("Castle Farm")

local Dropdown_CastleMoveMode = Tab_Castle:CreateDropdown({
    Name = "Move Mode",
    Options = {"Tween", "Teleport"}, -- Description not directly supported
    CurrentOption = {"Slow"}, -- Default from snippet
    Flag = "CastleMoveModeDropdown",
    Callback = function(Value)
        if type(Value) == "table" and #Value > 0 then
            _G.AriseSettings.CastleMoveMode = Value[1]
        end
    end
})

local Slider_CastleFarmTweenSpeed = Tab_Castle:CreateSlider({
    Name = "Tween Speed",
    Range = {100, 1000},
    Increment = 10, -- Best guess for Rounding = 0.1
    Suffix = " (Higher=Slower)",
    CurrentValue = 150, -- Default from snippet
    Flag = "CastleFarmTweenSpeedSlider",
    Callback = function(Value)
        _G.AriseSettings.CastleTweenSpeed = Value
    end
})

local Slider_CastleFarmDelay = Tab_Castle:CreateSlider({
    Name = "Castle Farm Delay",
    Range = {0, 5},
    Increment = 0.1, -- Assuming Rounding = 1 means 0.1 increments
    Suffix = "s (No kick >= 0.7)",
    CurrentValue = 0.1, -- Default from snippet
    Flag = "CastleFarmDelaySlider",
    Callback = function(Value)
        _G.AriseSettings.CastleFarmDelay = Value
    end
})

_G.GetCurrentCastleFloor = function()
    local currentFloor = nil

    local playerGui = player:FindFirstChild("PlayerGui")
    local Hud = playerGui and playerGui:FindFirstChild("Hud")
    local UpContainer = Hud and Hud:FindFirstChild("UpContanier")
    local roomLabel = UpContainer and UpContainer:FindFirstChild("Room")
    if roomLabel then
        local floorText = roomLabel.Text
        local floorNumStr = string.match(floorText, "Floor: (%d+)/100")
        if floorNumStr then
            currentFloor = tonumber(floorNumStr)
        end
    end

    return currentFloor
end

_G.leaveCastle = function()
    task.wait(2)
    local successLeave, errLeave = pcall(function()
        local leaveButton = _G.findLeaveButtonRegion()
        if leaveButton then
            local previousSelection = GuiService.SelectedObject
            GuiService.SelectedObject = leaveButton
            task.wait(0.1)
            if GuiService.SelectedObject == leaveButton then
                local enterKeyCode = Enum.KeyCode.Return
                for i = 1, 3 do
                    VirtualInputManager:SendKeyEvent(true, enterKeyCode, false, game)
                    task.wait(0.05)
                    VirtualInputManager:SendKeyEvent(false, enterKeyCode, false, game)
                    task.wait(0.15)
                end
            end
            task.wait(0.1)
            GuiService.SelectedObject = previousSelection
        else
             warn("Fast Leave (Castle): Button not found")
        end
    end)
    if not successLeave then
        warn("Fast Leave Error (Castle):", errLeave)
    end
end
local teleportedToRoom25 = false 
_G.Toggle_AutoFarmCastle = Tab_Castle:CreateToggle({
    Name = "Auto Farm Castle",
    CurrentValue = false,
    Flag = "AutoFarmCastleToggle",
    Callback = function(Value)
        _G.AriseSettings.Toggles.AutoFarmCastle = Value
        if Value then
            task.wait(2)
            spawn(function()
                while _G.Toggle_AutoFarmCastle.CurrentValue do

                    if not _G.IsInCastle() then
                        break
                    end

                    playerRoot = getPlayerRoot()
                    if not playerRoot then
                        task.wait(0.5)
                        continue
                    end

                    local mainWorld = workspace:FindFirstChild("__Main") and workspace.__Main:FindFirstChild("__World")
                    if mainWorld then
                        local room1 = mainWorld:FindFirstChild("Room_1")
                        local firePortal = room1 and room1:FindFirstChild("FirePortal")
                        if firePortal and not teleportedToRoom25 then
                            local room25 = mainWorld:FindFirstChild("Room_25")
                            if not room25 or not room25:GetPivot() then
                                print("Room_25 not loaded, waiting...")
                                task.wait(1)
                                continue
                            end
                            pcall(function()
                                _G.MoveToEnemy(room25:GetPivot().Position, "Teleport", _G.AriseSettings.CastleTweenSpeed, false)
                            end)
                            task.wait()
                            teleportedToRoom25 = true
                        end
                    end

                    local targetFloorStr = Dropdown_CastleFloor.CurrentOption[1]
                    local action = Dropdown_ActionOnFloor.CurrentOption[1]

                    if targetFloorStr ~= "None" and action ~= "Do Nothing" then
                        local currentFloor = _G.GetCurrentCastleFloor()
                        local targetFloorNum = tonumber(targetFloorStr)

                        if currentFloor and targetFloorNum then
                            if currentFloor >= targetFloorNum then
                                if action == "Leave Castle" then
                                    Rayfield:Notify({ Title = "Auto Farm Castle", Content = "Target floor " .. targetFloorStr .. " reached. Leaving Castle.", Duration = 5, Image="log-out" })
                                    pcall(_G.leaveCastle)
                                    task.wait(5)
                                    break
                                end
                            end
                        end
                    end

                    local serverFolder = workspace:FindFirstChild("__Main") and workspace.__Main:FindFirstChild("__Enemies") and workspace.__Main.__Enemies:FindFirstChild("Server")
                    local nearestEnemyInstance = nil
                    local minDistance = math.huge
                    local hasAliveServerEnemy = false

                    if serverFolder then
                        for _, enemySource in ipairs(serverFolder:GetChildren()) do
                            if enemySource:IsA("Folder") or enemySource:IsA("Model") then
                                for _, enemyInstance in ipairs(enemySource:GetChildren()) do
                                    if enemyInstance:IsA("BasePart") then
                                        local isDead = enemyInstance:GetAttribute("Dead") or false
                                        if not isDead then
                                            hasAliveServerEnemy = true
                                            local distance = (playerRoot.Position - enemyInstance.Position).Magnitude
                                            if distance < minDistance then
                                                minDistance = distance
                                                nearestEnemyInstance = enemyInstance
                                            end
                                        end
                                    end
                                end
                            elseif enemySource:IsA("BasePart") then
                                local isDead = enemySource:GetAttribute("Dead") or false
                                if not isDead then
                                    hasAliveServerEnemy = true
                                    local distance = (playerRoot.Position - enemySource.Position).Magnitude
                                    if distance < minDistance then
                                        minDistance = distance
                                        nearestEnemyInstance = enemySource
                                    end
                                end
                            end
                        end
                    end

                    if not hasAliveServerEnemy and mainWorld then
                        local highestRoomNum = 0
                        local nextRoom = nil
                        for _, room in ipairs(mainWorld:GetChildren()) do
                            local roomNum = tonumber(room.Name:match("Room_(%d+)"))
                            if roomNum and roomNum > highestRoomNum then
                                highestRoomNum = roomNum
                                nextRoom = room
                            end
                        end
                        if highestRoomNum > 0 then
                            local targetRoomName = "Room_" .. (highestRoomNum + 1)
                            local targetRoom = mainWorld:FindFirstChild(targetRoomName)
                            if not targetRoom then
                                targetRoom = nextRoom
                            end
                            if targetRoom and targetRoom:GetPivot() then
                                pcall(function()
                                    _G.MoveToEnemy(targetRoom:GetPivot().Position, "Teleport", _G.AriseSettings.CastleTweenSpeed, false)
                                end)
                                task.wait()
                            end
                        end
                    end

                    if nearestEnemyInstance then
                        local nearestEnemyPosition = nearestEnemyInstance.Position
                        local needsToMove = minDistance > 5

                        if needsToMove then
                            local moveMode = _G.AriseSettings.CastleMoveMode or "Slow"
                            local tweenSpeed = _G.AriseSettings.CastleTweenSpeed or 150
                            pcall(function()
                                _G.MoveToEnemy(nearestEnemyPosition, moveMode, tweenSpeed, true)
                            end)
                        end

                        if _G.hasFreePet() then
                            pcall(function()
                                _G.AttackEnemy(nearestEnemyInstance.Name)
                            end)
                        end
                    else
                        task.wait(0.5)
                    end

                    local delay = Slider_CastleFarmDelay.CurrentValue
                    task.wait(delay)

                end

                playerRoot = getPlayerRoot()
                if playerRoot and playerRoot.Anchored then playerRoot.Anchored = false end

            end)
        else
            playerRoot = getPlayerRoot()
            if playerRoot and playerRoot.Anchored then
                playerRoot.Anchored = false
            end
        end
    end
})

getgenv().WINTER_EVENT_POSITION = CFrame.new(4755.9140625, 29.726438522338867, -2026.7510986328125)
local MIN_DISTANCE_WINTER = 700

-- == Funções Auxiliares ==
_G.IsInWinterIsland = function()
    local root = getPlayerRoot()
    if not root then return false end
    local playerPosition = root.Position
    local distance = (playerPosition - getgenv().WINTER_EVENT_POSITION.Position).Magnitude
    -- Usar a constante definida para consistência
    return distance < MIN_DISTANCE_WINTER
end

-- Helper para obter nome legível (mantido da lógica anterior)
local function getReadableNameFromInstance(enemyInstance)
     if not enemyInstance or not enemyInstance:IsA("BasePart") then return nil end
     local enemyId = enemyInstance:GetAttribute("Id")
     return getgenv().enemyIdMap and enemyId and getgenv().enemyIdMap[enemyId]
end

-- Função de ignorar (mantida como no seu script Rayfield, pois usa ipairs corretamente)
_G.shouldIgnoreWinterMob = function(enemyReadableName)
    if not enemyReadableName then return false end

    -- Acessa a lista diretamente das configurações (preenchida pelo callback do dropdown)
    local ignoredMobsList = _G.AriseSettings.WinterIgnoreMobs -- Assume que o callback preenche isso como um array
    if not ignoredMobsList or type(ignoredMobsList) ~= "table" then
        return false
    end

    -- Itera sobre o array de nomes ignorados
    for _, ignoredName in ipairs(ignoredMobsList) do
        if ignoredName == enemyReadableName then
            return true -- Encontrou na lista, ignorar
        end
    end

    return false -- Não encontrou, não ignorar
end


-- == Configuração da UI Rayfield ==
local Tab_Winter = Window:CreateTab("Winter")

-- == Seção de Opções ==
Tab_Winter:CreateSection("Winter Options")

-- Dropdown Move Mode (como no seu script)
_G.Dropdown_WinterMoveMode = Tab_Winter:CreateDropdown({
    Name = "Winter Move Mode",
    Options = {"Slow", "Fast"},
    CurrentOption = {"Slow"}, -- Mantido default
    Flag = "WinterMoveModeDropdown",
    Callback = function(Value)
        -- Rayfield retorna tabela mesmo para opção única
        if type(Value) == "table" and #Value > 0 then
            _G.AriseSettings.WinterMoveMode = Value[1]
        else
             _G.AriseSettings.WinterMoveMode = "Slow" -- Fallback
        end
    end
})

-- Slider Tween Speed (como no seu script)
_G.Slider_WinterTweenSpeed = Tab_Winter:CreateSlider({
    Name = "Tween Speed",
    Range = {100, 1000},
    Increment = 10,
    Suffix = " (Higher=Slower)",
    CurrentValue = 150,
    Flag = "WinterTweenSpeedSlider",
    Callback = function(Value)
        _G.AriseSettings.WinterTweenSpeed = Value
    end
})

-- Slider Farm Delay (como no seu script)
_G.Slider_WinterFarmDelay = Tab_Winter:CreateSlider({
    Name = "Winter Farm Delay",
    Range = {0, 5},
    Increment = 0.1,
    Suffix = "s (No kick >= 0.7)",
    CurrentValue = 0.1,
    Flag = "WinterFarmDelaySlider",
    Callback = function(Value)
        _G.AriseSettings.WinterFarmDelay = Value
    end
})

-- == Seção de Mobs ==
Tab_Winter:CreateSection("Winter Mobs")

-- Preparar lista de nomes (como no seu script)
local winterMobNames = {}
for mobName, _ in pairs(getgenv().winterIgnoreMobs or {}) do
    table.insert(winterMobNames, mobName)
end
table.sort(winterMobNames)

-- Dropdown Ignore Mobs (como no seu script, callback ajustado para garantir tabela)
_G.Dropdown_WinterIgnoreMobs = Tab_Winter:CreateDropdown({
    Name = "Winter Ignore Mobs",
    Options = winterMobNames,
    CurrentOption = {}, -- Default vazio para multi-seleção
    MultipleOptions = true,
    Flag = "WinterIgnoreMobsDropdown",
    Callback = function(Value)
        -- Value é uma tabela com os selecionados: {"Mob1", "Mob2"}
        if type(Value) == "table" then
             _G.AriseSettings.WinterIgnoreMobs = Value -- Armazena o array
        else
             _G.AriseSettings.WinterIgnoreMobs = {} -- Garante que seja sempre uma tabela
        end
        -- print("[CB] Winter Ignore Mobs set to:", table.concat(_G.AriseSettings.WinterIgnoreMobs, ", "))
    end
})

-- == Seção do Evento ==

_G.HopToServer = function(preferredServerType, maxPlayersAllowed)
    -- Serviços do Roblox
    local TPS = game:GetService("TeleportService")
    local Http = game:GetService("HttpService")
    local Players = game:GetService("Players") -- Adicionado para obter o jogador local
    local player = Players.LocalPlayer -- Obtém o jogador local

    -- Constantes e Configurações
    local Api = "https://games.roblox.com/v1/games/"
    local _place = game.PlaceId
    local MAX_PLAYERS = maxPlayersAllowed or 16 -- Define o tamanho máximo do servidor a procurar
    local RETRY_DELAY = 5 -- Tempo de espera entre tentativas de busca

    -- Variáveis de Estado
    local visitedServers = {} -- Para evitar tentar entrar no mesmo servidor repetidamente
    local foundAnything = "" -- Cursor para paginação da API
    local teleportSuccess = false -- Flag para indicar se o teleporte foi bem-sucedido

    -- Validação do Tipo de Servidor Preferido
    preferredServerType = preferredServerType or "Empty" -- Default para vazio
    if preferredServerType ~= "Full" and preferredServerType ~= "Empty" then
        warn("Invalid server type: " .. tostring(preferredServerType) .. ". Defaulting to Empty.")
        Rayfield:Notify({ -- *** NOTIFICAÇÃO RAYFIELD ***
            Title = "HopToServer Warning",
            Content = "Invalid server type specified. Defaulting to 'Empty'.",
            Duration = 5,
            Image = "warning"
        })
        preferredServerType = "Empty"
    end

    -- Define a ordem de busca baseada na preferência
    local sortOrder = preferredServerType == "Full" and "Desc" or "Asc"
    local _servers_base_url = Api .. _place .. "/servers/Public?sortOrder=" .. sortOrder .. "&limit=100"

    -- Função interna para buscar e processar uma página de servidores
    local function FetchAndProcessServers()
        local currentUrl = _servers_base_url
        if foundAnything ~= "" then
            currentUrl = currentUrl .. "&cursor=" .. foundAnything
        end

        local success, responseJson
        local fetchSuccess, responseBody = pcall(function()
            return game:HttpGet(currentUrl)
        end)

        if not fetchSuccess or not responseBody then
            warn("Failed to fetch servers: " .. tostring(responseBody))
            Rayfield:Notify({ -- *** NOTIFICAÇÃO RAYFIELD ***
                Title = "Server Fetch Error",
                Content = "Failed to get server list: " .. tostring(responseBody or "Network Error") .. ". Retrying in " .. RETRY_DELAY .. "s...",
                Duration = 5,
                Image = "error"
            })
            return nil -- Indica falha na busca
        end

        local decodeSuccess, responseData = pcall(function()
            return Http:JSONDecode(responseBody)
        end)

        if not decodeSuccess or type(responseData) ~= "table" or not responseData.data then
            warn("Invalid or empty API response: " .. responseBody)
            Rayfield:Notify({ -- *** NOTIFICAÇÃO RAYFIELD ***
                Title = "Server Fetch Error",
                Content = "Invalid server response format. Retrying in " .. RETRY_DELAY .. "s...",
                Duration = 5,
                Image = "error"
            })
            return nil -- Indica falha no processamento
        end

        -- Atualiza o cursor para a próxima página, se existir
        if responseData.nextPageCursor and responseData.nextPageCursor ~= "null" and responseData.nextPageCursor ~= nil then
            foundAnything = responseData.nextPageCursor
        else
            foundAnything = "" -- Chegou ao fim da lista
        end

        -- Processa os servidores encontrados nesta página
        for _, serverInfo in ipairs(responseData.data) do -- Usar ipairs para arrays JSON
            local serverId = tostring(serverInfo.id)
            local currentPlayers = tonumber(serverInfo.playing) or 0
            local maxServerPlayers = tonumber(serverInfo.maxPlayers) or 0

            -- Verifica se o servidor corresponde aos critérios
            -- (Mesmo tamanho máximo, não cheio, e ainda não visitado)
            if maxServerPlayers == MAX_PLAYERS and currentPlayers < maxServerPlayers and not visitedServers[serverId] then
                visitedServers[serverId] = true -- Marca como visitado para não tentar novamente
                Rayfield:Notify({ -- *** NOTIFICAÇÃO RAYFIELD ***
                    Title = "Teleporting to Server",
                    Content = "Joining server with " .. currentPlayers .. "/" .. maxServerPlayers .. " players (" .. preferredServerType .. ")...",
                    Duration = 4, -- Aumenta um pouco a duração
                    Image = "loading"
                })

                -- Tenta teleportar
                local tpSuccess, tpError = pcall(function()
                    TPS:TeleportToPlaceInstance(_place, serverId, player)
                end)

                if not tpSuccess then
                    warn("Teleport failed - Server: " .. serverId .. ", Error: " .. tostring(tpError))
                    Rayfield:Notify({ -- *** NOTIFICAÇÃO RAYFIELD ***
                        Title = "Teleport Failed",
                        Content = "Error: " .. tostring(tpError) .. ". Trying next server...",
                        Duration = 5,
                        Image = "error"
                    })
                    -- Continua no loop para tentar o próximo servidor
                else
                    -- Se pcall for bem-sucedido, o script geralmente para aqui devido ao teleporte.
                    -- Retornar true indica que uma tentativa válida foi iniciada.
                    teleportSuccess = true
                    return true
                end
                task.wait(1) -- Pequena pausa antes de tentar o próximo servidor na lista (se o TP falhar)
            end
        end
        return false -- Nenhum servidor adequado encontrado *nesta página*
    end

    -- Loop principal de tentativas
    local attempt = 1
    local maxAttempts = 7 -- Limita o número de páginas a verificar
    while attempt <= maxAttempts and not teleportSuccess do
        Rayfield:Notify({ -- *** NOTIFICAÇÃO RAYFIELD ***
             Title = "Server Hop",
             Content = "Searching for " .. preferredServerType .. " server (Attempt " .. attempt .. "/" .. maxAttempts .. ")...",
             Duration = 2,
             Image = "info"
        })
        local foundOnPage = FetchAndProcessServers()

        if foundOnPage then
             -- Teleporte foi iniciado com sucesso, a flag teleportSuccess já está true
             break
        end

        -- Se não encontrou servidor nesta página E não há mais páginas (foundAnything está vazio)
        if not foundOnPage and foundAnything == "" then
            Rayfield:Notify({ -- *** NOTIFICAÇÃO RAYFIELD ***
                Title = "No Suitable Servers",
                -- Mensagem ajustada para refletir a condição de busca (menor que MAX_PLAYERS)
                Content = "No servers found with < " .. MAX_PLAYERS .. " players (" .. preferredServerType .. "). Stopping search.",
                Duration = 5,
                Image = "warning"
            })
            break -- Sai do loop de tentativas
        end

        -- Se não encontrou nesta página, mas há mais páginas, espera e tenta a próxima
        if not foundOnPage then
            attempt = attempt + 1
            task.wait(RETRY_DELAY)
        end
        -- Se encontrou e teleportou (foundOnPage=true), o loop vai parar por causa de teleportSuccess=true
    end

    if not teleportSuccess then
         Rayfield:Notify({ -- *** NOTIFICAÇÃO RAYFIELD ***
              Title = "Server Hop Failed",
              Content = "Could not find a suitable server after " .. (attempt -1) .. " attempts.",
              Duration = 5,
              Image = "error"
         })
    end

    return teleportSuccess -- Retorna true se o teleporte foi iniciado, false caso contrário
end

local NOTIFICATION_DEBOUNCE_SECONDS = 8 -- Time between similar notifications
local HIGH_FROST_APPROX_SPAWN_SECONDS = 85
local MONARCH_MAX_SPAWN_MINUTE_IN_WINDOW = 8
local POST_LARUDA_MONARCH_WAIT_SECONDS = 30 -- Specific wait time after Laruda kill
local TELEPORT_WAIT_TIME = 2.5
local SERVER_HOP_WAIT_TIME = 20

Tab_Winter:CreateSection("Winter Event Settings")

_G.Toggle_ServerHop = Tab_Winter:CreateToggle({
    Name = "Server Hop",
    CurrentValue = _G.AriseSettings.Toggles.ServerHop or false, -- Load saved value
    Flag = "ServerHopToggleWinter", -- Unique flag
    Callback = function(Value)
        _G.AriseSettings.Toggles.ServerHop = Value
    end
})

_G.Slider_MonarchWaitTime = Tab_Winter:CreateSlider({
    Name = "Server Hop Delay", -- Corrected Name
    Range = {0, 90}, -- Example range (0 to 90 seconds)
    Increment = 5,
    Suffix = "s",
    CurrentValue = _G.AriseSettings.MonarchWaitTime or 30, -- Load saved value, default 30s
    Flag = "MonarchWaitTimeSlider", -- Consistent Flag
    Callback = function(Value)
        _G.AriseSettings.MonarchWaitTime = Value
    end
})

_G.Toggle_AutoWinter = Tab_Winter:CreateToggle({
    Name = "Auto Winter Farm", -- Updated name slightly
    CurrentValue = false,
    Flag = "AutoWinterToggle", -- Keep a flag if needed for saving/loading settings
    Callback = function(Value)
        _G.AriseSettings.Toggles.AutoWinter = Value -- Assuming you still use this for saving
        if Value then
            spawn(function()
                -- == Local State Variables (Reset on Activation) ==
                local previousPriority = _G.ActivityPriority
                local wasInEventWindow = false
                local snowMonarchKilledThisWindow = false
                local larudaKilledThisWindow = false
                local hasAttemptedMonarchWaitThisCycle = false
                local lastTargetedMonarchInstance = nil
                local lastNotificationTime = 0
                local lastNotifyContent = {}
                local eventCycleCompletedThisWindow = false

                -- == Debounced Notification Helper ==
                local function Notify(title, content, duration, image)
                    local currentTime = tick()
                    -- Debounce logic remains the same
                    if currentTime - lastNotificationTime >= NOTIFICATION_DEBOUNCE_SECONDS or not table.find(lastNotifyContent, content) then
                        if Rayfield and Rayfield.Notify then
                            Rayfield:Notify({ Title = title or "Auto Winter", Content = content or "", Duration = duration or 5, Image = image or "info" })
                        else
                            print(("[Auto Winter] %s: %s"):format(title or "Info", content or ""))
                        end
                        lastNotificationTime = currentTime
                        table.insert(lastNotifyContent, 1, content)
                        if #lastNotifyContent > 3 then table.remove(lastNotifyContent) end
                    end
                end

                -- == Main Loop ==
                while _G.Toggle_AutoWinter.CurrentValue do
                    local loopStartTime = tick()
                    local playerRoot = getPlayerRoot()

                    if not playerRoot then task.wait(5); continue end
                    if not _G.Toggle_AutoWinter.CurrentValue then break end -- Check the toggle's current value

                    local currentTime = os.date("*t")
                    local minutes = currentTime.min
                    local seconds = currentTime.sec
                    -- CHANGE 1: Define event window ONLY as xx:10 to xx:25
                    local isEventWindow = (minutes >= 10 and minutes < 25)

                    -- Reset flags on new window start
                    if isEventWindow and not wasInEventWindow then
                        Notify("Auto Winter", "Event window (10-25) started. Status reset.", 4, "info") -- Keep
                        snowMonarchKilledThisWindow = false
                        larudaKilledThisWindow = false
                        hasAttemptedMonarchWaitThisCycle = false
                        lastTargetedMonarchInstance = nil
                        eventCycleCompletedThisWindow = false
                        lastNotifyContent = {}
                    end
                    wasInEventWindow = isEventWindow

                    -- 1. Pre-computation / Checks (Dungeon/Castle)
                    if _G.IsInDungeon() or _G.IsInCastle() then
                        Notify("Auto Winter Paused", "Inside Dungeon/Castle.", 5, "warning") -- Keep
                        if _G.ActivityPriority == "Winter" then _G.ActivityPriority = previousPriority or "None" end
                        task.wait(5); continue
                    end

                    -- 2. Logic OUTSIDE Event Window
                    if not isEventWindow then
                        if _G.ActivityPriority == "Winter" then
                            Notify("Auto Winter", "Event window ended.", 4, "info") -- Keep
                            if _G.Toggle_AutoFarm.CurrentValue then
                                _G.ActivityPriority = "Farming"
                            else
                                _G.ActivityPriority = "None"
                            end
                            if _G.SavedFarmPosition then
                                -- Notify("Auto Winter", "Returning to saved farm position.", 4, "loading") -- Commented out
                                _G.TeleportTo(_G.SavedFarmPosition)
                                task.wait(TELEPORT_WAIT_TIME)
                                playerRoot = getPlayerRoot(); if playerRoot then playerRoot.Anchored = false end
                            end
                        end

                        -- CHANGE 2: Adjust wait calculation for next window (always xx:10)
                        local wait_seconds = 0; local targetMinute = 10; local targetHour = currentTime.hour
                        if minutes < 10 then
                            -- Waiting for xx:10 of the current hour
                            wait_seconds = (targetMinute - minutes - 1) * 60 + (60 - seconds)
                        else -- minutes >= 25 (since isEventWindow is false)
                            -- Waiting for xx:10 of the *next* hour
                            targetHour = (targetHour + 1) % 24
                            wait_seconds = ((targetMinute + 60) - minutes - 1) * 60 + (60 - seconds)
                        end
                        wait_seconds = math.max(1, wait_seconds)
                        Notify("Auto Winter Paused", "Waiting " .. math.ceil(wait_seconds) .. "s until " .. string.format("%02d:%02d", targetHour, targetMinute), 5, "timer") -- Keep

                        local waitEndTime = tick() + wait_seconds
                        while tick() < waitEndTime and _G.Toggle_AutoWinter.CurrentValue do
                            local now = os.date("*t")
                            -- CHANGE 2.1: Update break condition in wait loop
                            if (now.min >= 10 and now.min < 25) then break end
                            task.wait(1)
                        end
                        continue
                    end

                    -- 3. Logic INSIDE Event Window (Now only xx:10 to xx:25)
                    if isEventWindow then
                        -- Skip event logic if cycle is already completed
                        if eventCycleCompletedThisWindow then
                            Notify("Auto Winter", "Event cycle completed this window. Waiting.", 5, "info") -- Keep
                            if _G.Toggle_AutoFarm.CurrentValue then
                                _G.ActivityPriority = "Farming"
                            else
                                _G.ActivityPriority = "None"
                            end
                            if _G.SavedFarmPosition then
                                local distanceToSaved = playerRoot and (playerRoot.Position - _G.SavedFarmPosition.Position).Magnitude or math.huge
                                if distanceToSaved > 1000 then
                                    -- Notify("Auto Winter", "Returning to saved farm position.", 4, "loading") -- Commented out
                                    _G.TeleportTo(_G.SavedFarmPosition)
                                    task.wait(TELEPORT_WAIT_TIME)
                                    playerRoot = getPlayerRoot(); if playerRoot then playerRoot.Anchored = false end
                                end
                            end

                            -- CHANGE 3: Adjust wait calculation until window ends (always xx:25)
                            local wait_seconds = 0
                            -- We know minutes are >= 10 and < 25 here
                            wait_seconds = (25 - minutes - 1) * 60 + (60 - seconds)
                            wait_seconds = math.max(1, wait_seconds)
                            Notify("Auto Winter", "Waiting " .. math.ceil(wait_seconds) .. "s until event window ends (xx:25).", 5, "timer") -- Keep

                            local waitEndTime = tick() + wait_seconds
                            while tick() < waitEndTime and _G.Toggle_AutoWinter.CurrentValue do
                                local now = os.date("*t")
                                -- CHANGE 3.1: Update break condition in wait loop
                                if not (now.min >= 10 and now.min < 25) then break end
                                task.wait(1)
                            end
                            continue
                        end

                        -- Set priority & Teleport if needed
                        if _G.ActivityPriority ~= "Winter" then
                            -- Notify("Auto Winter", "Setting activity to Winter.", 3, "info") -- Commented out
                            previousPriority = _G.ActivityPriority; _G.ActivityPriority = "Winter"; task.wait(0.1)
                        end
                        if not _G.IsInWinterIsland() then
                            Notify("Auto Winter", "Teleporting to Winter Island...", 4, "loading") -- Keep
                            _G.TeleportTo(getgenv().WINTER_EVENT_POSITION); task.wait(TELEPORT_WAIT_TIME)
                            playerRoot = getPlayerRoot()
                            if not playerRoot then Notify("Auto Winter Error", "Player lost after TP.", 5, "error"); task.wait(5); continue end -- Keep Error
                            if playerRoot then playerRoot.Anchored = false end
                            if not _G.IsInWinterIsland() then Notify("Auto Winter Error", "Failed TP to Winter Island.", 5, "error"); task.wait(3); continue end -- Keep Error
                        end

                        -- Main logic block for Winter activity
                        if _G.ActivityPriority == "Winter" then
                            -- Check status of previously targeted Monarch
                            if lastTargetedMonarchInstance and not snowMonarchKilledThisWindow then
                                local monarchStillExists, isDead = false, true
                                local success, err = pcall(function()
                                    if lastTargetedMonarchInstance and lastTargetedMonarchInstance.Parent ~= nil then -- Check instance validity
                                        monarchStillExists = true
                                        isDead = lastTargetedMonarchInstance:GetAttribute("Dead") or false
                                    end
                                end)
                                if not success or not monarchStillExists or isDead then
                                    Notify("Auto Winter", "Snow Monarch defeated/despawned.", 4, "success") -- Keep
                                    snowMonarchKilledThisWindow = true; lastTargetedMonarchInstance = nil
                                    hasAttemptedMonarchWaitThisCycle = true -- Mark wait as attempted if monarch is gone
                                end
                            end

                            -- Find enemies
                            local serverFolder = workspace:FindFirstChild("__Main") and workspace:FindFirstChild("__Main"):FindFirstChild("__Enemies") and workspace:FindFirstChild("__Main"):FindFirstChild("__Enemies"):FindFirstChild("Server")
                            if not serverFolder then Notify("Auto Winter Error", "Enemy folder not found.", 5, "error"); task.wait(5); continue end -- Keep Error

                            local minDistance = MIN_DISTANCE_WINTER + 1; local nearestEnemyInstance = nil
                            local aliveNonIgnoredCount = 0
                            local hasHighFrost, hasLaruda, hasSnowMonarch = false, false, false
                            local highFrostInstance, larudaInstance, snowMonarchInstance = nil, nil, nil
                            local serverEnemies = serverFolder:GetChildren()

                            for _, enemyInstance in ipairs(serverEnemies) do
                                if enemyInstance and enemyInstance:IsA("BasePart") and enemyInstance.Parent == serverFolder then
                                    local isDead = enemyInstance:GetAttribute("Dead") or false
                                    if not isDead then
                                        local enemyPosition = enemyInstance.Position
                                        if (enemyPosition - getgenv().WINTER_EVENT_POSITION.Position).Magnitude < MIN_DISTANCE_WINTER then
                                            local readableEnemyName = getReadableNameFromInstance(enemyInstance)
                                            local isIgnored = _G.shouldIgnoreWinterMob(readableEnemyName)
                                            if not isIgnored then
                                                aliveNonIgnoredCount = aliveNonIgnoredCount + 1
                                                local distance = (playerRoot.Position - enemyPosition).Magnitude
                                                if readableEnemyName == "Snow Monarch" then hasSnowMonarch, snowMonarchInstance = true, enemyInstance
                                                elseif readableEnemyName == "Laruda" then hasLaruda, larudaInstance = true, enemyInstance
                                                elseif readableEnemyName == "High Frost" then hasHighFrost, highFrostInstance = true, enemyInstance
                                                else if distance < minDistance then minDistance, nearestEnemyInstance = distance, enemyInstance end end
                                            end
                                        end
                                    end
                                end
                            end

                            -- Determine Target
                            local targetEnemy = nil
                            if hasSnowMonarch and not _G.shouldIgnoreWinterMob("Snow Monarch") and not snowMonarchKilledThisWindow then targetEnemy = snowMonarchInstance
                            elseif hasLaruda and not _G.shouldIgnoreWinterMob("Laruda") and not larudaKilledThisWindow then targetEnemy = larudaInstance -- Added check for larudaKilledThisWindow
                            elseif hasHighFrost and not _G.shouldIgnoreWinterMob("High Frost") then targetEnemy = highFrostInstance
                            elseif nearestEnemyInstance then targetEnemy = nearestEnemyInstance
                            end

                            -- Action: Attack, Move, Wait, or Finish
                            if targetEnemy then
                                hasAttemptedMonarchWaitThisCycle = false -- Reset monarch wait attempt if we found a target
                                local targetName = getReadableNameFromInstance(targetEnemy)
                                local targetPosition = targetEnemy.Position
                                local distanceToTarget = (playerRoot.Position - targetPosition).Magnitude
                                if distanceToTarget > 15 then
                                    local moveMode = (_G.Dropdown_WinterMoveMode and _G.Dropdown_WinterMoveMode.CurrentOption and _G.Dropdown_WinterMoveMode.CurrentOption[1]) or "Slow"
                                    local tweenSpeed = (_G.Slider_WinterTweenSpeed and _G.Slider_WinterTweenSpeed.CurrentValue) or 150
                                    _G.MoveToEnemy(targetPosition, moveMode == "Fast" and "Teleport" or "Tween", tweenSpeed, false)
                                    task.wait(0.1) -- Short wait after moving
                                end
                                if _G.hasFreePet() then
                                    -- Notify("Auto Winter", "Attacking " .. targetName, 3, "info") -- Commented out (too frequent)
                                    _G.AttackEnemy(targetEnemy.Name)
                                    if targetEnemy == snowMonarchInstance then lastTargetedMonarchInstance = targetEnemy
                                    elseif targetName == "Laruda" then larudaKilledThisWindow = true -- Mark Laruda killed *after* attacking
                                    end
                                else
                                    -- Notify("Auto Winter", "Waiting for free pet...", 1, "timer") -- Optional: uncomment if needed
                                    task.wait(0.5)
                                end
                            else -- No target found
                                -- CHANGE 4: Simplify windowStartMinute calculation
                                local windowStartMinute = 10 -- Always starts at 10 now
                                local secondsSinceWindowStart = (minutes - windowStartMinute) * 60 + seconds
                                local minutesIntoEvent = secondsSinceWindowStart / 60

                                -- Check for High Frost spawn early
                                if not hasHighFrost and not hasLaruda and not hasSnowMonarch and aliveNonIgnoredCount == 0 and secondsSinceWindowStart < HIGH_FROST_APPROX_SPAWN_SECONDS and not _G.shouldIgnoreWinterMob("High Frost") then
                                    local waitTime = math.max(1, HIGH_FROST_APPROX_SPAWN_SECONDS - secondsSinceWindowStart)
                                    Notify("Auto Winter", "Waiting for High Frost (" .. string.format("%.0f", waitTime) .. "s left)...", math.min(5, waitTime), "timer") -- Keep
                                    task.wait(waitTime)
                                    continue -- Re-evaluate after waiting
                                end

                                -- Monarch Wait Logic
                                local monarchWaitSliderValue = (_G.Slider_MonarchWaitTime and _G.Slider_MonarchWaitTime.CurrentValue) or 0
                                local canWaitForMonarch = not _G.shouldIgnoreWinterMob("Snow Monarch")
                                local conditionsMetForWait = aliveNonIgnoredCount == 0 and
                                                            not hasAttemptedMonarchWaitThisCycle and
                                                            not snowMonarchKilledThisWindow and
                                                            minutesIntoEvent <= MONARCH_MAX_SPAWN_MINUTE_IN_WINDOW and
                                                            canWaitForMonarch and
                                                            monarchWaitSliderValue > 0

                                if conditionsMetForWait then
                                    local maxWaitTime
                                    local waitReason
                                    if larudaKilledThisWindow then
                                        maxWaitTime = POST_LARUDA_MONARCH_WAIT_SECONDS
                                        waitReason = "post-Laruda"
                                    else
                                        maxWaitTime = monarchWaitSliderValue
                                        waitReason = "slider setting"
                                    end

                                    Notify("Auto Winter", "Island clear. Waiting up to " .. string.format("%.0f", maxWaitTime) .. "s for Monarch ("..waitReason..")...", math.max(5, maxWaitTime), "timer") -- Keep
                                    hasAttemptedMonarchWaitThisCycle = true
                                    local waitStart = tick()
                                    local foundMonarchDuringWait = false

                                    while tick() - waitStart < maxWaitTime and _G.Toggle_AutoWinter.CurrentValue and not snowMonarchKilledThisWindow do
                                        -- Check for monarch appearance during wait
                                        local monarchCheckFolder = workspace:FindFirstChild("__Main"):FindFirstChild("__Enemies"):FindFirstChild("Server")
                                        if monarchCheckFolder then
                                            for _, enemy in ipairs(monarchCheckFolder:GetChildren()) do
                                                if enemy and enemy:IsA("BasePart") and getReadableNameFromInstance(enemy) == "Snow Monarch" and not (enemy:GetAttribute("Dead") or false) then
                                                    foundMonarchDuringWait = true; break
                                                end
                                            end
                                        end
                                        if foundMonarchDuringWait then
                                            Notify("Auto Winter", "Snow Monarch detected during wait!", 3, "success") -- Keep
                                            break
                                        end
                                        task.wait(1) -- Check every second
                                    end

                                    if not foundMonarchDuringWait and not snowMonarchKilledThisWindow then
                                        -- Notify("Auto Winter", "Snow Monarch wait time ("..string.format("%.0f", maxWaitTime).."s) finished.", 4, "info") -- Commented out
                                    end

                                    -- After waiting (or finding monarch), loop again to target or proceed
                                    task.wait(0.1); continue

                                elseif aliveNonIgnoredCount == 0 then
                                    -- Island clear AND (wait done, not needed, or conditions not met)
                                    if snowMonarchKilledThisWindow then Notify("Auto Winter", "Island clear. Monarch already dealt with.", 4, "info") -- Keep
                                    elseif hasAttemptedMonarchWaitThisCycle then Notify("Auto Winter", "Island clear after waiting.", 4, "info") -- Keep
                                    elseif monarchWaitSliderValue <= 0 then Notify("Auto Winter", "Island clear. Monarch wait disabled (slider=0).", 4, "info") -- Keep
                                    elseif not canWaitForMonarch then Notify("Auto Winter Warning", "Island clear. Cannot wait: Snow Monarch is ignored.", 5, "warning") -- Keep Warning
                                    elseif minutesIntoEvent > MONARCH_MAX_SPAWN_MINUTE_IN_WINDOW then Notify("Auto Winter", "Island clear. Too late for Monarch spawn.", 4, "info") -- Keep
                                    -- else Notify("Auto Winter", "Island clear. Proceeding...", 4, "info") -- Commented out (redundant with cycle complete message)
                                    end

                                    eventCycleCompletedThisWindow = true -- Mark cycle as done for this window

                                    if _G.AriseSettings.Toggles.ServerHop then -- Check server hop setting
                                        Notify("Auto Winter", "Event cycle complete. Hopping server...", 5, "loading") -- Keep
                                        task.wait(1.5) -- Brief pause before hopping
                                        -- Attempt hop multiple times (adjust as needed)
                                        local hopSuccess = false
                                        for i = 1, 3 do
                                            _G.HopToServer()
                                            task.wait(15) -- Wait for potential load/rejoin
                                            -- Add a check here if possible to see if hop was successful (e.g., check server ID change)
                                            -- If successful: hopSuccess = true; break
                                        end
                                        -- Assuming hop takes time, wait regardless
                                        Notify("Auto Winter", "Server hop initiated. Waiting...", SERVER_HOP_WAIT_TIME, "timer") -- Keep
                                        task.wait(SERVER_HOP_WAIT_TIME)
                                        -- Reset state for the new server/potential same server if hop failed
                                        snowMonarchKilledThisWindow = false
                                        larudaKilledThisWindow = false
                                        hasAttemptedMonarchWaitThisCycle = false
                                        lastTargetedMonarchInstance = nil
                                        eventCycleCompletedThisWindow = false -- Reset cycle completion for new server attempt
                                        lastNotifyContent = {}
                                    else
                                        -- No server hop, wait for the window to end
                                        --Notify("Auto Winter", "Event cycle complete. Waiting for window end (Server Hop Off).", 5, "timer") -- Keep
                                        if _G.Toggle_AutoFarm.CurrentValue then
                                            _G.ActivityPriority = "Farming"
                                        else
                                            _G.ActivityPriority = "None"
                                        end
                                        if _G.SavedFarmPosition then
                                            local distanceToSaved = playerRoot and (playerRoot.Position - _G.SavedFarmPosition.Position).Magnitude or math.huge
                                            if distanceToSaved > 10 then
                                                -- Notify("Auto Winter", "Returning to saved farm position.", 4, "loading") -- Commented out
                                                _G.TeleportTo(_G.SavedFarmPosition)
                                                task.wait(TELEPORT_WAIT_TIME)
                                                playerRoot = getPlayerRoot(); if playerRoot then playerRoot.Anchored = false end
                                            end
                                        end

                                        -- CHANGE 3 (Repeated logic block): Adjust wait calculation until window ends (always xx:25)
                                        local wait_seconds = 0
                                        -- We know minutes are >= 10 and < 25 here
                                        wait_seconds = (25 - minutes - 1) * 60 + (60 - seconds)
                                        wait_seconds = math.max(1, wait_seconds)

                                        local waitEndTime = tick() + wait_seconds
                                        while tick() < waitEndTime and _G.Toggle_AutoWinter.CurrentValue do
                                            local now = os.date("*t")
                                            -- CHANGE 3.1 (Repeated logic block): Update break condition
                                            if not (now.min >= 10 and now.min < 25) then break end
                                            task.wait(1)
                                        end
                                    end
                                    continue -- Go to the start of the main loop after handling cycle completion
                                else
                                    -- Only ignored mobs remaining
                                    -- Notify("Auto Winter", "Only ignored mobs remaining. Waiting briefly...", 3, "timer") -- Commented out
                                    task.wait(1) -- Wait briefly if only ignored mobs are left
                                end
                            end
                        end
                    end

                    -- General loop delay
                    local delay = (_G.Slider_WinterFarmDelay and _G.Slider_WinterFarmDelay.CurrentValue) or 0.5
                    local elapsedTime = tick() - loopStartTime
                    if elapsedTime < delay then task.wait(delay - elapsedTime) else task.wait() end -- task.wait() ensures yielding
                end

                -- == Cleanup ==
                if _G.ActivityPriority == "Winter" then
                    if _G.Toggle_AutoFarm.CurrentValue then
                        _G.ActivityPriority = "Farming"
                    else
                        _G.ActivityPriority = "None"
                    end
                end
                local finalRoot = getPlayerRoot(); if finalRoot and finalRoot.Anchored then finalRoot.Anchored = false end
            end)
        else
            -- Code to run when the toggle is turned OFF
            if _G.ActivityPriority == "Winter" then
                if _G.Toggle_AutoFarm.CurrentValue then _G.ActivityPriority = "Farming" else _G.ActivityPriority = "None" end
            end
            local finalRoot = getPlayerRoot(); if finalRoot and finalRoot.Anchored then finalRoot.Anchored = false end
        end
    end
})

Tab_Teleport = Window:CreateTab("Teleport")

Tab_Teleport:CreateSection("World Teleport")

task.wait()

_G.Toggle_TeleportMode = Tab_Teleport:CreateToggle({
    Name = "Teleport Mode",
    Description = "Off: Sets spawn and resets\nOn: Teleport",
    CurrentValue = true,
    Flag = "TeleportModeToggle",
    Callback = function(Value)
        _G.AriseSettings.Toggles.TeleportMode = Value
    end
})

task.wait()

_G.ChangeWorld = function(worldName)
    local args = {
        [1] = {
            [1] = {
                ["Event"] = "ChangeSpawn",
                ["Spawn"] = worldName
            },
            [2] = ""
        }
    }
    args[1][2] = "\n"  dataRemoteEvent:FireServer(unpack(args))
    args[1][2] = "\t"  dataRemoteEvent:FireServer(unpack(args))
    args[1][2] = "\7"  dataRemoteEvent:FireServer(unpack(args))
    args[1][2] = "\8"  dataRemoteEvent:FireServer(unpack(args))
    args[1][2] = "\5"  dataRemoteEvent:FireServer(unpack(args))
    args[1][2] = "\11"  dataRemoteEvent:FireServer(unpack(args))
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = 0
        player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
    end
end

local function teleportToWorld(worldName)
    if _G.Toggle_TeleportMode.CurrentValue then
        local targetCFrame = _G.worldSpawns[worldName]
        if targetCFrame then
            _G.TeleportTo(targetCFrame)
        end
    else
        _G.ChangeWorld(worldName)
    end
end

Tab_Teleport:CreateButton({
    Name = "Solo",
    Callback = function() teleportToWorld("SoloWorld") end
})
Tab_Teleport:CreateButton({
    Name = "Naruto",
    Callback = function() teleportToWorld("NarutoWorld") end
})
Tab_Teleport:CreateButton({
    Name = "One Piece",
    Callback = function() teleportToWorld("OPWorld") end
})
Tab_Teleport:CreateButton({
    Name = "Bleach",
    Callback = function() teleportToWorld("BleachWorld") end
})
Tab_Teleport:CreateButton({
    Name = "Black Clover",
    Callback = function() teleportToWorld("BCWorld") end
})
Tab_Teleport:CreateButton({
    Name = "Chainsaw Man",
    Callback = function() teleportToWorld("ChainsawWorld") end
})
Tab_Teleport:CreateButton({
    Name = "Jojo",
    Callback = function() teleportToWorld("JojoWorld") end
})
Tab_Teleport:CreateButton({
    Name = "Dragon Ball",
    Callback = function() teleportToWorld("DBWorld") end
})
Tab_Teleport:CreateButton({
    Name = "One Punch Man",
    Callback = function() teleportToWorld("OPMWorld") end
})
Tab_Teleport:CreateButton({
    Name = "Dan Dan Dan Dan Dan Dan Dan Dan Dan",
    Callback = function() teleportToWorld("DanWorld") end
})

-- Funções para Salvar/Carregar Posição
function SavePlayerPosition()
    local root = getPlayerRoot()
    if not root then
        Rayfield:Notify({ Title = "Error", Content = "Cannot save position: Player character not loaded!", Duration = 3, Image="alert-circle" })
        return
    end

    local currentCFrame = root.CFrame
    local pos = currentCFrame.Position
    local look = currentCFrame.LookVector -- Salva LookVector para orientação

    -- Formato: pos.X,pos.Y,pos.Z,look.X,look.Y,look.Z
    local cframeString = string.format("%.2f,%.2f,%.2f,%.2f,%.2f,%.2f",
                                       pos.X, pos.Y, pos.Z,
                                       look.X, look.Y, look.Z)

    _G.SavedFarmPosition = CFrame.new(pos, look)

    local success, err = pcall(function()
        writefile("position_arise.txt", cframeString)
    end)

    if success then
        Rayfield:Notify({ Title = "Success", Content = "Position saved!", Duration = 3, Image="check-circle" })
    else
        Rayfield:Notify({ Title = "Error", Content = "Failed to save position: " .. tostring(err), Duration = 5, Image="alert-circle" })
    end
end

_G.LoadPlayerPosition = function()
    if not isfile("position_arise.txt") then
        Rayfield:Notify({ Title = "Error", Content = "No saved position found.", Duration = 3, Image="alert-circle" })
        return nil
    end

    local cframeString = nil
    local successRead, resultRead = pcall(function()
        cframeString = readfile("position_arise.txt")
    end)

    if not successRead or not cframeString then
        Rayfield:Notify({ Title = "Error", Content = "Failed to read position_arise.txt: " .. tostring(resultRead), Duration = 5, Image="alert-circle" })
        return nil
    end

    local components = {}
    for numStr in string.gmatch(cframeString, "[^,]+") do
        local num = tonumber(numStr)
        if not num then
            Rayfield:Notify({ Title = "Error", Content = "Invalid data format in position_arise.txt.", Duration = 5, Image="alert-circle" })
            return nil -- Número inválido encontrado
        end
        table.insert(components, num)
    end

    if #components ~= 6 then
        Rayfield:Notify({ Title = "Error", Content = "Incorrect data format in position_arise.txt (Expected 6 values).", Duration = 5, Image="alert-circle" })
        return nil -- Esperado 6 componentes (Pos X,Y,Z, Look X,Y,Z)
    end

    local pos = Vector3.new(components[1], components[2], components[3])
    local look = Vector3.new(components[4], components[5], components[6])
    local lookAtPos = pos + look -- Calcula o ponto para onde olhar

    _G.SavedFarmPosition = CFrame.new(pos, lookAtPos)
    return CFrame.new(pos, lookAtPos)
end

function TeleportToSavedPosition()
    local loadedCFrame = _G.LoadPlayerPosition()
    if loadedCFrame then
        _G.TeleportTo(loadedCFrame) -- Usa a função TeleportTo existente
        Rayfield:Notify({ Title = "Teleport", Content = "Teleported to saved position.", Duration = 3, Image="map-pin" })
    end
end

Tab_Teleport:CreateSection("Server Hop")

Tab_Teleport:CreateButton({
    Name = "Server Hop",
    Callback = function()
        _G.HopToServer()
    end
})

-- Adiciona botões na UI
Tab_Teleport:CreateSection("Saved Position")

Tab_Teleport:CreateButton({
    Name = "Save Current Position",
    Callback = SavePlayerPosition
})

Tab_Teleport:CreateButton({
    Name = "Teleport to Position",
    Callback = TeleportToSavedPosition
})

local Tab_Settings = Window:CreateTab("Settings")

Tab_Settings:CreateSection("Settings")

_G.Toggle_AutoExecute = Tab_Settings:CreateToggle({
    Name = "Auto Execute",
    Description = "Auto Execute the script when you teleport",
    CurrentValue = false,
    Flag = "AutoExecuteToggle",
    Callback = function(Value)
        if Value then
            if not queueteleport then
                Rayfield:Notify({
                    Title = "Error",
                    Content = "Your exploit does not support this feature.",
                    Duration = 5
                })
                _G.Toggle_AutoExecute:SetValue(false)
                return
            end
            Rayfield:Notify({
                Title = "Auto Execute",
                Content = "Script will execute in the new server.",
                Duration = 3
            })
        end
    end
})

local themeNames = {
"Default",
"Ocean",
"AmberGlow",
"Light",
"Amethyst",
"Green",
"Bloom",
"DarkBlue",
"Serenity"
}

Tab_Settings:CreateDropdown({
    Name = "Theme",
    Options = themeNames, 
    CurrentOption = {"Default"}, 
    MultipleOptions = false, 
    Flag = "SelectedTheme", 
    Callback = function(selectedOptions)
        
        if selectedOptions and #selectedOptions > 0 then
            local selectedThemeName = selectedOptions[1]      
            Window.ModifyTheme(selectedThemeName)
            
        end
    end,
})

local generateRandomName = function()
    local randomName = ""
    for i = 1, 10 do
        randomName = randomName .. string.char(math.random(97, 122))
    end
    return randomName
end

_G.Toggle_HideName = Tab_Settings:CreateToggle({
    Name = "Hide Name (Clientside)",
    CurrentValue = false,
    Flag = "HideNameToggle",
    Callback = function(Value)
        _G.AriseSettings.Toggles.HideNameToggle = Value
        local playerMain = workspace.__Main.__Players
        local playerObj = playerMain:FindFirstChild(player.Name)
        
        if playerObj and playerObj:FindFirstChild("HumanoidRootPart") then
            local title = playerObj.HumanoidRootPart.PlayerTag.Main.Title
            if title then
                if Value then
                    title.Text = "@" .. generateRandomName()
                else
                    title.Text = "@" .. player.Name
                end
            end
        end
    end
})

task.wait(0.1)
Rayfield:LoadConfiguration()

local loadedWorldTable = _G.Dropdown_World.CurrentOption
local loadedWorld = nil
if type(loadedWorldTable) == "table" and #loadedWorldTable > 0 then
    loadedWorld = loadedWorldTable[1]
end

if loadedWorld and _G.Dropdown_Enemy then
    local loadedEnemyList = getgenv().enemyList[loadedWorld] or {}
    local sR, eR = pcall(_G.Dropdown_Enemy.Refresh, _G.Dropdown_Enemy, loadedEnemyList)
    if not sR then warn("[Config] Error Refresh:", eR) end
else
    warn("[Config] Could not refresh enemy list on load (World or Enemy Dropdown invalid).")
end

if _G.LoadPlayerPosition() == nil then
    Rayfield:Notify({
        Title = "Save Position",
        Content = "No saved position found, saving current position.",
        Duration = 3,
        Image = "alert-circle"
    })
    SavePlayerPosition()
end

player.OnTeleport:Connect(function(State)
    if _G.Toggle_AutoExecute.CurrentValue and not TeleportCheck and queueteleport then
        TeleportCheck = true
        queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/ErisvaldoBalbino/w/refs/heads/main/arework.lua'))()")
        Rayfield:Notify({
            Title = "Execute Queued",
            Content = "Script will execute in the new server.",
            Duration = 3
        })
    end
end)

local framePosition = UDim2.new(0, 100, 0, 100)

local dragConnection = nil

local function createMinimizeFrame()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "MinimizeGui"
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local frame = Instance.new("TextButton")
    frame.Name = "MinimizeButton"
    frame.Size = UDim2.new(0, 50, 0, 50)
    frame.Position = framePosition
    frame.BackgroundColor3 = Color3.new(0, 0, 0)
    frame.Text = "twvz"
    frame.TextColor3 = Color3.new(1, 1, 1)
    frame.TextSize = 14
    frame.Font = Enum.Font.SourceSansBold
    frame.TextScaled = false
    frame.Parent = screenGui

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 8)
    uiCorner.Parent = frame

    local function minimizeWindow() 
        if Rayfield:IsVisible() then
            Rayfield:SetVisibility(false)
        else
            Rayfield:SetVisibility(true)
        end
    end

    frame.MouseButton1Click:Connect(minimizeWindow)

    local dragging = false
    local dragInput = nil
    local dragStart = nil
    local startPos = nil
    local currentTween = nil

    local RunService = game:GetService("RunService")

    if dragConnection then
        dragConnection:Disconnect()
        dragConnection = nil
    end

    frame.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
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
            
            local newPosition = UDim2.new(
                startPos.X.Scale, 
                startPos.X.Offset + delta.X, 
                startPos.Y.Scale, 
                startPos.Y.Offset + delta.Y
            )
            
            if currentTween then
                currentTween:Cancel()
            end
            
            local tweenInfo = TweenInfo.new(0.05, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            currentTween = TweenService:Create(frame, tweenInfo, {Position = newPosition})
            currentTween:Play()
            
            framePosition = newPosition
        end
    end)
    
    frame.AncestryChanged:Connect(function()
        if not frame:IsDescendantOf(game) and dragConnection then
            dragConnection:Disconnect()
            dragConnection = nil
        end
    end)
end

createMinimizeFrame()

game.Players.LocalPlayer.CharacterAdded:Connect(createMinimizeFrame)
