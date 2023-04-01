slot0 = class("SourceItem", ReduxView)
slot1 = import("game.const.HeroConst")
slot2 = import("game.tools.JumpTools")

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
	slot0.type_ = slot0:FindCom(typeof(Text), "image/type")
	slot0.name_ = slot0:FindCom(typeof(Text), "unlock/name")
	slot0.lockName_ = slot0:FindCom(typeof(Text), "lock/name")
	slot0.lockGo_ = slot0:FindGo("lock")
	slot0.unlockGo_ = slot0:FindGo("unlock")

	slot0:AddBtnListener("unlock/btn_go", nil, "OnClick")
end

function slot0.Init(slot0)
	slot0:RefreshUI(slot0.info_)
end

function slot0.Render(slot0)
	slot0:RefreshUI(slot0.info_)
end

function slot0.RefreshUI(slot0, slot1)
	slot0.isLock_ = uv0.GetLinkIsLocked(slot1)

	SetActive(slot0.lockGo_, slot0.isLock_)
	SetActive(slot0.unlockGo_, not slot0.isLock_)

	slot0.type_.text = SystemLinkCfg[slot1[1]].text_display_1

	if slot0.isLock_ then
		slot0.lockName_.text = uv0.GetName(slot1)
	else
		slot0.name_.text = uv0.GetName(slot1)
	end
end

function slot0.OnClick(slot0)
	if slot0.isLock_ then
		return
	end

	uv0.JumpToPage(slot0.info_)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
