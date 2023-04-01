slot0 = class("AstrolabeItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	slot0.data_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform
	slot0.info_ = slot3

	slot0:InitUI()
	slot0:Init()
end

function slot0.RefreshData(slot0, slot1, slot2)
	slot0.data_ = slot1
	slot0.info_ = slot2

	slot0:Render()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.selectController_ = ControllerUtil.GetController(slot0.nameGo_.transform, "conName")

	slot0:AddBtnListener(slot0.itemBtn_, nil, "OnClick")
end

function slot0.Render(slot0)
	slot0:RefreshUI(slot0.info_)
end

function slot0.RefreshUI(slot0, slot1)
	slot0.info_ = slot1

	if slot1 then
		SetActive(slot0.activeGo_, slot1.isEquiped)
		SetActive(slot0.defaultGo_, not slot1.isEquiped)
		SetActive(slot0.lockGo_, not slot1.isUnlock)

		slot0.nameText_.text = HeroAstrolabeCfg[slot1.id].name
	end
end

function slot0.Init(slot0)
	slot0:RefreshUI(slot0.info_)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	slot0.clickFunc = nil

	uv0.super.Dispose(slot0)
end

function slot0.OnClick(slot0)
	if slot0.clickFunc then
		slot0:clickFunc()
	end
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

function slot0.GetItemInfo(slot0)
	return slot0.info_
end

function slot0.ShowSelect(slot0, slot1)
	SetActive(slot0.selectGo_, slot1)
	slot0.selectController_:SetSelectedState(slot1 and "state1" or "state0")
end

function slot0.SetRedPoint(slot0, slot1)
	SetActive(slot0.noticeGo_, slot1)

	if not slot0.info_.isUnlock then
		SetActive(slot0.lockGo_, not slot1)
		SetActive(slot0.lockUpGo_, slot1)
	else
		SetActive(slot0.lockGo_, false)
		SetActive(slot0.lockUpGo_, false)
	end
end

return slot0
