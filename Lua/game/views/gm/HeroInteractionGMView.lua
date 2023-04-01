slot0 = class("HeroInteractionGMView", ReduxView)

function slot0.UIName(slot0)
	return "UI/HeroInteractionGMUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
	slot0.btnPool_ = {}
	slot0.curBtnCount_ = 0
	slot0.skinId_ = -1
	slot0.inited_ = false
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.inited_ = true
end

function slot0.InitUI(slot0)
	slot0.backgroundBtn_ = slot0:FindCom("Button", "background")
	slot0.btn_prefab = slot0:FindGo("HeroInteractionBut_prefab")
	slot0.panel_go = slot0:FindTrs("panel")
	slot0.btn_list = {}
	slot0.btnGo_list = {}
	slot0.idleTimer_ = slot0.params_.idleTimer
	slot0.skinId_ = slot0.params_.skinId

	if slot0.skinId_ == nil then
		print("skinId 为 nil")
	end

	slot0.animator_ = slot0.params_.animator

	if slot0.inited_ == false then
		slot0:InitData()
	end
end

function slot0.OnEnter(slot0)
	slot1 = HeroInteractionGMData:GetParam()
	slot0.idleTimer_ = slot1[2]
	slot0.skinId_ = slot1[1]
	slot0.animator_ = slot1[3]

	if slot0.skinId_ == nil then
		print("skinId 为 nil")
	end

	if slot0.inited_ == false then
		slot0:InitData()
		slot0:AddUIListener()
	end
end

function slot0.InitData(slot0)
	if SkinCfg[slot0.skinId_].hero == nil then
		print("heroID 为 nil")
	end

	slot0.interactionCfg_ = HeroInteractionCfg[slot1]

	if slot0.interactionCfg_ == nil then
		print("self.interactionCfg_ 为 nil")
	end

	slot0.actionTypeList_ = {}

	if slot0.interactionCfg_ ~= nil then
		for slot5, slot6 in pairs(slot0.interactionCfg_) do
			if type(slot0.interactionCfg_[slot5]) == "table" and #slot0.interactionCfg_[slot5] ~= 0 and string.find(slot5, "delay") == nil then
				table.insert(slot0.actionTypeList_, slot5)
			end
		end
	end

	slot0:GenBtn()
	HeroInteractionGMData:Updata(slot0.skinId_, slot0.idleTimer_, slot0.animator_)
end

function slot0.GenBtn(slot0)
	if slot0.actionTypeList_ ~= nil and #slot0.actionTypeList_ > 0 then
		slot1, slot2, slot3 = nil

		for slot7, slot8 in ipairs(slot0.actionTypeList_) do
			if slot0.curBtnCount_ < #slot0.btnPool_ then
				slot0.curBtnCount_ = slot0.curBtnCount_ + 1

				SetActive(slot0.btnPool_[slot0.curBtnCount_], true)
			else
				slot1 = Object.Instantiate(slot0.btn_prefab, slot0.panel_go)
				slot0.curBtnCount_ = slot0.curBtnCount_ + 1

				table.insert(slot0.btnPool_, slot1)

				if slot1:GetComponent(typeof(Button)) == nil then
					print("button_:按钮为空")
				end

				table.insert(slot0.btn_list, slot3)
			end

			if slot1:GetComponentInChildren(typeof(Text)) ~= nil then
				slot2.text = slot8
			else
				print("btn_text为空")
			end
		end
	end
end

function slot0.AddUIListener(slot0)
	for slot4, slot5 in ipairs(slot0.btn_list) do
		slot0:AddBtnListener(slot5, nil, function ()
			JumpTools.GoToSystem("heroInteractionGMContent", {
				typeName = uv0.actionTypeList_[uv1],
				skinId = uv0.skinId_,
				animator = uv0.animator_,
				idleTimer = uv0.idleTimer_
			})
		end)
	end

	slot0:AddBtnListener(slot0.backgroundBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnExit(slot0)
	slot0:RemoveAllListeners()

	for slot4 = 1, slot0.curBtnCount_ do
		SetActive(slot0.btnPool_[slot4], false)
	end

	slot0.curBtnCount_ = 0
	slot0.inited_ = false
end

function slot0.Dispose(slot0)
	slot0.btn_list = nil

	if slot0.btnPool_ then
		for slot4, slot5 in ipairs(slot0.btnPool_) do
			Object.Destroy(slot5)
		end

		slot0.btnPool_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
