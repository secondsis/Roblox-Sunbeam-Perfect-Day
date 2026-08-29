-- RemoteEvents, BindableEvents, BindableFunctions, etc. (yes, functions too)

export type Events = {
	FireDialogueFunction: (string) -> (),
}

local events = {} :: Events

local replicatedStorage = game:GetService("ReplicatedStorage")
local remoteEvents = replicatedStorage:WaitForChild("RemoteEvents")

-- Utility to generate fire/connect functions
local function bindEvent(name: string, eventObj)
	local safeName = name:gsub("%W", "") -- Strip special chars just in case

	-- Fire function
	events["Fire" .. safeName] = function(...)
		if eventObj:IsA("BindableEvent") then
			eventObj:Fire(...)
		elseif eventObj:IsA("RemoteEvent") then
			eventObj:FireServer(...)
		elseif eventObj:IsA("RemoteFunction") then
			return eventObj:InvokeServer(...)
		elseif eventObj:IsA("BindableFunction") then
			return eventObj:Invoke(...)
		end
	end

	-- Connect function
	events["Connect" .. safeName] = function(callback)
		if eventObj:IsA("RemoteEvent") then
			return eventObj.OnClientEvent:Connect(callback)
		elseif eventObj:IsA("BindableEvent") then
			return eventObj.Event:Connect(callback)
		elseif eventObj:IsA("RemoteFunction") then
			eventObj.OnClientInvoke = callback
		elseif eventObj:IsA("BindableFunction") then
			eventObj.OnInvoke = callback
		end
	end
end

-- Recursively find events
local function bindEventsIn(folder)
	for _, child in folder:GetChildren() do
		if child:IsA("Folder") then
			bindEventsIn(child)
		elseif
			child:IsA("RemoteEvent")
			or child:IsA("BindableEvent")
			or child:IsA("RemoteFunction")
			or child:IsA("BindableFunction")
		then
			bindEvent(child.Name, child)
		end
	end
end

bindEventsIn(remoteEvents)

return events
