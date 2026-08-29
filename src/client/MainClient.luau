local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ClientEventsModule = require(script.Parent.ClientEventsModule)
local module = {}
local player = Players.LocalPlayer

-- Start on Black screen
local BlackGui = player.PlayerGui:WaitForChild("BlackGui")
local BlackFrame = BlackGui:WaitForChild("Frame")
BlackGui.Enabled = true
BlackFrame.BackgroundTransparency = 0
BlackFrame.Visible = true
local ScreenFadeIn = TweenService:Create(BlackFrame, TweenInfo.new(3), {
	BackgroundTransparency = 1,
})
local ScreenFadeOut = TweenService:Create(BlackFrame, TweenInfo.new(3), {
	BackgroundTransparency = 0,
})

local SpawnCFrame = CFrame.new(-98.494, 9.166, 79.351)

repeat
	task.wait()
until player.Character
task.wait(1)

local function TeleportPlayer(player: Player, newCFrame: CFrame)
	if not player or not player.Character or not player.Character.PrimaryPart then
		return
	end
	player.Character.PrimaryPart:PivotTo(newCFrame)
end

TeleportPlayer(player, SpawnCFrame)

task.wait(3)
ScreenFadeIn:Play()

print("dialogue")
ClientEventsModule.FireDialogueFunction("NewDay")

return module
