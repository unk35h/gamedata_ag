slot0 = class("DormRoomUnLockItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.unLockBtn_, nil, function ()
		if uv0.unLockFunc then
			uv0.unLockFunc(uv0.archiveID)
		end
	end)
end

function slot0.RefreshUI(slot0, slot1)
	slot0.archiveID = slot1
	slot0.archiveName.text = string.format(GetTips("DORM_HERO_ROOM_NAME"), HeroRecordCfg[slot0.archiveID].name)
	slot0.condition.text = string.format(GetTips("DORM_ROOM_UNLOCK_TIPS"), HeroRecordCfg[slot0.archiveID].name)
end

function slot0.PlaceHeroCallBack(slot0, slot1)
	if slot1 then
		slot0.unLockFunc = slot1
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
