slot0 = class("CommonItem", ReduxView)
slot1 = import("game.const.ItemConst")
slot2 = import("game.const.HeroConst")
slot3 = import("game.tools.MailTools")
CLICK_MODE = {
	LONG = 2,
	SINGLE = 1
}

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	slot0.data_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform
	slot0.info_ = slot3

	slot0:InitUI()
	slot0:Init()
end

function slot0.ResetTransform(slot0)
	slot0.transform_.localPosition = Vector3(0, 0, 0)
	slot0.transform_.localScale = Vector3(1, 1, 1)
	slot0.transform_.localEulerAngles = Vector3.New(0, 0, 0)
end

function slot0.RefreshData(slot0, slot1, slot2)
	slot0.data_ = slot1
	slot0.info_ = slot2

	slot0:Render()
end

function slot0.InitUI(slot0)
	slot0.bg_ = slot0:FindCom(typeof(Image), "panel/main/bg")
	slot0.icon_ = slot0:FindCom(typeof(Image), "panel/main/mask/icon")
	slot0.num_ = slot0:FindCom(typeof(Text), "panel/main/type/num")
	slot0.equipPos_ = slot0:FindCom(typeof(Image), "panel/main/type/pos")
	slot0.heroRace_ = slot0:FindCom(typeof(Image), "panel/main/type/group")
	slot0.equipPosGo_ = slot0:FindGo("panel/main/type/pos")
	slot0.heroRaceGo_ = slot0:FindGo("panel/main/type/group")
	slot0.itemIconGo_ = slot0:FindGo("panel/main/type/article")
	slot0.lvText_ = slot0:FindGo("panel/main/type/num/lv")
	slot0.heroRareGo_ = slot0:FindGo("panel/main/type/herorare")
	slot0.heroRare_ = slot0:FindCom(typeof(Image), "panel/main/type/herorare")
	slot0.name_ = slot0:FindCom(typeof(Text), "panel/main/name")
	slot0.nameGo_ = slot0:FindGo("panel/main/name")
	slot0.backGo_ = slot0:FindGo("panel/main/back")
	slot0.type_ = slot0:FindGo("panel/main/type")
	slot0.equiping_ = slot0:FindGo("panel/main/equiping")
	slot0.equipingText_ = slot0:FindCom(typeof(Text), "panel/main/equiping/text")
	slot0.lockGo_ = slot0:FindGo("panel/main/lock")
	slot0.new_ = slot0:FindGo("panel/main/new")
	slot0.starbg_ = slot0:FindGo("panel/main/starbg")
	slot0.starBgSize_ = slot0.starbg_.transform.sizeDelta
	slot0.rankAll_ = slot0:FindGo("panel/main/rank")
	slot0.rankNull_ = slot0:FindGo("panel/main/rank/null")
	slot4 = "panel/main/rank/nonull"
	slot0.rankNoNull_ = slot0:FindGo(slot4)
	slot0.rankGo_ = {}
	slot0.rank_ = {}

	for slot4 = 1, 4 do
		slot0.rankGo_[slot4] = slot0:FindGo("panel/main/rank/nonull/icon" .. slot4)
		slot0.rank_[slot4] = slot0:FindCom(typeof(Image), "panel/main/rank/nonull/icon" .. slot4)
	end

	slot0.mainGo_ = slot0:FindGo("panel/main")
	slot0.unloadGo_ = slot0:FindGo("panel/unload")
	slot0.equipSelectGo_ = slot0:FindGo("panel/main/equipselect")
	slot0.itemSelectGo_ = slot0:FindGo("panel/main/itemselect")
	slot0.selectNum_ = slot0:FindCom(typeof(Text), "panel/main/itemselect/num")
	slot0.clickBtn_ = slot0:FindCom(typeof(Button), "")
	slot0.clickImg_ = slot0:FindCom(typeof(Image), "")

	slot0:AddBtnListener("", nil, function ()
		if uv0.clickMode_ == CLICK_MODE.SINGLE and uv0.clickFunc then
			uv0.clickFunc(uv0.info_)
		end
	end)

	slot0.longClickBtn_ = slot0:FindGo("panel/main/longclick")

	slot0:AddPressingByTimeListener(slot0.longClickBtn_, 3, 0.5, 0.2, function ()
		if uv0.clickLongFunc and uv0.clickMode_ == CLICK_MODE.LONG then
			return uv0.clickLongFunc(uv0.info_)
		end

		return false
	end)
	slot0:AddPressingByTimeListener(slot0:FindGo("panel/main/itemselect/btn_del"), 3, 0.5, 0.2, function ()
		if uv0.clickCutFunc then
			return uv0.clickCutFunc(uv0.info_)
		end

		return false
	end)
end

function slot0.Init(slot0)
	slot0.clickMode_ = CLICK_MODE.SINGLE

	slot0:RefreshUI(slot0.info_)
end

function slot0.Render(slot0)
	slot0:RefreshUI(slot0.info_)
end

function slot0.RefreshUI(slot0, slot1)
	if slot1 then
		if slot1.id == 0 then
			SetActive(slot0.unloadGo_, true)
			SetActive(slot0.mainGo_, false)

			return
		end

		if uv0.ITEM_TYPE.EQUIP == ItemCfg[slot1.id].type and slot1.id == 0 then
			SetActive(slot0.unloadGo_, true)
			SetActive(slot0.mainGo_, false)

			return
		else
			SetActive(slot0.unloadGo_, false)
			SetActive(slot0.mainGo_, true)
		end

		slot0:UpdateRareBg()
		slot0:UpdateIcon()
		slot0:UpdateName()
		slot0:UpdateType(slot3)
		slot0:UpdateRank(slot3)

		if slot1.number then
			slot0:SetBottomText(slot1.number)
		end

		if uv0.ITEM_TYPE.EQUIP == slot3 and uv0.ITEM_TYPE.EQUIP == slot3 and slot1.equip_lv then
			slot0.num_.text = string.format("%d", slot1.equip_lv)
		end

		if uv0.ITEM_TYPE.HERO == slot3 then
			SetActive(slot0.heroRareGo_, true)

			slot0.heroRare_.sprite = getSprite("Atlas/NewBag", "icon_rolelist_rare_" .. ItemCfg[slot1.id].rare)

			slot0.heroRare_:SetNativeSize()

			slot0.num_.text = ""

			SetActive(slot0.heroRareGo_, false)
		end

		slot0:UpdateStar(slot3, slot1.equip_star or slot1.star or getItemStar(slot1.id))
	end
end

function slot0.UpdateRareBg(slot0)
	slot0.bg_.sprite = getSprite("Atlas/NewBag", "board_article_character_" .. ItemCfg[slot0.info_.id].rare)
end

function slot0.SwitchToBigRareBg(slot0)
	slot0.bg_.sprite = getSprite("Atlas/NewBattleSettlement", "board_article_character_" .. ItemCfg[slot0.info_.id].rare)
end

function slot0.UpdateIcon(slot0)
	slot0.icon_.sprite = ItemTools.getItemSprite(slot0.info_.id)

	slot0.icon_:SetNativeSize()
end

function slot0.UpdateName(slot0)
	slot0.name_.text = ItemCfg[slot0.info_.id].name
end

function slot0.UpdateType(slot0, slot1)
	slot2 = false
	slot3 = false
	slot4 = false
	slot5 = false

	if uv0.ITEM_TYPE.CURRENCY == slot1 or uv0.ITEM_TYPE.MATERIAL == slot1 then
		slot4 = true
	elseif uv0.ITEM_TYPE.HERO_PIECE == slot1 then
		slot4 = true
	elseif uv0.ITEM_TYPE.EQUIP == slot1 then
		slot2 = true
		slot5 = true
		slot0.equipPos_.sprite = getSprite("Atlas/NewCommon", "icon_article_yj_location_" .. EquipCfg[slot0.info_.id].pos)
	elseif uv0.ITEM_TYPE.HERO == slot1 then
		slot3 = true
		slot0.heroRace_.sprite = getSprite("Atlas/NewBag", "icon_group_" .. HeroCfg[slot0.info_.id].race .. "_c")
	else
		slot4 = true
	end

	SetActive(slot0.equipPosGo_, slot2)
	SetActive(slot0.heroRaceGo_, slot3)
	SetActive(slot0.itemIconGo_, slot4)
	SetActive(slot0.lvText_, slot5)
end

function slot0.UpdateStar(slot0, slot1, slot2)
	if uv0.ITEM_TYPE.HERO == slot1 then
		SetActive(slot0.starbg_, false)
	elseif uv0.ITEM_TYPE.EQUIP == slot1 then
		SetActive(slot0.starbg_, true)

		slot0.starbg_.transform.sizeDelta = Vector2(slot0.starBgSize_.x * slot2, slot0.starBgSize_.y)
	else
		SetActive(slot0.starbg_, false)
	end
end

function slot0.UpdateRank(slot0, slot1)
	slot2 = false

	if slot1 == uv0.ITEM_TYPE.EQUIP then
		slot2 = true
		slot3 = 0

		if slot0.info_.equip_info then
			slot3 = slot0.info_.equip_info.now_break_level
		end

		SetActive(slot0.rankNull_, EquipCfg[slot0.info_.id].break_times_max == 0)
		SetActive(slot0.rankNoNull_, slot4.break_times_max ~= 0)

		if slot4.break_times_max ~= 0 then
			if slot3 == 0 then
				slot2 = false
			else
				slot2 = true

				for slot8 = 1, 4 do
					slot9 = slot8 <= slot4.break_times_max

					SetActive(slot0.rankGo_[slot8], slot9)

					if slot9 then
						if slot8 <= slot3 then
							slot0.rank_[slot8].color = Color.New(0.3843, 0.4313, 0.4509, 0.9)
						else
							slot0.rank_[slot8].color = Color.New(0.3843, 0.4313, 0.4509, 0.4)
						end
					end
				end
			end
		else
			slot2 = false
		end
	else
		slot2 = false
	end

	SetActive(slot0.rankAll_, slot2)
end

function slot0.ShowEquiping(slot0, slot1, slot2)
	SetActive(slot0.equiping_, slot1)

	if slot2 then
		slot0.equipingText_.text = String.format(GetTips("SERVANT_EQUIPED"), slot2)
	else
		slot0.equipingText_.text = ""
	end
end

function slot0.ShowLock(slot0, slot1)
	SetActive(slot0.lockGo_, slot1)
end

function slot0.ShowNew(slot0, slot1)
	SetActive(slot0.new_, slot1)
end

function slot0.SetBottomText(slot0, slot1)
	slot0.num_.text = slot1
end

function slot0.SetIndex(slot0, slot1)
	slot0.transform_:SetSiblingIndex(slot1)
end

function slot0.ShowName(slot0, slot1)
	SetActive(slot0.nameGo_, slot1)
end

function slot0.ShowBlackBack(slot0, slot1)
	SetActive(slot0.backGo_, slot1)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	if slot0.starbg_ ~= nil then
		slot0.starbg_.transform.sizeDelta = slot0.starBgSize_
		slot0.starbg_ = nil
	end

	slot0.info_ = nil
	slot0.clickFunc = nil

	uv0.super.Dispose(slot0)
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickMode_ = CLICK_MODE.SINGLE
	slot0.clickFunc = slot1

	SetActive(slot0.longClickBtn_, false)

	slot0.clickBtn_.enabled = true
	slot0.clickImg_.enabled = true
end

function slot0.RegistLongCallBack(slot0, slot1)
	slot0.clickMode_ = CLICK_MODE.LONG
	slot0.clickLongFunc = slot1

	SetActive(slot0.longClickBtn_, true)

	slot0.clickBtn_.enabled = false
	slot0.clickImg_.enabled = false
end

function slot0.RegistCutCallBack(slot0, slot1)
	slot0.clickCutFunc = slot1
end

function slot0.GetItemInfo(slot0)
	return slot0.info_
end

function slot0.ShowSelect(slot0, slot1)
	if slot1 > 0 then
		if uv0.ITEM_TYPE.EQUIP == ItemCfg[slot0.info_.id].type then
			SetActive(slot0.itemSelectGo_, false)
			SetActive(slot0.equipSelectGo_, true)
		else
			SetActive(slot0.itemSelectGo_, true)
			SetActive(slot0.equipSelectGo_, false)

			slot0.selectNum_.text = "x" .. slot1
		end
	else
		SetActive(slot0.equipSelectGo_, false)
		SetActive(slot0.itemSelectGo_, false)
		slot0:StopLongClickTimer()
	end
end

function slot0.HideNum(slot0)
	slot0.num_.text = ""
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

return slot0
