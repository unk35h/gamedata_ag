slot0 = class("IlluIllustrationItem", ReduxView)

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

	slot0.controller_ = ControllerUtil.GetController(slot0.gameObject_.transform, "conName")
	slot0.giftCon_ = ControllerUtil.GetController(slot0.gameObject_.transform, "gift")
	slot0.haveCon_ = ControllerUtil.GetController(slot0.gameObject_.transform, "have")
	slot0.selectCon_ = ControllerUtil.GetController(slot0.gameObject_.transform, "select")
	slot0.multitCon_ = ControllerUtil.GetController(slot0.gameObject_.transform, "multi")
end

function slot0.RefreshUI(slot0, slot1, slot2)
	slot0.id_ = slot1.id
	slot0.type_ = CollectPictureCfg[slot1.id].type

	if slot0.type_ == 1 then
		slot0.controller_:SetSelectedState("item")

		slot0.itemiconImg_.sprite = getSpriteWithoutAtlas(SpritePathCfg.CollectPictureSmall.path .. CollectPictureCfg[slot1.id].picture)
	else
		slot0.controller_:SetSelectedState("role")

		slot0.roleiconImg_.sprite = getSpriteWithoutAtlas(SpritePathCfg.CollectPictureSmall.path .. CollectPictureCfg[slot1.id].picture)
	end

	slot0.have_ = IllustratedData:GetIllustrationInfo()[slot0.id_]

	if slot0.have_ then
		if not slot2 then
			slot4 = 1

			for slot8, slot9 in ipairs(CollectPictureCfg.get_id_list_by_group_id[CollectPictureCfg[slot0.id_].group_id]) do
				if IllustratedData:GetIllustrationInfo()[slot9] and slot10.is_receive == 0 then
					slot4 = 0

					break
				end
			end

			if slot4 == 1 then
				slot0.giftCon_:SetSelectedState("notShow")
			else
				slot0.giftCon_:SetSelectedState("show")
			end
		else
			slot0.giftCon_:SetSelectedState("notShow")
		end

		slot0.haveCon_:SetSelectedState("1")

		slot0.itemBtn_.interactable = true
	else
		slot0.haveCon_:SetSelectedState("0")

		slot0.itemBtn_.interactable = false
	end

	slot3 = CollectPictureCfg[slot0.id_]
	slot0.nameText_.text = slot3.name

	slot0.multitCon_:SetSelectedState(#(CollectPictureCfg.get_id_list_by_group_id[slot3.group_id] or {}) > 1 and not slot2 and "true" or "false")
end

function slot0.SetSelect(slot0, slot1)
	slot0.selectCon_:SetSelectedState(slot1 and "true" or "false")
end

function slot0.RegisterGiftFunc(slot0, slot1)
	slot0.registerGiftFunc_ = slot1
end

function slot0.RegisterItemFunc(slot0, slot1)
	slot0.itemClickFunc_ = slot1
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.itemBtn_, nil, function ()
		if uv0.itemClickFunc_ then
			uv0.itemClickFunc_(uv0.id_)
		end
	end)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		if uv0.registerGiftFunc_ then
			uv0.registerGiftFunc_()
		end
	end)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
