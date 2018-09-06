ENT.Type = "ai"
ENT.Base = "base_ai"
ENT.PrintName    = "Shop Cuisto"
ENT.Author       = "keketiger"
ENT.Contact      = "pro@keketiger.fr"
ENT.Category     = "CrossRP"
ENT.Purpose      = "n/a"
ENT.Instructions = "press E to open"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.AutomaticFrameAdvance = true

function ENT:SetAutomaticFrameAdvance(bUsingAnim)
	self.AutomaticFrameAdvance = bUsingAnim
end

function ENT:OnTakeDamage()
	return false
end