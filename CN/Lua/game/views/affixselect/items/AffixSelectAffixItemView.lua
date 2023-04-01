slot0 = class("AffixSelectAffixItemView", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.onItemSelect_ = slot2

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.btn_ = slot0.gameObject_:GetComponent(typeof(Button))
	slot0.selectController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "select1")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		uv0:SetSelect(not uv0.isSelect_)

		if uv0.onItemSelect_ ~= nil then
			uv0.onItemSelect_(uv0.affixPoolId_, uv0.isSelect_)
		end
	end)
end

function slot0.AddEventListeners(slot0)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.index_ = slot1
	slot0.affixPoolId_ = slot2
	slot0.isSelect_ = slot3
	slot0.cfg_ = ActivityAffixPoolCfg[slot2]

	slot0:UpdateView()
	slot0:SetSelect(slot0.isSelect_)
end

function slot0.SetSelect(slot0, slot1)
	slot0.isSelect_ = slot1

	slot0.selectController_:SetSelectedState(slot1 and "select" or "normal")
end

function slot0.UpdateView(slot0)
	slot0.numLabel_.text = slot0.cfg_.point
	slot0.descLabel_.text = getAffixDesc(slot0.cfg_.affix)
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	slot0.data_ = nil
	slot0.onItemSelect_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
