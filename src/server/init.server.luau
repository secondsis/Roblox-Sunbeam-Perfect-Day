print("Hello world, from server!")

local ServerModules = script:GetChildren()

for _, ServerModule in ServerModules do
	if ServerModule:IsA("ModuleScript") then
		task.spawn(function()
			require(ServerModule)
		end)
	end
end
