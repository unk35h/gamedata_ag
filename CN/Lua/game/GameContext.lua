slot1 = class("GameContext", import("library.router.VueRouter"))

function slot1.Ctor(slot0, slot1)
	uv0.super.Ctor(slot0, slot1)
end

function slot1.EnterRouteOver(slot0)
	uv0.super.EnterRouteOver(slot0)

	if whereami ~= "login" then
		-- Nothing
	end
end

return slot1
