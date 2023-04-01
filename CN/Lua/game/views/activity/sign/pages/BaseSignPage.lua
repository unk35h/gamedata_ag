slot0 = class("BaseSignPage", ReduxView)

function slot0.AutoGetReward(slot0)
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)

	if slot1 then
		slot0:OnShow()
	else
		slot0:OnHide()
	end
end

function slot0.OnShow(slot0)
end

function slot0.OnHide(slot0)
end

return slot0
