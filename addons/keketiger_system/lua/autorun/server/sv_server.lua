--[[
if (SERVER) then
    timer.Create('ClearDecalsConsole', 180, 0, function() -- 180 seconds
        MsgC(Color(90, 230, 0), '[Serveur] Nettoyage des decals sur la carte réussi.\n')
    end)
end
]]

local function InitPostEntity()
    for k,v in pairs(Tiger.JNPC.CreateNPC) do
        local job_npc = ents.Create('job_npc')

        job_npc:SetPos(v.pos)
        job_npc:SetAngles(v.angle)
        job_npc:SetModel(v.model)
        job_npc:Spawn()
        job_npc:Activate()
        job_npc.ID = k
    end
end

hook.Add('InitPostEntity', 'SpawningJobsNPC', InitPostEntity)
hook.Add('PostCleanupMap', 'SpawningJobsNPC', InitPostEntity)
