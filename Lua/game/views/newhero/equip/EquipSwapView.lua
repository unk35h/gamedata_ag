slot0 = class("EquipSwapView", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2, slot3, slot4)
	slot0.handler_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform
	slot0.info_ = slot4

	slot0:Init()
end

function slot0.RefreshData(slot0, slot1, slot2)
	slot0.handler_ = slot1
	slot0.info_ = slot2
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.equipOldInfoView_ = EquipPopInfoView.New(slot0.infoGoOld_)

	slot0.equipOldInfoView_:SetClickMessage("old")

	slot0.equipNewInfoView_ = EquipPopInfoView.New(slot0.infoGoNew_)

	slot0.equipNewInfoView_:SetClickMessage("new")

	slot0.infoTrsOld_ = slot0.infoGoOld_:GetComponent(typeof(RectTransform))
	slot0.infoTrsNew_ = slot0.infoGoNew_:GetComponent(typeof(RectTransform))
	slot0.equipSkillView_ = EquipNewSkillInfoView.New(slot0.skillInfoGo_)
	slot0.skillTrs_ = slot0.skillInfoGo_:GetComponent(typeof(RectTransform))
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.backBtn_, nil, function ()
		uv0:HideMaskMessage()
		uv0.handler_:RefreshBagSelectStatus(0)
		uv0:SetInfoIsShow(false)
	end)
	slot0:AddBtnListener(slot0.backMaskBtn_, nil, function ()
		uv0:HideMaskMessage()
		uv0.handler_:RefreshBagSelectStatus(0)
		uv0:SetInfoIsShow(false)
	end)
	slot0:AddBtnListener(slot0.backMaskDragBtn_, nil, function ()
		uv0:HideMaskMessage()
		uv0.handler_:RefreshBagSelectStatus(0)
		uv0:SetInfoIsShow(false)
	end)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:HideMaskMessage()
	end)
	slot0:AddBtnListener(slot0.strengthOldBtn_, nil, function ()
		if uv0.oldEquipInfo_ then
			uv0.oldEquipInfo_.id = uv0.oldEquipInfo_.prefab_id

			ShowPopItem(POP_OPERATE_ITEM, uv0.oldEquipInfo_, {
				page = 2
			})
		end
	end)
	slot0:AddBtnListener(slot0.strengthNewBtn_, nil, function ()
		if uv0.newEquipInfo_ then
			uv0.newEquipInfo_.id = uv0.newEquipInfo_.prefab_id

			ShowPopItem(POP_OPERATE_ITEM, uv0.newEquipInfo_, {
				page = 2
			})
		end
	end)
	slot0:AddBtnListener(slot0.unloadBtn_, nil, function ()
		if uv0.oldEquipInfo_ then
			uv0:SendUseEquip(uv0.info_.heroId, 0, EquipCfg[uv0.oldEquipInfo_.prefab_id].pos)
		end
	end)
	slot0:AddBtnListener(slot0.changeBtn_, nil, function ()
		slot3 = uv0.info_.heroId
		slot4 = EquipCfg[uv0.newEquipInfo_.prefab_id].pos
		slot5 = HeroData:GetEquipMap()[uv0.newEquipInfo_.equip_id] or 0
		slot6 = HeroCfg[slot5]

		if slot5 and slot6 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = string.format(GetTips("EQUIP_IS_USING"), GetI18NText(slot6.name)),
				OkCallback = function ()
					uv0:SendUseEquip(uv1, uv2, uv3)
				end
			})
		else
			uv0:SendUseEquip(slot3, slot2, slot4)
		end
	end)
end

function slot0.SendUseEquip(slot0, slot1, slot2, slot3)
	HeroAction.EquipSwap(slot1, slot2, slot3)
end

function slot0.HideMaskMessage(slot0)
	SetActive(slot0.maskGo_, false)
	SetActive(slot0.skillInfoGo_, false)

	if slot0.lastSkillSelect_ then
		slot0.lastSkillSelect_:ShowSelect(false)
	end
end

function slot0.ChildToggleSelect(slot0, slot1, slot2)
	slot0.selectType_ = slot1

	if slot2 == "new" then
		if slot0.equipOldInfoView_ then
			slot0.equipOldInfoView_:ChangeSelect(slot1)
		end
	elseif slot0.equipNewInfoView_ then
		slot0.equipNewInfoView_:ChangeSelect(slot1)
	end
end

function slot0.SkillClick(slot0, slot1, slot2, slot3)
	SetActive(slot0.maskGo_, true)
	SetActive(slot0.skillInfoGo_, true)

	if slot0.lastSkillSelect_ then
		slot0.lastSkillSelect_:ShowSelect(false)
	end

	slot0.lastSkillSelect_ = slot1

	slot1:ShowSelect(true)
	slot0.equipSkillView_:RefreshData(slot0, slot2)
	slot0:RefreshByMessage(slot3)
end

function slot0.HeroSkillClickToJump(slot0, slot1, slot2, slot3)
	slot0:HideMaskMessage()
	JumpTools.OpenPageByJump("/equipHeroSkillUI", {
		equipID = slot2.equipID
	})
end

function slot0.RefreshByMessage(slot0, slot1)
	if slot1 == "new" or slot0.oldPos_ and slot0.oldPos_ == "new" then
		slot0.skillTrs_.anchoredPosition = Vector3(318, 0, 0)
	else
		slot0.skillTrs_.anchoredPosition = Vector3(868, 0, 0)
	end
end

function slot0.SetInfoIsShow(slot0, slot1)
	slot0.isShow_ = slot1

	if not slot0.timer_ then
		slot0.timer_ = Timer.New(function ()
			SetActive(uv0.gameObject_, uv0.isShow_)

			uv0.timer_ = nil
		end, 0.034, 1)

		slot0.timer_:Start()
	end
end

function slot0.RefreshEquipS(slot0, slot1, slot2, slot3, slot4)
	slot0:HideMaskMessage()
	SetActive(slot0.infoGoOld_, slot1 ~= nil and not slot4)

	slot5 = HeroCfg[slot0.info_.heroId].race

	if slot1 then
		slot1.isKeep = true

		slot0.equipOldInfoView_:RefreshData(slot0, slot1, handler(slot0, slot0.RefreshEquipLock), slot0.info_.heroId)
		slot0.equipOldInfoView_:ShowRaceAdd(slot1.race == slot5 or slot1.race == slot0.info_.heroId)
		slot0.equipOldInfoView_:ChangeSelect(slot0.selectType_)
	end

	SetActive(slot0.infoGoNew_, slot2 ~= nil and not slot4)

	if slot2 then
		slot2.isKeep = true

		slot0.equipNewInfoView_:RefreshData(slot0, slot2, handler(slot0, slot0.RefreshEquipLock), slot0.info_.heroId)
		slot0.equipNewInfoView_:ShowRaceAdd(slot2.race == slot5 or slot2.race == slot0.info_.heroId)
		slot0.equipNewInfoView_:ChangeSelect(slot0.selectType_)
	end

	if slot2 == nil and slot3 and slot3 <= 3 then
		slot0.infoTrsOld_.anchoredPosition = Vector3(868, 0, 0)
		slot0.oldPos_ = "new"
	else
		slot0.infoTrsOld_.anchoredPosition = Vector3(318, 0, 0)
		slot0.oldPos_ = "old"
	end

	slot0.oldEquipInfo_ = slot1
	slot0.newEquipInfo_ = slot2
end

function slot0.RefreshEquipLock(slot0, slot1, slot2)
	slot0.handler_:RefreshEquipLock(slot1, slot2)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.OnEnter(slot0)
	slot0.oldPos_ = "old"
end

function slot0.OnExit(slot0)
	slot0:HideMaskMessage()

	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.Dispose(slot0)
	if slot0.equipOldInfoView_ then
		slot0.equipOldInfoView_:Dispose()

		slot0.equipOldInfoView_ = nil
	end

	if slot0.equipNewInfoView_ then
		slot0.equipNewInfoView_:Dispose()

		slot0.equipNewInfoView_ = nil
	end

	if slot0.equipSkillView_ then
		slot0.equipSkillView_:Dispose()

		slot0.equipSkillView_ = nil
	end

	if slot0.equipHeroSkillView_ then
		slot0.equipHeroSkillView_:Dispose()

		slot0.equipHeroSkillView_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
