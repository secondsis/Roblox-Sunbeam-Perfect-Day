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

local function DisableControls()
	player.Character:FindFirstChild("Humanoid").WalkSpeed = 0
	player.Character:FindFirstChild("Humanoid").JumpPower = 0
end

local function EnableControls()
	player.Character:FindFirstChild("Humanoid").WalkSpeed = 16
	player.Character:FindFirstChild("Humanoid").JumpPower = 50
end

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
player.Character:FindFirstChild("Humanoid").WalkSpeed = 0

task.wait(5)

game:GetService("SoundService").SFX.glassBreak:Play()

ClientEventsModule.FireDialogueFunction("SomethingRuinedIt")

game:GetService("SoundService"):WaitForChild("HomeTown"):Play()

local ObjectiveHandler = require(
	player.PlayerGui:WaitForChild("ObjectiveGui"):WaitForChild("ObjectiveFrame"):WaitForChild("ObjectiveHandler")
)

task.spawn(function()
	ObjectiveHandler.ViewObjective("Find all the animals.")
end)

local foundAnimals = {}

local maxwellPrompt: ProximityPrompt = game:GetService("Workspace").Maxwell.maxwell.ProximityPrompt
local frogPrompt: ProximityPrompt = game:GetService("Workspace").Froggy.Head.ProximityPrompt
local squirrelPrompt: ProximityPrompt = game:GetService("Workspace").Squirrel["Object_0"].ProximityPrompt
local meowSfx = game:GetService("SoundService").SFX.meow
local croakSfx = game:GetService("SoundService").SFX.croak
local squirrelSfx = game:GetService("SoundService").SFX.squirrel

maxwellPrompt.Triggered:Connect(function(a0: Player)
	if table.find(foundAnimals, "maxwell") then
		-- ClientEventsModule.FireDialogueFunction("FoundAlready")
		return
	end
	maxwellPrompt.Enabled = false
	table.insert(foundAnimals, "maxwell")
	meowSfx:Play()
	ClientEventsModule.FireDialogueFunction("FoundMaxwell")
end)

frogPrompt.Triggered:Connect(function(a0: Player)
	if table.find(foundAnimals, "frog") then
		-- ClientEventsModule.FireDialogueFunction("FoundAlready")
		return
	end
	frogPrompt.Enabled = false
	table.insert(foundAnimals, "frog")
	croakSfx:Play()
	ClientEventsModule.FireDialogueFunction("FoundFrog")
end)

squirrelPrompt.Triggered:Connect(function(a0: Player)
	if table.find(foundAnimals, "squirrel") then
		-- ClientEventsModule.FireDialogueFunction("FoundAlready")
		return
	end
	squirrelPrompt.Enabled = false
	table.insert(foundAnimals, "squirrel")
	squirrelSfx:Play()
	ClientEventsModule.FireDialogueFunction("FoundSquirrel")
end)

-- wait until all animals are found
while #foundAnimals < 3 do
	task.wait()
end

-- all animals found
DisableControls()

ScreenFadeOut:Play()
task.wait(3)
ClientEventsModule.FireDialogueFunction("FoundAll")

local newCamCFrame = CFrame.new(-93.31, 12.263, 72.57)
	* CFrame.fromOrientation(math.rad(-17.696), math.rad(123.059), -0)

local cam = workspace.CurrentCamera
cam.CameraType = Enum.CameraType.Scriptable
cam.CFrame = newCamCFrame

-- Dupe animals
local AnimalFolder = game:GetService("ReplicatedStorage").EndAnimals:Clone()
AnimalFolder.Parent = workspace

local BirdsSound = game:GetService("SoundService").BirdsAmbience
game:GetService("SoundService"):WaitForChild("HomeTown"):Stop()
BirdsSound:Play()

ScreenFadeIn:Play()

ClientEventsModule.FirePauseCameraEffects()

return module
