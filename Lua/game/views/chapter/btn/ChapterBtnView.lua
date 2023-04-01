slot0 = class("ChapterBtnView", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.toggle_ = slot2
	slot0.toggleActive_ = false

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.lockController_ = ControllerUtil.GetController(slot0.transform_, "lock")

	if ChapterClientCfg.get_id_list_by_toggle[slot2] then
		SetActive(slot0.gameObject_, true)
	else
		SetActive(slot0.gameObject_, false)
	end
end

function slot0.OnEnter(slot0)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.transform_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.transform_:GetChild(0):GetComponent(typeof(RectTransform)))
	slot0:RefreshNotice()

	if slot0.toggle_ == BattleConst.TOGGLE.SUB_PLOT then
		slot0.isLock_ = PlayerData:GetPlayerInfo().userLevel < GameSetting.sub_plot_unlock_level.value[1]

		slot0:RefreshLock()
	elseif slot0.toggle_ == BattleConst.TOGGLE.RESOURCE then
		slot0.isLock_ = JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.BATTLE_DAILY)

		slot0:RefreshLock()
	elseif slot0.toggle_ == BattleConst.TOGGLE.EQUIP then
		slot0.isLock_ = JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.BATTLE_EQUIP)

		slot0:RefreshLock()
	end
end

function slot0.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.transform_)
end

function slot0.Dispose(slot0)
	slot0:RemoveListeners()
	uv0.super.Dispose(slot0)

	slot0.checkPanel_ = nil
	slot0.btn_ = nil
end

function slot0.InitUI(slot0)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.transform_:GetChild(0):GetComponent(typeof(RectTransform)))
	slot0:BindCfgUI()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.active_ then
			return
		end

		slot1 = ViewConst.SYSTEM_ID.BATTLE

		if uv0.toggle_ == BattleConst.TOGGLE.PLOT then
			slot1 = ViewConst.SYSTEM_ID.BATTLE
		elseif slot0 == BattleConst.TOGGLE.RESOURCE then
			slot1 = ViewConst.SYSTEM_ID.BATTLE_DAILY
		elseif slot0 == BattleConst.TOGGLE.CHALLENGE then
			slot1 = ViewConst.SYSTEM_ID.BATTLE_ASTROLABE
		elseif slot0 == BattleConst.TOGGLE.EQUIP then
			slot1 = ViewConst.SYSTEM_ID.BATTLE_EQUIP
		elseif slot0 == BattleConst.TOGGLE.SUB_PLOT then
			slot1 = ViewConst.SYSTEM_ID.BATTLE_SUB_PLOT

			if uv0.isLock_ and slot0 == BattleConst.TOGGLE.SUB_PLOT then
				ShowTips(string.format(GetTips("PLAYER_LEVEL_UNLOCK"), GameSetting.sub_plot_unlock_level.value[1]))

				return
			end
		end

		JumpTools.GoToSystem("/chapterMap", {
			chapterToggle = uv0.toggle_
		}, slot1)
		OperationRecorder.Record(uv0.class.__cname, tostring(uv0.toggle_))
	end)
end

function slot0.RemoveListeners(slot0)
	slot0.btn_.onClick:RemoveAllListeners()
end

function slot0.SelectChapterToggle(slot0, slot1)
	slot0.active_ = slot1

	SetActive(slot0.checkPanel_, slot1)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.transform_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.transform_:GetChild(0):GetComponent(typeof(RectTransform)))
end

function slot0.RefreshNotice(slot0)
	if slot0.toggle_ == BattleConst.TOGGLE.PLOT then
		manager.redPoint:bindUIandKey(slot0.transform_, RedPointConst.COMBAT_PLOT, {
			x = 135,
			y = 14.801
		})
	elseif slot1 == BattleConst.TOGGLE.SUB_PLOT then
		manager.redPoint:bindUIandKey(slot0.transform_, RedPointConst.COMBAT_SUB_PLOT, {
			x = 135,
			y = 14.801
		})
	elseif slot1 == BattleConst.TOGGLE.CHALLENGE then
		manager.redPoint:bindUIandKey(slot0.transform_, RedPointConst.COMBAT_CHALLENGE, {
			x = 135,
			y = 14.801
		})
	elseif slot1 == BattleConst.TOGGLE.EQUIP then
		manager.redPoint:bindUIandKey(slot0.transform_, RedPointConst.COMBAT_EQUIP, {
			x = 135,
			y = 14.801
		})
	end
end

function slot0.RefreshLock(slot0)
	slot0.lockController_:SetSelectedState(tostring(slot0.isLock_))
end

return slot0
