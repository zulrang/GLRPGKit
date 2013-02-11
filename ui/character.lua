
require 'middleclass'

Character = class('Character')

function Character:initialize(name)
	self.name = name
	self.strength = 4
	self.agility = 5

	self.hp = 15
	self.maxHp = 15
	
	self.attackPower = 4
	self.defensePower = 2
end