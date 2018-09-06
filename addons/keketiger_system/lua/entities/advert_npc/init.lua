AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:SpawnFunction(ply, tr, classname)
	if !tr.Hit then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	local ent = ents.Create(classname)
	ent:SetPos(SpawnPos)
	ent:Spawn()
	ent:Activate()
	return ent
end

util.AddNetworkString("AdTiger")

function ENT:AcceptInput(event, act, ply, data)
    if event == "Use" and IsValid(ply) and ply:IsPlayer() then
            net.Start("AdTiger")
            net.Send(ply)
    end
end

hook.Add("PlayerDisconnected", "badumtsss", function(ply)
    if timer.Exists(ply:SteamID64().."timer1") then timer.Remove(ply:SteamID64().."timer1") end
    if timer.Exists(ply:SteamID64().."timer2") then timer.Remove(ply:SteamID64().."timer2") end
end)

util.AddNetworkString("buyadvert")
net.Receive( "buyadvert" , function ( len , ply )
    local number = net.ReadUInt(3)
    local text = net.ReadString()
    local col = team.GetColor(ply:Team())

    if text == "" then

        DarkRP.notify(ply,1,6, Tiger.FailNotifyPurchase.." !")

        return
    end

    if number == 1 then
        ply:addMoney(- Tiger.AdvertPrice[number])
        DarkRP.notify(ply,0,6, Tiger.SuccesNotifyPurchase.." "..GAMEMODE.Config.currency..Tiger.AdvertPrice[number].." !")
        for k,v in pairs(player.GetAll()) do
            DarkRP.talkToPerson(v, col, Tiger.AdvertText .. " " .. ply:Nick(), Color(255, 255, 0, 255), text, ply)
        end
    elseif number == 2 then
        ply:addMoney(- Tiger.AdvertPrice[number])
        DarkRP.notify(ply,0,6, Tiger.SuccesNotifyPurchase.." "..GAMEMODE.Config.currency..Tiger.AdvertPrice[number].." !")
		for k,v in pairs(player.GetAll()) do
			DarkRP.talkToPerson(v, col, Tiger.AdvertText .. " " .. ply:Nick(), Color(255, 255, 0, 255), text, ply)
		end
		timer.Create(ply:SteamID64().."timer1", Tiger.TimerDelay[1], Tiger.TimerRepetition[1], function()
			for k,v in pairs(player.GetAll()) do
				DarkRP.talkToPerson(v, col, Tiger.AdvertText .. " " .. ply:Nick(), Color(255, 255, 0, 255), text, ply)
	    	end
		end)
    elseif number == 3 then
        ply:addMoney( -Tiger.AdvertPrice[number])
        DarkRP.notify(ply,0,6, Tiger.SuccesNotifyPurchase.." "..GAMEMODE.Config.currency..Tiger.AdvertPrice[number].." !")
        DarkRP.log(ply:Name().." ".."says anonymously".." : "..text,Color(255,255,255,255))
        for k,v in pairs(player.GetAll()) do
            DarkRP.talkToPerson(v, Color(204,18,21,255), Tiger.Anonymous, Color(255, 255, 0, 255), text, ply)
        end
    end
end)
