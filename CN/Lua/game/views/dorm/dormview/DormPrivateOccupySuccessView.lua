slot0 = class("DormPrivateOccupySuccessView", ReduxView)

function slot0.UIName(slot0)
	return "UI/BackHouseUI/Dorm/DormUnlockTips"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.OnEnter(slot0)
	slot0.archiveID = slot0.params_.archiveID

	if DormData:GetHeroInfo(slot0.archiveID).canUseHero and #slot1.canUseHero > 0 then
		slot0.iconImg_.sprite = HeroTools.GetBackHomeHeadSprite(slot1.canUseHero[1])
	end

	if slot0.archiveID and HeroRecordCfg[slot0.archiveID] then
		if HeroRecordCfg[slot0.archiveID].name then
			slot0.nameTex_.text = string.format(GetTips("DORM_HERO_ROOM_NAME"), slot2)
		end
	else
		Debug.LogError("名字不存在")
	end
end

function slot0.OnExit(slot0)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListenerScale(slot0.bgBtn_, nil, function ()
		JumpTools.OpenPageByJump("/dormChooseRoomView")
	end)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
