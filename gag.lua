local Library = loadstring(game:HttpGetAsync("https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau"))()
local SaveManager = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/SaveManager.luau"))()
local InterfaceManager = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/InterfaceManager.luau"))()

if not game:IsLoaded() then
    game.Loaded:Wait()
end

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local sellPos = Vector3.new(61.5898132, 2.99999976, 0.426800638)

local seeds = {
    "Carrot",
    "Strawberry",
    "Blueberry",
    "Orange Tulip",
    "Tomato",
    "Corn",
    "Daffodil",
    "Watermelon",
    "Pumpkin",
    "Apple",
    "Bamboo",
    "Coconut",
    "Cactus",
    "Dragon Fruit",
    "Mango",
    "Grape",
    "Mushroom",
    "Pepper",
    "Cacao",
}

local seedsPrices = {
    ["Carrot"] = 10,
    ["Strawberry"] = 50,
    ["Blueberry"] = 400,
    ["Orange Tulip"] = 600,
    ["Tomato"] = 800,
    ["Corn"] = 1300,
    ["Daffodil"] = 1000,
    ["Watermelon"] = 2500,
    ["Pumpkin"] = 3000,
    ["Apple"] = 3250,
    ["Bamboo"] = 4000,
    ["Coconut"] = 6000,
    ["Cactus"] = 15000,
    ["Dragon Fruit"] = 50000,
    ["Mango"] = 100000,
    ["Grape"] = 850000,
    ["Mushroom"] = 150000,
    ["Pepper"] = 1000000,
    ["Cacao"] = 2500000,
}

local gears = {
    "Watering Can",
    "Trowel",
    "Recall Wrench",
    "Basic Sprinkler",
    "Advanced Sprinkler",
    "Godly Sprinkler",
    "Lightning Rod",
    "Master Sprinkler",
    "Favorite Tool",
}

local function getPlayerRoot()
    return player.Character and player.Character:FindFirstChild("HumanoidRootPart")
end

local function getCorrectFarmPlotFolder()
    local farmWorkspace = workspace:FindFirstChild("Farm")
    if not farmWorkspace then
        return nil
    end

    local playerName = player.Name

    for _, plotFolder in pairs(farmWorkspace:GetChildren()) do
        local importantFolder = plotFolder:FindFirstChild("Important")
        if importantFolder then
            local dataFolder = importantFolder:FindFirstChild("Data")
            if dataFolder then
                local ownerObject = dataFolder:FindFirstChild("Owner")
                if ownerObject and ownerObject:IsA("StringValue") then
                    if ownerObject.Value == playerName then
                        return plotFolder
                    end
                end
            end
        end
    end
    return nil
end

local Options = Library.Options

local Window = Library:CreateWindow({
    Title = "Grow a Garden",
    SubTitle = "twvz",
    TabWidth = 100,
    Size = UDim2.fromOffset(700, 500),
    Resize = true,
    MinSize = Vector2.new(470, 380),
    Acrylic = false, 
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.RightShift
})

local Tabs = {
    Main = Window:CreateTab{
        Title = "Main",
        Icon = "phosphor-brain-bold" 
    },
    Shop = Window:CreateTab{
        Title = "Shop",
        Icon = "bean"
    },
    Event = Window:CreateTab{
        Title = "Event",
        Icon = "moon"
    },
    Settings = Window:CreateTab{
        Title = "Settings",
        Icon = "settings"
    }
}

-- === Main Tab ===

Tabs.Main:CreateSection("Collect")

local CollectNearbyToggle = Tabs.Main:CreateToggle("CollectNearby", {
    Title = "Collect Nearby", 
    Default = false 
})

CollectNearbyToggle:OnChanged(function()
    if Options.CollectNearby.Value then
        spawn(function()
            while Options.CollectNearby.Value do
                local playerFarmPlot = getCorrectFarmPlotFolder()
                if playerFarmPlot then
                    local importantFolder = playerFarmPlot:FindFirstChild("Important")
                    if importantFolder then
                        local plantsPhysical = importantFolder:FindFirstChild("Plants_Physical")
                        if plantsPhysical then
                            for _, plant in pairs(plantsPhysical:GetChildren()) do
                                local fruitsFolder = plant:FindFirstChild("Fruits")
                                if fruitsFolder then
                                    for _, fruitType in pairs(fruitsFolder:GetChildren()) do
                                        for _, fruitInstance in pairs(fruitType:GetChildren()) do
                                            local prompt = fruitInstance:FindFirstChild("ProximityPrompt")
                                            if prompt then
                                                fireproximityprompt(prompt)
                                                task.wait() 
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                task.wait() 
            end
        end)
    end
end)

local CollectAllGardenToggle = Tabs.Main:CreateToggle("CollectAllGarden", {
    Title = "Collect All Garden", 
    Default = false
})

Tabs.Main:CreateDropdown("CollectMode", {
    Title = "Collect All Mode",
    Default = "Normal",
    Values = {"Normal", "Underground"}
})

Tabs.Main:CreateSlider("UndergroundDepth", {
    Title = "Underground Depth",
    Default = 10,
    Min = 5,
    Max = 30,
    Rounding = 0,
})

CollectAllGardenToggle:OnChanged(function()
    if Options.CollectAllGarden.Value then
        spawn(function()
            local originalCFrameBeforeOperation = nil
            local playerWasAnchoredByThis = false
            local rootPartForAnchorCheck = getPlayerRoot()

            if Options.CollectMode.Value == "Underground" then
                if rootPartForAnchorCheck then
                    originalCFrameBeforeOperation = rootPartForAnchorCheck.CFrame
                    rootPartForAnchorCheck.Anchored = true
                    playerWasAnchoredByThis = true
                else
                end
            end

            while Options.CollectAllGarden.Value do
                if not Options.CollectAllGarden.Value then break end
                local playerRoot = getPlayerRoot()
                if not (playerRoot and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0) then
                    task.wait(1)
                else
                    local playerFarmPlot = getCorrectFarmPlotFolder()
                    if not playerFarmPlot then
                        task.wait(2)
                    else
                        local importantFolder = playerFarmPlot:FindFirstChild("Important")
                        local plantsPhysical = importantFolder and importantFolder:FindFirstChild("Plants_Physical")

                        if not plantsPhysical then
                            task.wait(2)
                        else
                            local fruitModelsToVisit = {}
                            for _, fruitModelCandidate in pairs(plantsPhysical:GetChildren()) do
                                if fruitModelCandidate:IsA("Model") then
                                    table.insert(fruitModelsToVisit, fruitModelCandidate)
                                end
                            end

                            if #fruitModelsToVisit == 0 then
                                continue
                            end

                            for i, fruitModelToVisit in ipairs(fruitModelsToVisit) do
                                if not Options.CollectAllGarden.Value then break end
                                playerRoot = getPlayerRoot()
                                if not (playerRoot and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0) then
                                    break 
                                end

                                local targetPos = nil
                                if fruitModelToVisit.PrimaryPart and fruitModelToVisit.PrimaryPart:IsA("BasePart") then
                                    targetPos = fruitModelToVisit.PrimaryPart.Position
                                else
                                    local pivotSuccess, pivotCF = pcall(function() return fruitModelToVisit:GetPivot() end)
                                    if pivotSuccess and pivotCF then
                                        targetPos = pivotCF.Position
                                    else
                                        local foundChildBasePartPos = false
                                        for _, childPart in pairs(fruitModelToVisit:GetChildren()) do
                                            if childPart:IsA("BasePart") then
                                                targetPos = childPart.Position
                                                foundChildBasePartPos = true
                                                break 
                                            end
                                        end
                                        if not foundChildBasePartPos then
                                            targetPos = nil
                                        end
                                    end
                                end
                                
                                if targetPos then   
                                    if not Options.CollectAllGarden.Value then break end
                                    local currentOperationCFrame
                                    if Options.CollectMode.Value == "Underground" and playerWasAnchoredByThis then -- Só vai underground se conseguiu ancorar
                                        local depth = Options.UndergroundDepth.Value
                                        currentOperationCFrame = CFrame.new(targetPos - Vector3.new(0, depth, 0))
                                    else
                                        currentOperationCFrame = CFrame.new(targetPos) + Vector3.new(0, 2.5, 0)
                                    end
                                    playerRoot.CFrame = currentOperationCFrame
                                    task.wait()

                                    local promptFound = fruitModelToVisit:FindFirstChildWhichIsA("ProximityPrompt", true) 
                                    if promptFound then
                                        fireproximityprompt(promptFound)
                                        task.wait()
                                    end
                                else
                                end
                            end
                        end
                    end
                end
                if not Options.CollectAllGarden.Value then break end
                task.wait(1) 
            end 

            if playerWasAnchoredByThis then
                local currentRoot = getPlayerRoot()
                if currentRoot then
                    if currentRoot.Anchored then 
                         currentRoot.Anchored = false
                    end
                    if originalCFrameBeforeOperation then
                        currentRoot.CFrame = originalCFrameBeforeOperation
                        task.wait(0.1)
                    end
                end
            end
        end)
    end
end)

Tabs.Main:CreateSection("Sell")

Tabs.Main:CreateSlider("SellDelay", {
    Title = "Sell Delay",
    Default = 1,
    Min = 0.1,
    Max = 5,
    Rounding = 1, 
})

local AutoSellToggle = Tabs.Main:CreateToggle("AutoSell", {
    Title = "Auto Sell All", 
    Default = false
})

AutoSellToggle:OnChanged(function()
    if Options.AutoSell.Value then
        spawn(function()
            while Options.AutoSell.Value do
                if not Options.AutoSell.Value then break end

                local playerChar = player.Character
                local playerRoot = playerChar and playerChar:FindFirstChild("HumanoidRootPart")
                local humanoid = playerChar and playerChar:FindFirstChild("Humanoid")

                if playerRoot and humanoid and humanoid.Health > 0 then
                    getgenv().isSelling = true
                    local wasAnchored = playerRoot.Anchored -- Guarda o estado de ancoragem
                    if wasAnchored then
                        playerRoot.Anchored = false
                        task.wait() -- Pequena espera para a mudança de física propagar
                    end

                    if Options.MoonlitBeforeSell.Value then
                        game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("NightQuestRemoteEvent"):FireServer("SubmitAllPlants")
                        task.wait(0.4)       
                    end

                    local oldPos = playerRoot.CFrame
                    local targetSellCFrame = CFrame.new(sellPos) + Vector3.new(0, 0, 0) 
                    
                    playerRoot.CFrame = targetSellCFrame

                    local forceStayStartTime = tick()
                    while tick() - forceStayStartTime < 0.5 do
                        if playerRoot and playerRoot.Parent then
                            playerRoot.CFrame = targetSellCFrame
                        else
                            break
                        end
                        task.wait()
                    end

                    game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("Sell_Inventory"):FireServer()

                    local currentCharacter = player.Character
                    local currentRoot = currentCharacter and currentCharacter:FindFirstChild("HumanoidRootPart")
                    if currentRoot then
                         currentRoot.CFrame = oldPos
                         task.wait(0.2)
                         if wasAnchored then -- Restaura o estado de ancoragem
                             currentRoot.Anchored = true
                             task.wait()
                         end
                    end
                    
                    task.wait(1.0)
                    getgenv().isSelling = false
                else
                    if not Options.AutoSell.Value then break end 
                    task.wait(1) 
                end
                local delay = Options.SellDelay.Value or 2
                task.wait(delay)
            end
        end)
    end
end)

Tabs.Main:CreateButton{
    Title = "Sell All",
    Callback = function()
        if Options.MoonlitBeforeSell.Value then
            game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("NightQuestRemoteEvent"):FireServer("SubmitAllPlants")
            task.wait(0.1)
        end

        local playerRoot = getPlayerRoot()
        if not playerRoot then return end

        local wasAnchored = playerRoot.Anchored -- Guarda o estado de ancoragem
        if wasAnchored then
            playerRoot.Anchored = false
            task.wait() -- Pequena espera para a mudança de física propagar
        end

        local oldPos = playerRoot.CFrame
        local targetSellCFrame = CFrame.new(sellPos) + Vector3.new(0, 0, 0) 
                    
        playerRoot.CFrame = targetSellCFrame

        local forceStayStartTime = tick()
        while tick() - forceStayStartTime < 0.5 do
            if playerRoot and playerRoot.Parent then
                playerRoot.CFrame = targetSellCFrame
            else
                break
            end
            task.wait()
        end
        game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("Sell_Inventory"):FireServer()
        local currentRootForReturn = getPlayerRoot()
        if currentRootForReturn then
            currentRootForReturn.CFrame = oldPos
            task.wait(0.2)
            if wasAnchored then -- Restaura o estado de ancoragem
                currentRootForReturn.Anchored = true
                task.wait()
            end
        end

        task.wait(0.5)
    end
}

Tabs.Shop:CreateSection("Seeds")

local SeedsDropdown = Tabs.Shop:CreateDropdown("Seeds", {
    Title = "Seeds",
    Values = seeds,
    Multi = true,
    Default = {"Carrot"},
})

local seedsToBuy = {}

SeedsDropdown:OnChanged(function(Value)
    local Values = {}
    for Value, State in next, Value do
        Values[#Values + 1] = Value
    end
    seedsToBuy = Values
end)

local AutoBuySeed = Tabs.Shop:CreateToggle("AutoBuySeed", {
    Title = "Auto Buy Seed",
    Default = false
})

AutoBuySeed:OnChanged(function()
    if Options.AutoBuySeed.Value then
        spawn(function()
            while Options.AutoBuySeed.Value do
                for _, seedName in pairs(seedsToBuy) do
                    game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("BuySeedStock"):FireServer(seedName)
                    task.wait()
                end
                task.wait()
            end
        end)
    end
end)

Tabs.Shop:CreateSection("Gears")

local GearsDropdown = Tabs.Shop:CreateDropdown("Gears", {
    Title = "Gears",
    Values = gears,
    Multi = true,
    Default = {"Watering Can"},
})

local gearsToBuy = {}

GearsDropdown:OnChanged(function(Value)
    local Values = {}
    for Value, State in next, Value do
        Values[#Values + 1] = Value
    end
    gearsToBuy = Values
end)

local AutoBuyGear = Tabs.Shop:CreateToggle("AutoBuyGear", {
    Title = "Auto Buy Gear",
    Default = false
})

AutoBuyGear:OnChanged(function()
    if Options.AutoBuyGear.Value then
        spawn(function()
            while Options.AutoBuyGear.Value do
                for _, gearName in pairs(gearsToBuy) do
                    game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("BuyGearStock"):FireServer(gearName)
                    task.wait()
                end
                task.wait()
            end
        end)
    end
end)

Tabs.Event:CreateSection("Event")

Tabs.Event:CreateToggle("MoonlitBeforeSell", {
    Title = "Submit All Moonlit Plants Before Sell",
    Default = false
})

Tabs.Event:CreateButton({
    Title = "Submit All Moonlit Plants",
    Callback = function()
        game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("NightQuestRemoteEvent"):FireServer("SubmitAllPlants")
    end
})
-- === Settings Tab ===

SaveManager:SetLibrary(Library)
InterfaceManager:SetLibrary(Library)

SaveManager:IgnoreThemeSettings()

InterfaceManager:SetFolder("gagtwvz") 
SaveManager:SetFolder("gagtwvz/Config")    

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

Window:SelectTab(1)

SaveManager:LoadAutoloadConfig()
