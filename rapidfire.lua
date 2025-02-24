local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local toggleKey = Enum.KeyCode.N
local wallsVisible = true

-- Funktion zum Ändern der Transparenz von Wänden
local function setWallTransparency(transparency)
    for _, part in ipairs(Workspace:GetDescendants()) do
        if part:IsA("BasePart") and not part:IsDescendantOf(game.Players.LocalPlayer.Character) then
            if part.Size.Y > 10 or part.Size.X > 10 then -- Große Objekte als Wände erkennen
                part.Transparency = transparency
            end
        end
    end
end

-- Tastensteuerung für AN/AUS
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == toggleKey then
        wallsVisible = not wallsVisible
        setWallTransparency(wallsVisible and 0 or 1) -- 0 = Sichtbar, 0.8 = Fast unsichtbar

        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Wallhack",
            Text = "Wände " .. (wallsVisible and "sichtbar" or "durchsichtig"),
            Duration = 2
        })
    end
end)

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Wallhack",
    Text = "Drücke N, um Wände durchsichtig zu machen!",
    Duration = 3
})
