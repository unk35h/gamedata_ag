slot0 = class("HeroDisplayPoseView", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()

	slot0.heroPoseItemList_ = {}
end

function slot0.OnEnter(slot0, slot1)
	slot0.heroID_ = slot1

	for slot6 = 1, #HeroDisplayData:GetHeroPoseList(slot1) do
		if not slot0.heroPoseItemList_[slot6] then
			slot0.heroPoseItemList_[slot6] = HeroDisplayPoseItem.New(slot0.goItem_, slot0.goParent_)
		end

		slot0.heroPoseItemList_[slot6]:SetData(slot1, slot6)
		slot0.heroPoseItemList_[slot6]:SetSelect(slot6 == 1)
	end

	for slot6 = #slot2 + 1, #slot0.heroPoseItemList_ do
		slot0.heroPoseItemList_[slot6]:Show(false)
	end
end

function slot0.SetData(slot0, slot1)
	for slot5, slot6 in pairs(slot0.heroPoseItemList_) do
		slot6:SetSelect(slot5 == slot1)
	end
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4, slot5 in ipairs(slot0.heroPoseItemList_) do
		slot5:Dispose()
	end

	slot0.heroPoseItemList_ = nil
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)

	if slot1 then
		-- Nothing
	end
end

return slot0
