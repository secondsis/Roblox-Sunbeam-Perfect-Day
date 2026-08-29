local replicatedStorage = game:GetService("ReplicatedStorage")

local disableMovementEvent = replicatedStorage.RemoteEvents.DisableMovementEvent
local remoteDisableMovementEvent = replicatedStorage.RemoteEvents.RemoteDisableMovementEvent

local player = game:GetService("Players").LocalPlayer

local function movementChanger(canMove: boolean)
	-- local controlModule = require(game.StarterPlayer:WaitForChild("PlayerModule"):WaitForChild("ControlModule"))
	if canMove then
		-- print("enable controls")
		-- controlModule:Enable()
		player.Character:FindFirstChild("Humanoid").WalkSpeed = 16
	else
		-- print("disable controls")
		-- controlModule:Disable()
		player.Character:FindFirstChild("Humanoid").WalkSpeed = 0
	end
end

disableMovementEvent.Event:Connect(movementChanger)
remoteDisableMovementEvent.OnClientEvent:Connect(movementChanger)

return {}
