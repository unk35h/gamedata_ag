slot0 = class("AchievementUpgradeView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Achievement/AchievementUpgradeUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()
end

function slot0.OnEnter(slot0)
	slot2 = LeanTween.value(slot0.gameObject_, slot0.params_.currentPoint / slot0.params_.upgradePoint, 1, 0.5)
	slot2 = slot2:setOnUpdate(LuaHelper.FloatAction(function (slot0)
		uv0.slider_.value = slot0
	end))

	slot2:setOnComplete(System.Action(function ()
		uv0.canCancel_ = true

		LeanTween.cancel(uv0.gameObject_)
	end))
end

function slot0.OnExit(slot0)
	LeanTween.cancel(slot0.gameObject_)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.buttonClose_, nil, function ()
		if uv0.canCancel_ then
			uv0:Back()
		end
	end)
end

return slot0
