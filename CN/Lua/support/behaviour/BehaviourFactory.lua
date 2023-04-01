slot0 = {
	Chain = import(".basic.Chain"),
	DoubleBuffer = import(".basic.DoubleBuffer"),
	EventProtocol = import(".basic.EventProtocol"),
	StateMachine = import(".basic.StateMachine")
}
slot2 = {
	Chain = true,
	StateMachine = true,
	EventProtocol = true,
	DoubleBuffer = true
}

return {
	CreateBehaviour = function (slot0)
		return uv0[slot0].New()
	end,
	ExtendNewBehaviour = function (slot0, slot1)
		if uv0[slot0] then
			printInfo("exist behaviour %s has been overwritten!", slot0)
		end

		uv0[slot0] = slot1
	end,
	IsBehaviourAvailable = function (slot0)
		return uv0[slot0] ~= nil
	end,
	GetAllBasicBehavioursName = function ()
		return table.keys(uv0)
	end
}
