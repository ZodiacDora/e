local Players = game:GetService("Players")

-- Function to highlight a player
local function highlightPlayer(player)
    if player.Character then
        -- Ensure the character has loaded
        local highlight = Instance.new("Highlight")
        highlight.FillColor = Color3.fromRGB(252, 28, 28)
        highlight.FillTransparency = 0.5
        highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
        highlight.OutlineTransparency = 0
        highlight.Adornee = player.Character
        highlight.Parent = player.Character

        -- Create a BillboardGui for the player's name tag
        local nameTag = Instance.new("BillboardGui")
        nameTag.Size = UDim2.new(0, 100, 0, 50)
        nameTag.AlwaysOnTop = true
        nameTag.StudsOffset = Vector3.new(0, 2, 0) -- Position above character's head
        nameTag.Parent = player.Character:WaitForChild("Head")

        -- Create main TextLabel for the player's name
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Size = UDim2.new(1, 0, 1, 0)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = player.Name
        nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        nameLabel.TextScaled = true
        nameLabel.Parent = nameTag
    end
end

-- Function to highlight the player when their character is added
local function onCharacterAdded(character)
    local player = Players:GetPlayerFromCharacter(character)
    if player then
        highlightPlayer(player)
    end
end

-- Connect to PlayerAdded event
Players.PlayerAdded:Connect(function(player)
    -- Connect to CharacterAdded event
    player.CharacterAdded:Connect(onCharacterAdded)

    -- Highlight player immediately if they already have a character
    if player.Character then
        highlightPlayer(player)
    end
end)

-- Highlight already connected players
for _, player in ipairs(Players:GetPlayers()) do
    player.CharacterAdded:Connect(onCharacterAdded)
    if player.Character then
        highlightPlayer(player)
    end
end

-- Clean up when players leave
Players.PlayerRemoving:Connect(function(player)
    if player.Character then
        local highlight = player.Character:FindFirstChildOfClass("Highlight")
        if highlight then
            highlight:Destroy()
        end
    end
end)
