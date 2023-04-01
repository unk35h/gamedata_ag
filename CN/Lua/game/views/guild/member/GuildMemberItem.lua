slot0 = class("GuildMemberItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.controller_ = ControllerUtil.GetController(slot0.transformPost_, "conName")
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		ForeignInfoAction:TryToCheckForeignDetailInfo(uv0.id_)
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.id_ = slot1
	slot3 = GuildData:GetGuildMemberData(slot1)
	slot0.imageIcon_.sprite = ItemTools.getItemSprite(slot3.icon)
	slot0.imageHeadBg_.sprite = ItemTools.getItemSprite(slot3.frame)
	slot0.textName_.text = slot3.name
	slot0.textLevel_.text = GetTips("LEVEL") .. string.format("%s", slot3.level)

	if slot2 then
		slot0.textContribute_.text = slot3.weekContribute
	else
		slot0.textContribute_.text = slot3.contribute
	end

	if slot3.offlineStamptime == 0 then
		slot0.textOnline_.text = string.format("<color=#6AA788>%s</color>", manager.time:GetOnLineText(slot3.offlineStamptime))
	else
		slot0.textOnline_.text = string.format("<color=#494A4F>%s</color>", manager.time:GetOnLineText(slot3.offlineStamptime))
	end

	slot0.controller_:SetSelectedState(slot3.post)
	print(slot3.post)

	if slot3.post == GuildConst.GUILD_POST.CAPTAIN then
		slot0.labelText_.text = GetTips("CLUB_CHAIR_MAN")
	elseif slot3.post == GuildConst.GUILD_POST.DEPUTY then
		slot0.labelText_.text = GetTips("CLUB_VICE_CHAIR_MAN")
	elseif slot3.post == GuildConst.GUILD_POST.MEMBER then
		slot0.labelText_.text = GetTips("CLUB_MEMBER")
	elseif slot3.post == GuildConst.GUILD_POST.TRAINEE then
		slot0.labelText_.text = GetTips("CLUB_NOVICIATE")
	end
end

return slot0
