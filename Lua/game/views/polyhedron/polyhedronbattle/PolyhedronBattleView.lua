slot0 = class("PolyhedronBattleView", ReduxView)

function slot0.UIName(slot0)
	return "UI/PolyhedronBattle/PolyhedronBattleUI"
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

	slot0.headList = {}

	for slot4 = 1, 3 do
		table.insert(slot0.headList, polyhedronBattleHeadItem.New(slot0["m_role" .. slot4]))
	end

	slot0.tipsItems_ = {}
	slot0.tipsDispose_ = handler(slot0, slot0.OnTipsDispose)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_teamBtn, nil, function ()
		JumpTools.OpenPageByJump("polyhedronTeamInfo")
	end)
end

function slot0.OnTop(slot0)
	slot0:StartTimer()
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot1 = PolyhedronData:GetPolyhedronInfo()
	slot0.polyhedronInfo = slot1
	slot3 = PolyhedronTierCfg[slot1:GetTierId()]
	slot0.m_stageName.text = slot3.tier .. "-" .. slot3.level
	slot0.m_difficultyLab.text = slot1:GetDifficulty()
	slot5 = slot1:GetFightHeroList()

	for slot9, slot10 in ipairs(slot0.headList) do
		slot10:SetData(slot1, slot5[slot9] or 0)
	end

	slot0.coinId = slot1:GetPolyhedronCoinId()
	slot0.m_coinIcon.sprite = ItemTools.getItemLittleSprite(slot0.coinId)
	slot0.m_coinLab.text = slot0.polyhedronInfo:GetCoinCount()
end

function slot0.OnUpdate(slot0)
	slot0.m_coinLab.text = slot0.polyhedronInfo:GetCoinCount()
end

function slot0.OnExit(slot0)
	slot0:StopTimer()
end

function slot0.Dispose(slot0)
	slot0:StopTimer()

	for slot4, slot5 in ipairs(slot0.headList) do
		slot5:Dispose()
	end

	slot0.headList = nil

	uv0.super.Dispose(slot0)

	for slot4, slot5 in pairs(slot0.tipsItems_) do
		slot5:Dispose()
	end
end

function slot0.OnPolyhedronGameUpdate(slot0)
	slot0:RefreshUI()
end

function slot0.OnPolyhedronProcessUpdate(slot0)
	slot0:RefreshUI()
end

function slot0.StartTimer(slot0)
	if slot0.timer_ == nil then
		slot0.timer_ = Timer.New(function ()
			uv0:UpdateTimer()
		end, 1, -1)
	end

	slot0.timer_:Start()
end

function slot0.UpdateTimer(slot0)
	if PolyhedronData:GetTipsData() then
		slot0:CreatTips(slot1)
	end
end

function slot0.CreatTips(slot0, slot1)
	for slot5, slot6 in pairs(slot0.tipsItems_) do
		if not slot6:GetIsShow() then
			slot6:SetData(slot1)
			slot6:SetIsShow(true)
			LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.contentTrans_)

			return
		end
	end

	slot3 = PolyhedronBattleTipItem.New(GameObject.Instantiate(slot0.tipsGo_, slot0.contentTrans_))

	slot3:SetDisposeHandler(slot0.tipsDispose_)
	slot3:SetData(slot1)
	slot3:SetIsShow(true)
	table.insert(slot0.tipsItems_, slot3)
	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.contentTrans_)
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.OnTipsDispose(slot0, slot1)
	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.contentTrans_)
end

return slot0
