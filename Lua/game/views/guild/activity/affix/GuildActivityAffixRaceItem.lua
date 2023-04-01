slot0 = class("GuildActivityAffixRaceItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1.gameObject
	slot0.transform_ = slot1

	SetActive(slot0.gameObject_, true)
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
	slot0:AddBtnListener(slot0.Btn_, nil, function ()
		if uv0.selectCallBack_ then
			uv0.selectCallBack_(uv0.raceID_)
		end
	end)
end

function slot0.SetData(slot0, slot1)
	slot0.raceID_ = slot1
end

function slot0.SetSelectCallBack(slot0, slot1)
	slot0.selectCallBack_ = slot1
end

function slot0.SetSelect(slot0, slot1)
end

function slot0.Dispose(slot0)
	slot0.gameObject_ = nil
	slot0.transform_ = nil
	slot0.selectCallBack_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.BindRedPoint(slot0, slot1)
	if slot0.raceID_ ~= nil then
		manager.redPoint:bindUIandKey(slot0.transform_, string.format("%s_%d_%d", RedPointConst.GUILD_ACTIVITY_AFFIX, slot1, slot0.raceID_))
	end
end

function slot0.UnBindRedPoint(slot0, slot1)
	if slot0.raceID_ ~= nil then
		manager.redPoint:unbindUIandKey(slot0.transform_, string.format("%s_%d_%d", RedPointConst.GUILD_ACTIVITY_AFFIX, slot1, slot0.raceID_))
	end
end

return slot0
