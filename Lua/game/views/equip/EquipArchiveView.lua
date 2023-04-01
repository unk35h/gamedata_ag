slot0 = class("EquipArchiveView", ReduxView)

function slot0.UIName(slot0)
	return "UI/IllustratedHandbook/IlluEquipDetailUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.controllers_ = {}

	for slot4 = 1, 6 do
		slot0.controllers_[slot4] = ControllerUtil.GetController(slot0["item" .. slot4 .. "Go_"].transform, "conName")
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.gainBtn_, nil, function ()
		ShowPopItemSource(0, 0, uv0.id_)
	end)
end

function slot0.OnEnter(slot0)
	slot0:ShowDefaultBar()

	slot0.id_ = slot0.params_.equipID
	slot1 = EquipSuitCfg[slot0.id_]
	slot0.nameText_.text = slot1.name
	slot0.descText_.text = EquipTools.GetEffectDesc(slot1.suit_effect[1])
	slot0.imageImg_.sprite = getSpriteWithoutAtlas("Textures/Equip/Portrait/" .. EquipSuitCfg[slot0.id_].icon)
	slot0.backgroundText_.text = slot1.desc

	if IllustratedData:GetEquipInfo()[slot0.id_] then
		for slot6 = 1, 6 do
			if slot2.pos_list[slot6] == 1 then
				slot0.controllers_[slot6]:SetSelectedState("0")
			else
				slot0.controllers_[slot6]:SetSelectedState("1")
			end
		end
	else
		for slot6 = 1, 6 do
			slot0.controllers_[slot6]:SetSelectedState("1")
		end
	end
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
