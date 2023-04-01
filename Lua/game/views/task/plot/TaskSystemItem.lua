slot0 = class("TaskSystemItem", ReduxView)
slot1 = import("game.tools.JumpTools")

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
	SetActive(slot0.gameObject_, true)
end

function slot0.SetData(slot0, slot1)
	slot0.cfgID_ = slot1

	slot0:RefreshUI()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.Dispose(slot0)
	slot0:RemoveListeners()
	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.InitUI(slot0)
	slot0.titleText_ = slot0:FindCom(typeof(Text), "lockLayout/title")
	slot0.titleText2_ = slot0:FindCom(typeof(Text), "unlockLayout/title")
	slot0.unactivePanel_ = slot0:FindGo("lockLayout")
	slot0.targetText_ = slot0:FindCom(typeof(Text), "lockLayout/text")
	slot0.activePanel_ = slot0:FindGo("unlockLayout")
end

function slot0.AddListeners(slot0)
end

function slot0.RemoveListeners(slot0)
end

function slot0.RefreshUI(slot0)
	SetActive(slot0.unactivePanel_, not slot0:IsOpen())
	SetActive(slot0.activePanel_, slot0:IsOpen())

	slot1 = SystemCfg[slot0.cfgID_]

	if not slot0:IsOpen() then
		slot0.titleText_.text = string.format("%s解锁", slot1.name)
	else
		slot0.titleText2_.text = string.format("%s解锁", slot1.name)
	end
end

function slot0.SetSiblingIndex(slot0, slot1)
	slot0.transform_:SetSiblingIndex(slot1)
end

function slot0.IsOpen(slot0)
	uv0.IsSystemLocked(slot0.cfgID_)
end

return slot0
