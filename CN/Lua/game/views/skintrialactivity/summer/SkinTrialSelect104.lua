slot0 = class("SkinTrialSelect104", SkinTrialActivitySelectView)

function slot0.UIName(slot0)
	return "UI/SummerUI/SummerSkinTrialUI_" .. slot0.params_.skinTrialID
end

function slot0.OnEnter(slot0)
	if slot0.params_.canPlayTimeLine == true and slot0.director_ ~= nil then
		slot0.params_.canPlayTimeLine = false
		slot0.director_.time = 0

		slot0.director_:Play()
	end

	uv0.super.OnEnter(slot0)
end

function slot0.OnExit(slot0)
	slot0.director_:Stop()
	uv0.super.OnExit(slot0)
end

return slot0
