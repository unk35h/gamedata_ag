slot0 = class("ActivityMatrixStoryReviewTalkItem", ReduxView)

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
end

function slot0.SetData(slot0, slot1)
	slot3 = slot1[2] or 0
	slot0.m_head.sprite = getSpriteWithoutAtlas("Textures/Story/Character/" .. (slot1[1] or ""))
	slot0.m_content.text = StoryWordCfg[slot3] and StoryWordCfg[slot3].content or ""
end

return slot0
