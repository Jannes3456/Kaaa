local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local mouse = player:GetMouse()
local triggerbotActive = false
local toggleKey = Enum.KeyCode.V
local fireRate = 0.1 -- Wartezeit zwischen Schüssen (100ms)

-- Funktion zum Überprüfen, ob das Ziel ein Gegner ist
local function isEnemy(target)
    local targetPlayer = Players:GetPlayerFromCharacter(target.Parent)
    return targetPlayer and targetPlayer.Team ~= player.Team
end

-- Triggerbot aktivieren
local function triggerbot()
    while triggerbotActive do
        local target = mouse.Target
        if target and isEnemy(target) then
            local tool = character:FindFirstChildOfClass("Tool") or player.Backpack:FindFirstChildOfClass("Tool")
            if tool and tool:FindFirstChild("Activate") then
                tool:Activate()
            end
        end
        task.wait(fireRate)
    end
end

-- `V` drücken → Triggerbot an/aus
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == toggleKey then
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
end)

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Triggerbot",
    Text = "Triggerbot Loaded // V to toggle",
    Duration = 2
})
