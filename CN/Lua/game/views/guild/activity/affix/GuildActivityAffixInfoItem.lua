slot0 = class("GuildActivityAffixRInfoItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1.gameObject
	slot0.transform_ = slot1

	SetActive(slot0.gameObject_, true)
	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.unlockController_ = ControllerUtil.GetController(slot0.transform_, "state")
end

function slot0.AddUIListener(slot0)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.affixID_ = slot1
	slot0.level_ = slot2
	slot0.unlock_ = slot2 <= slot3

	slot0.unlockController_:SetSelectedState(tostring(slot0.unlock_))

	slot0.descText_.text = getAffixDesc({
		slot0.affixID_,
		slot0.level_
	})
	slot0.levelText_.text = GetTips("LEVEL") .. slot0.level_
end

function slot0.OnExit(slot0)
	SetActive(slot0.levelUpAnim_.gameObject, false)
end

function slot0.Dispose(slot0)
	slot0.gameObject_ = nil
	slot0.transform_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.OnUpgrade(slot0)
	SetActive(slot0.levelUpAnim_.gameObject, true)
	slot0.levelUpAnim_:Play("TalentUILevelUp", -1, 0)
end

return slot0
