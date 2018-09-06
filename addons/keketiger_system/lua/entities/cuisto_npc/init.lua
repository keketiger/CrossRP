AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

util.AddNetworkString("Shop::OpenMenu")

function ENT:Initialize()
	self:SetModel("models/Humans/Group02/male_06.mdl")
	self:SetHullType(HULL_HUMAN)
	self:SetHullSizeNormal()
	self:SetNPCState(NPC_STATE_SCRIPT)
	self:SetSolid(SOLID_BBOX)
	self:SetUseType(SIMPLE_USE)
	self:CapabilitiesAdd(CAP_ANIMATEDFACE, CAP_TURN_HEAD)
	self:SetMaxYawSpeed(90)
	self:DropToFloor()
end

function ENT:AcceptInput(name, activator, called)
	if name == "Use" and called:IsPlayer() and called:Team() == TEAM_COOK then
		net.Start("Shop::OpenMenu")
		net.WriteEntity(self)
		net.Send(called)
	end
end