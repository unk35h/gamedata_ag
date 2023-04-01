slot0 = class("ActivityMatrixStoryReviewItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_list, ActivityMatrixStoryReviewTalkItem)
end

function slot0.GetHeight(slot0)
	return slot0.hight or 0
end

function slot0.SetData(slot0, slot1)
	slot3 = 0

	if _G["Story" .. slot1] and slot2.narrativeData then
		slot0.talks = slot2.narrativeData
		slot3 = #slot0.talks
	end

	slot0.list:StartScroll(slot3)

	if slot3 == 0 then
		slot0.hight = 369.18
	else
		slot0.hight = 169.18 + 100 * slot3
	end

	slot0.transform_.sizeDelta = Vector2.New(slot0.transform_.rect.width, slot0.hight)
	slot0.m_title.text = StoryCfg[slot1] and StoryCfg[slot1].name or ""
	slot0.m_des.text = slot2 and slot2.narrativeTime and StoryWordCfg[slot2.narrativeTime].content or ""
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)

	if not slot1 then
		slot0.hight = 0
	end
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.talks[slot1])
end

function slot0.Dispose(slot0)
	slot0.list:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
