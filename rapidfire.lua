local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local mouse = player:GetMouse()

-- Tasten für Funktionen
local toggleTriggerbotKey = Enum.KeyCode.V
local toggleRapidFireKey = Enum.KeyCode.B

-- Status der Funktionen
local triggerbotActive = false
local rapidFireActive = false

-- Schussraten
local fireRateTriggerbot = 0.01 -- Triggerbot schießt alle 100ms
local fireRateRapidFire = 0.05  -- Rapid Fire schießt alle 50ms

-- Prüft, ob das Ziel ein Gegner ist
local function isEnemy(target)
    local targetPlayer = Players:GetPlayerFromCharacter(target.Parent)
    return targetPlayer and targetPlayer.Team ~= player.Team
end

-- Rapid Fire Funktion
local function startRapidFire()
    while rapidFireActive do
        local tool = character:FindFirstChildOfClass("Tool") or player.Backpack:FindFirstChildOfClass("Tool")
        if tool and tool:FindFirstChild("Activate") then
            tool:Activate()
        end
        task.wait(fireRateRapidFire)
    end
end

-- Triggerbot Funktion
local function triggerbot()
    while triggerbotActive do
        local target = mouse.Target
        if target and isEnemy(target) then
            local tool = character:FindFirstChildOfClass("Tool") or player.Backpack:FindFirstChildOfClass("Tool")
            if tool and tool:FindFirstChild("Activate") then
                tool:Activate()
            end
        end
        task.wait(fireRateTriggerbot)
    end
end

-- Tasteneingaben überwachen
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end

    -- Triggerbot AN/AUS
    if input.KeyCode == toggleTriggerbotKey then
        triggerbotActive = not triggerbotActive
        local state = triggerbotActive and "ENABLED" or "DISABLED"
        
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Triggerbot",
            Text = "Triggerbot " .. state,
            Duration = 2
        })

        if triggerbotActive then
            task.spawn(triggerbot)
        end
    end

    -- Rapid Fire AN/AUS
    if input.KeyCode == toggleRapidFireKey then
        rapidFireActive = not rapidFireActive
        local state = rapidFireActive and "ENABLED" or "DISABLED"
        
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Rapid Fire",
            Text = "Rapid Fire " .. state,
            Duration = 2
        })

        if rapidFireActive then
            task.spawn(startRapidFire)
        end
    end
end)

-- Lade-Benachrichtigung
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Triggerbot & Rapid Fire",
    Text = "V = Triggerbot, B = Rapid Fire",
    Duration = 3
})
