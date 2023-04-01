slot0 = class("CustomItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.selectCon_ = ControllerUtil.GetController(slot0.transform_, "select")
	slot0.lvCon_ = ControllerUtil.GetController(slot0.transform_, "lv")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.clickFunc_ then
			uv0.clickFunc_(uv0.customID_)
		end
	end)
end

function slot0.OnEnter(slot0)
end

function slot0.RefreshUI(slot0, slot1, slot2)
	slot0.customID_ = slot1
	slot0.isSelect_ = slot2
	slot0.cfg_ = ActivityAffixPoolCfg[slot0.customID_]
	slot0.pointText_.text = slot0.cfg_.point
	slot0.icon_.sprite = getAffixSprite(ActivityAffixPoolCfg[slot0.customID_].affix)

	slot0.selectCon_:SetSelectedState(slot2 and "true" or "false")
	slot0.lvCon_:SetSelectedState(slot0.cfg_.affix[2])
end

function slot0.RegisterClickListener(slot0, slot1)
	slot0.clickFunc_ = slot1
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
