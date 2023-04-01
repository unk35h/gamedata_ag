slot0 = class("StoryItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	slot0.data_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform
	slot0.info_ = slot3

	slot0:InitUI()
	slot0:Init()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.name_.text = slot0.info_.name

	slot0:AddBtnListener(nil, , "OnClick")
end

function slot0.Init(slot0)
	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.lv_.text = slot0.info_.id

	slot0:Show(true)
end

function slot0.SetIndex(slot0, slot1)
	slot0.transform_:SetSiblingIndex(slot1)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	slot0.data_ = nil
	slot0.index_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.OnClick(slot0)
	manager.story:StartStory(slot0.info_.id)
end

function slot0.Show(slot0, slot1)
	if slot0.isShow_ == slot1 then
		return
	end

	slot0.isShow_ = slot1

	SetActive(slot0.gameObject_, slot1)
end

return slot0
