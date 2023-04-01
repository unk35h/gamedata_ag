slot0 = class("DormVisitItem", ReduxView)

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
	slot0:AddBtnListener(slot0.visitBtn_, nil, function ()
		if uv0.visitFunc then
			uv0.visitFunc(uv0.userID)
		end
	end)
end

function slot0.RegisterEnterCallBack(slot0, slot1)
	if slot1 then
		slot0.visitFunc = slot1
	end
end

function slot0.RefreshUI(slot0, slot1, slot2)
	slot0.userID = slot1
	slot0.type = slot2

	if not DormitoryData:GetTemplateExhibitList(slot0.type)[slot0.userID] then
		Debug.LogError("未获取到参观信息")

		return
	end

	slot0.headiconImg_.sprite = ItemTools.getItemSprite(slot3.icon)

	slot0.headiconImg_:SetNativeSize()

	slot0.nickName.text = slot3.nick

	if BackHomeCfg[slot3.architecture_id].type == DormConst.BACKHOME_TYPE.PublicDorm then
		slot0.dormName.text = GetTips("DORM_LOBBY_NAME")
	else
		slot0.dormName.text = string.format(GetTips("DORM_HERO_ROOM_NAME"), HeroRecordCfg[HeroRecordCfg.get_id_list_by_hero_id[slot3.heroIDList[1]][1]].name)
	end

	slot0.levelNum.text = slot3.level
	slot0.furTotalNum.text = math.max(slot3.furniture_num - 2, 0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
