slot0 = class("DrawHeroSelectView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Draw/DrawSelectPop"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.selectController = ControllerUtil.GetController(slot0.m_controller, "select")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_leftBtn, nil, function ()
		uv0:SetSelect(1)
	end)
	slot0:AddBtnListener(slot0.m_rightBtn, nil, function ()
		uv0:SetSelect(2)
	end)
	slot0:AddBtnListener(slot0.m_sureBtn, nil, function ()
		slot1 = DrawData:GetPollUpID(uv0.poolId)

		if uv0.optional_lists[uv0.select] then
			if slot1 ~= slot0 then
				DrawAction.SetPollUpID(uv0.poolId, slot0)
			else
				uv0:Back()
			end
		else
			error("DrawHeroSelectView with empty pool up id")
		end
	end)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({})
end

function slot0.OnSetPollUpID(slot0, slot1, slot2)
	slot0:Back()
end

function slot0.OnEnter(slot0)
	slot0:SetSelect(0)

	slot0.poolId = slot0.params_.poolId
	slot0.cfg = DrawPoolCfg[slot0.poolId]

	if slot0.optional_lists ~= slot0.cfg.optional_lists then
		slot0.optional_lists = slot0.cfg.optional_lists

		slot0:CreatOptionalHeroCom()
	elseif slot0.leftCom == nil or slot0.rightCom == nil then
		slot0:CreatOptionalHeroCom()
	end

	slot0:SetSelect(table.indexof(slot0.optional_lists, DrawData:GetPollUpID(slot0.poolId)) or 0)
end

function slot0.CreatOptionalHeroCom(slot0)
	if slot0.leftCom then
		Object.Destroy(slot0.leftCom)
	end

	if slot0.rightCom then
		Object.Destroy(slot0.rightCom)
	end

	slot1 = slot0.cfg.optional_detail
	slot0.leftCom = Object.Instantiate(Asset.Load("UI/Draw/SelectUp/select_" .. slot1[1]), slot0.m_leftContent)
	slot0.rightCom = Object.Instantiate(Asset.Load("UI/Draw/SelectUp/select_" .. slot1[2]), slot0.m_rightContent)
end

function slot0.SetSelect(slot0, slot1)
	slot0.select = slot1

	slot0.selectController:SetSelectedIndex(slot1)

	slot0.m_sureBtn.interactable = slot1 ~= 0
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	slot0.leftCom = nil
	slot0.rightCom = nil

	uv0.super.Dispose(slot0)
end

return slot0
