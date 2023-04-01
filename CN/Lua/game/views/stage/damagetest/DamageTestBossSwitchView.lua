slot0 = class("BossSwitchView", ReduxView)

function slot0.UIName(slot0)
	return "UI/DamageTest/BossSwitchUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.listGo_, BossSwitchItem)
end

function slot0.AddListeners(slot0)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:RefreshData({
		id = slot0.bossList_[slot1],
		index = slot1
	})
	slot2:RegistCallBack(function (slot0)
		JumpTools.GoToSystem("/damageTestBossInfo", {
			damageTestId = slot0.id
		})
	end)
end

function slot0.RefreshUI(slot0)
	if slot0.battleType_ == 0 then
		slot0.nameText_.text = "DEAD MAN"
	elseif slot0.battleType_ == 1 then
		slot0.nameText_.text = "COMBAT"
	elseif slot0.battleType_ == 3 then
		slot0.nameText_.text = "MOVE MAN"
	end

	slot0.scrollHelper_:StartScroll(#slot0.bossList_)
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	slot0.battleType_ = slot0.params_.battleType
	slot0.bossList_ = DamageTestCfg.get_id_list_by_battle_type[slot0.battleType_]

	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	slot0.scrollHelper_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
