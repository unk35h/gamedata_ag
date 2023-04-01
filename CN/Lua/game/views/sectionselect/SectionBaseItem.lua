slot0 = class("SectionBaseItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2, slot3, slot4)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform
	slot0.transform_.name = slot3
	slot0.stageID_ = slot3
	slot0.chapterID_ = slot4

	slot0:Init()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot4 = true

	SetActive(slot0.gameObject_, slot4)

	slot0.collectItem_ = {}
	slot0.starGo_ = {}

	for slot4 = 1, 3 do
		slot0.collectItem_[slot4] = slot0[string.format("collectImage%s_", slot4)]
		slot0.starGo_[slot4] = slot0[string.format("collectGo%s_", slot4)]
	end
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.itemBtn_, nil, function ()
		uv0:OnClick()
	end)
end

function slot0.RemoveListeners(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()
	slot0:RefreshData()
	slot0:RefreshUI()
	slot0:InitCustom()
end

function slot0.Dispose(slot0)
	slot0:RemoveListeners()

	slot0.itemBtn_ = nil
	slot0.lockGo_ = nil
	slot0.collectItem_ = nil
	slot0.starGo_ = nil
	slot0.text_ = nil
	slot0.selectGo_ = nil
	slot0.bgGo_ = nil
	slot0.buttonImage_.sprite = nil
	slot0.buttonImage_ = nil

	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil
	slot0.transform_ = nil
	slot0.isShow_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.OnClick(slot0)
end

function slot0.RefreshUI(slot0)
	slot1 = slot0:GetPosition()
	slot0.transform_.localPosition = Vector3(slot1[1], slot1[2], 0)

	slot0:RefreshText()
	slot0:RefreshStar()

	if slot0:GetTag() == BattleConst.BATTLE_TAG.BOSS then
		slot0.buttonImage_.sprite = getSprite("Atlas/BattleStage", "but_bg_c")

		SetActive(slot0.bgGo_, true)
		SetActive(slot0.storyIconGo_, false)
	else
		if slot0.clearTimes_ == 0 then
			slot0.buttonImage_.sprite = getSprite("Atlas/BattleStage", "but_bg_a")
		else
			slot0.buttonImage_.sprite = getSprite("Atlas/BattleStage", "but_bg_b")
		end

		SetActive(slot0.bgGo_, false)

		if slot2 == BattleConst.BATTLE_TAG.STORY and slot0.enoughLevel_ then
			SetActive(slot0.storyIconGo_, true)
		else
			SetActive(slot0.storyIconGo_, false)
		end
	end

	SetActive(slot0.lockGo_, not slot0.enoughLevel_)
	SetActive(slot0.gameObject_, not slot0.isLock_)
end

function slot0.GetTag(slot0)
	return BattleConst.BATTLE_TAG.DEFAULT
end

function slot0.GetPosition(slot0)
	return {
		0,
		0
	}
end

function slot0.InitCustom(slot0)
end

function slot0.RefreshStar(slot0)
end

function slot0.RefreshText(slot0)
	slot0.text_.text = ""
end

function slot0.GetLocalPosition(slot0)
	return slot0.transform_.localPosition
end

function slot0.SelectorItem(slot0, slot1)
	if slot0.stageID_ == slot1 and slot0:IsOpenSectionInfo() then
		SetActive(slot0.selectGo_, true)
	else
		SetActive(slot0.selectGo_, false)
	end
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.chapterID_ = slot1
	slot0.stageID_ = slot2

	slot0:RefreshData()
	slot0:RefreshUI()
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

return slot0
