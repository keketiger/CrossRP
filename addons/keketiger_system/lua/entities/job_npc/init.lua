AddCSLuaFile("cl_init.lua") 
AddCSLuaFile("shared.lua")
include("shared.lua") 

function ENT:Initialize()
 	self:SetHullType(HULL_HUMAN)
	self:SetUseType(SIMPLE_USE)
	self:SetHullSizeNormal()
	self:SetSolid(SOLID_BBOX)
	self:SetNPCState(NPC_STATE_SCRIPT)
	self:DropToFloor()
	self:SetMaxYawSpeed(5000)
	local PhysAwake = self.Entity:GetPhysicsObject()
	if PhysAwake:IsValid() then
		PhysAwake:Wake()
	end 
end

function ENT:OnTakeDamage()
	return false
end

util.AddNetworkString("TigerJobNPCGUI")
function ENT:AcceptInput(event, act, ply, data)
    if event == "Use" and IsValid(ply) and ply:IsPlayer() then
        net.Start("TigerJobNPCGUI")
        net.WriteInt(self.ID, 8)
		net.Send(ply)
    end
end

util.AddNetworkString("tiger_jnpc_jobswitch")	
net.Receive("tiger_jnpc_jobswitch", function(len, ply)
	local string = net.ReadString()
	local team = _G[string]
	ply:changeTeam(team)
end)