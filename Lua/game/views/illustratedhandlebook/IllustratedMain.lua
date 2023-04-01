slot0 = class("ChessHome", ReduxView)

function slot0.UIName(slot0)
	return "UI/IllustratedHandbook/IlluEntranceUI"
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
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.informationbtnBtn_, nil, function ()
		uv0:Go("/illuInformation")
	end)
	slot0:AddBtnListener(slot0.enemybtnBtn_, nil, function ()
		IllustratedAction.SetIlluRedPoint(RedPointConst.ILUU_ENEMY)
		uv0:Go("/illuEnemyFiles")
	end)
	slot0:AddBtnListener(slot0.equipbtnBtn_, nil, function ()
		uv0:Go("/illuEquipManual")
	end)
	slot0:AddBtnListener(slot0.servantbtnBtn_, nil, function ()
		uv0:Go("/illuServantManual")
	end)
	slot0:AddBtnListener(slot0.worldbtnBtn_, nil, function ()
		IllustratedAction.SetIlluRedPoint(RedPointConst.ILLU_WORLDVIEW)
		uv0:Go("/illuWorldView")
	end)
	slot0:AddBtnListener(slot0.plotbtnBtn_, nil, function ()
		uv0:Go("/illuPlot")
	end)
	slot0:AddBtnListener(slot0.illustrationbtnBtn_, nil, function ()
		uv0:Go("/illuIllustration")
	end)
	slot0:AddBtnListener(slot0.heroBtn_, nil, function ()
		JumpTools.OpenPageByJump("/heroPreviewMain", {
			isEnter = true
		})
	end)
	slot0:AddBtnListener(slot0.musicBtn_, nil, function ()
		JumpTools.OpenPageByJump("/illuMusic", {
			isEnter = true
		})
	end)
end

function slot0.OnEnter(slot0)
	slot0:ShowDefaultBar()

	for slot4 = 1, 7 do
		slot0:RefreshRate(slot4)
	end

	manager.redPoint:bindUIandKey(slot0.enemybtnBtn_.transform, RedPointConst.ILUU_ENEMY)
	manager.redPoint:bindUIandKey(slot0.worldbtnBtn_.transform, RedPointConst.ILLU_WORLDVIEW)
	manager.redPoint:bindUIandKey(slot0.illustrationbtnBtn_.transform, RedPointConst.ILLU_ILLUSTRATION)
end

function slot0.GetStoryLen(slot0)
	slot1 = 0

	for slot5, slot6 in pairs(StoryCfg) do
		if slot6.trigger[2] then
			slot1 = slot1 + 1
		end
	end

	return slot1
end

function slot0.RefreshRate(slot0, slot1)
	slot2 = 0.5
	slot3, slot4 = nil

	if slot1 == 1 then
		slot0.informationrateImg_.fillAmount = slot2
		slot0.informaiontextText_.text = slot2 * 100 .. "%"
	elseif slot1 == 2 then
		slot2 = table.length(IllustratedData:GetEnemyInfo()) / #CollectMonsterCfg.all
		slot0.enemyrateImg_.fillAmount = slot2
		slot0.enemytextText_.text = string.format("%d%%", slot2 * 100)
	elseif slot1 == 3 then
		slot3 = 0
		slot5 = IllustratedData:GetServantInfo()

		for slot9, slot10 in ipairs(WeaponServantCfg.all) do
			slot11 = slot5[slot10]

			if not ServantTools.GetIsHide(slot10) and (slot11 or WeaponServantCfg[slot10].display_type ~= 1) then
				slot3 = slot3 + 1
			end
		end

		slot2 = table.length(slot5) / slot3
		slot0.servantrateImg_.fillAmount = slot2
		slot0.servanttextText_.text = string.format("%d%%", slot2 * 100)
	elseif slot1 == 4 then
		slot2 = IlluTools.GetEquipAll() / (EquipTools.GetSuitTotalNum() * 6)
		slot0.equiprateImg_.fillAmount = slot2
		slot0.equiptextText_.text = string.format("%d%%", slot2 * 100)
	elseif slot1 == 5 then
		slot2 = table.length(IllustratedData:GetPlotInfo()) / slot0:GetStoryLen()
		slot0.plotrateImg_.fillAmount = slot2
		slot0.plottextText_.text = string.format("%d%%", slot2 * 100)
	elseif slot1 == 6 then
		slot2 = table.length(IllustratedData:GetIllustrationInfo()) / #CollectPictureCfg.all
		slot0.illurateImg_.fillAmount = slot2
		slot0.illutextText_.text = string.format("%d%%", slot2 * 100)
	elseif slot1 == 7 then
		slot2 = table.length(IllustratedData:GetAffixInfo()) / #CollectWordCfg.all
		slot0.worldrateImg_.fillAmount = slot2
		slot0.worldtextText_.text = string.format("%d%%", slot2 * 100)
	end
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	manager.redPoint:unbindUIandKey(slot0.enemybtnBtn_.transform, RedPointConst.ILUU_ENEMY)
	manager.redPoint:unbindUIandKey(slot0.worldbtnBtn_.transform, RedPointConst.ILLU_WORLDVIEW)
	manager.redPoint:unbindUIandKey(slot0.illustrationbtnBtn_.transform, RedPointConst.ILLU_ILLUSTRATION)
	manager.gc:Collect()
	Resources.UnloadUnusedAssets()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
