-- RemoteEvents, BindableEvents, BindableFunctions, etc. (yes, functions too)

-- Phase out the BindableEvents/BindableFunctions on the server
-- RemoteEvents/RemoteFunctions are allowed
export type Events = {
	FireRemoteDialogueEvent: (string) -> (),
}

local events = {} :: Events

local remoteEvents = game:GetService("ReplicatedStorage").RemoteEvents

-- Utility to generate fire/connect functions
local function bindEvent(name: string, eventObj)
	local safeName = name:gsub("%W", "") -- Strip special chars just in case

	-- Fire function (reqs player as 1st param if remote)
	events["Fire" .. safeName] = function(...)
		if eventObj:IsA("BindableEvent") then
			eventObj:Fire(...)
		elseif eventObj:IsA("RemoteEvent") then
			eventObj:FireClient(...)
		elseif eventObj:IsA("RemoteFunction") then
			return eventObj:InvokeClient(...)
		elseif eventObj:IsA("BindableFunction") then
			return eventObj:Invoke(...)
		end
	end

	-- Connect function
	events["Connect" .. safeName] = function(callback)
		if eventObj:IsA("RemoteEvent") then
			return eventObj.OnServerEvent:Connect(callback)
		elseif eventObj:IsA("BindableEvent") then
			return eventObj.Event:Connect(callback)
		elseif eventObj:IsA("RemoteFunction") then
			eventObj.OnServerInvoke = callback
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
