slot1 = class("ChatBaseItemView", import("game.views.chat.loopScrollView.LoopScrollViewBaseItem"))

function slot1.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
	slot0:Init()
	slot0:AddListeners()
	slot0:Show(true)
end

function slot1.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot1.Init(slot0)
end

function slot1.AddListeners(slot0)
end

function slot1.Dispose(slot0)
	slot0:RemoveAllListeners()
	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil
	slot0.transform_ = nil

	uv0.super.Dispose(slot0)
end

return slot1
