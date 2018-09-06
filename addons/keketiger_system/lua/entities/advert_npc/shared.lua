ENT.Base = "base_ai"
ENT.Type = "ai"
ENT.PrintName		= "Cabine téléphonique"
ENT.Category		= "CrossRP"
ENT.Instructions	= ""
ENT.Spawnable		= true
ENT.AdminSpawnable  = true
ENT.AutomaticFrameAdvance = true

ENT.WorldModel = "models/props_equipment/phone_booth.mdl"

function ENT:Initialize()

	self:SetModel( self.WorldModel )
	self:SetMoveType( MOVETYPE_VPHYSICS )   
	self:SetSolid( SOLID_VPHYSICS )         
 	
	if ( SERVER ) then self:PhysicsInit( SOLID_VPHYSICS ) end

    local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
		phys:SetMass( 50 )
	end

	if SERVER then
		self:SetUseType( SIMPLE_USE )
	end

end

function ENT:OnTakeDamage()
	return false
end

DarkRP.removeChatCommand("advert")
