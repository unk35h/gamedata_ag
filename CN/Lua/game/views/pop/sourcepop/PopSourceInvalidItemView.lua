slot0 = class("PopSourceInvalidItemView", ReduxView)
slot1 = import("game.tools.JumpTools")

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform
	slot0.data_ = slot3

	SetActive(slot0.gameObject_, true)
	slot0:Init()
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:RefreshUI()
end

function slot0.Dispose(slot0)
	slot0.btn_ = nil
	slot0.sourceText_ = nil
	slot0.sourceContent_ = nil

	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.RefreshUI(slot0)
	slot0.sourceContent_.text, slot0.sourceText_.text = uv0.GetName(slot0.data_)
end

return slot0
