--if (SERVER) then
	-- Information about the fact that this mod is activated.
	--acdsuccess = "[ACD] Successfully initialize."
	--MsgC(Color(90, 230, 0), acdsuccess.."\n")

	--timer.Create("ClearDecalsConsole", 180, 0, function() -- 180 seconds
	--	acdclearmessages = "[ACD] Successful cleaning decals on the map."
	--	MsgC(Color(90, 230, 0), acdclearmessages.."\n")
	--end)
--end

local function InitPostEntity()
	for k, v in pairs(Tiger.JNPC.CreateNPC) do
		local job_npc = ents.Create("job_npc")
		job_npc:SetPos(v.pos)
		job_npc:SetAngles(v.angle)
		job_npc:SetModel(v.model)
		job_npc:Spawn()
		job_npc:Activate()
		job_npc.ID = k
	end
end
hook.Add("InitPostEntity", "SpawningJobsNPC", InitPostEntity)
hook.Add("PostCleanupMap", "SpawningJobsNPC", InitPostEntity)
