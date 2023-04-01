slot0 = import("manager.tips.TipsLongView")
slot1 = class("TipsMgr")

function slot1.Ctor(slot0)
	slot0.gameObject_ = nil
end

function slot1.OnCtor(slot0)
	print("initializing tip manager...")
end

function slot1.InitUI(slot0)
	slot0.gameObject_ = GameObject.Instantiate(Asset.Load("UI/TipPanel"), GameObject.Find("UICamera_DontDestroy/Canvas/UITip").transform)
	slot0.transform_ = slot0.gameObject_.transform
	slot0.longTips_ = uv0.New(slot0.gameObject_)
end

function slot1.ShowTips(slot0, slot1, slot2, slot3)
	if slot0.gameObject_ == nil then
		slot0:InitUI()
	end

	if TipsCfg[slot2] then
		slot0.longTips_:ShowTips(slot1)
		manager.audio:PlayEffect("ui_system", TipsCfg[slot2].audio, "")
	else
		slot0.longTips_:ShowTips(slot1)
		manager.audio:PlayEffect("ui_system", "success", "")
	end
end

function slot1.Show(slot0, slot1)
	if slot0.gameObject_ then
		SetActive(slot0.gameObject_, slot1)
	end
end

function slot1.Dispose(slot0)
	if slot0.longTips_ then
		slot0.longTips_:Dispose()

		slot0.longTips_ = nil
	end

	if slot0.gameObject_ then
		Object.Destroy(slot0.gameObject_)

		slot0.transform_ = nil
		slot0.gameObject_ = nil
	end
end

return slot1
