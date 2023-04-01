slot0 = class("AstrolabeEffectItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	slot0.data_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform
	slot0.info_ = slot3

	slot0:InitUI()
	slot0:Init()
end

function slot0.RefreshData(slot0, slot1, slot2)
	slot0.data_ = slot1
	slot0.info_ = slot2

	slot0:Render()
end

function slot0.InitUI(slot0)
	slot0.topBg_ = slot0:FindCom(typeof(Image), "top/bg")
	slot0.arrow_ = slot0:FindCom(typeof(Image), "top/arrow")
	slot4 = typeof(Text)
	slot0.name_ = slot0:FindCom(slot4, "top/name")
	slot0.pos_ = {}

	for slot4 = 1, 3 do
		slot0.pos_[slot4] = slot0:FindCom(typeof(Image), "top/pos" .. slot4)
	end

	slot0.desTipBg_ = {}
	slot0.desTipGo_ = {}
	slot0.desTip_ = {}
	slot0.des_ = {}
	slot0.desGo_ = {}
	slot0.desTrs_ = {}

	for slot4 = 1, 3 do
		slot0.desTipBg_[slot4] = slot0:FindCom(typeof(Image), "textpanel/image" .. slot4)
		slot0.desTipGo_[slot4] = slot0:FindGo("textpanel/image" .. slot4)
		slot0.desTip_[slot4] = slot0:FindCom(typeof(Text), "textpanel/image" .. slot4 .. "/effecttext")
		slot0.des_[slot4] = slot0:FindCom(typeof(Text), "textpanel/des" .. slot4)
		slot0.desGo_[slot4] = slot0:FindGo("textpanel/des" .. slot4)
		slot0.desTrs_[slot4] = slot0:FindCom(typeof(RectTransform), "textpanel/des" .. slot4)
	end

	slot0.textPanelTrs_ = slot0:FindCom(typeof(RectTransform), "textpanel")
	slot0.trs_ = slot0:FindCom(typeof(RectTransform), "")

	slot0:AddBtnListener(nil, , "OnClick")
end

function slot0.Render(slot0)
	slot0:RefreshUI(slot0.info_)
end

function slot0.RefreshUI(slot0, slot1)
	if slot1 then
		slot0.name_.text = HeroAstrolabeCfg[HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[slot1.id][1]].suit_name
		slot4 = 5
		slot0.topBg_.color = HeroConst.RARE_COLOR[slot4]
		slot0.arrow_.color = HeroConst.RARE_COLOR[slot4]
		slot5 = slot1.num

		for slot9 = 1, 3 do
			if slot9 <= slot5 then
				slot10 = slot0.pos_[slot9].color
				slot0.pos_[slot9].color = Color.New(slot10.r, slot10.g, slot10.b, 1)
			else
				slot10 = slot0.pos_[slot9].color
				slot0.pos_[slot9].color = Color.New(slot10.r, slot10.g, slot10.b, 0.3)
			end
		end

		for slot9 = 1, 3 do
			if slot5 < slot9 then
				SetActive(slot0.desTipGo_[slot9], false)
				SetActive(slot0.desGo_[slot9], false)

				slot0.desTipBg_[slot9].color = Color.New(slot0.desTipBg_[slot9].color.r, slot0.desTipBg_[slot9].color.g, slot0.desTipBg_[slot9].color.b, 0.5)
				slot0.desTip_[slot9].color = Color.New(slot0.desTip_[slot9].color.r, slot0.desTip_[slot9].color.g, slot0.desTip_[slot9].color.b, 0.5)
				slot0.des_[slot9].color = Color.New(slot0.des_[slot9].color.r, slot0.des_[slot9].color.g, slot0.des_[slot9].color.b, 0.5)
			else
				SetActive(slot0.desTipGo_[slot9], true)
				SetActive(slot0.desGo_[slot9], true)

				slot0.desTipBg_[slot9].color = Color.New(slot0.desTipBg_[slot9].color.r, slot0.desTipBg_[slot9].color.g, slot0.desTipBg_[slot9].color.b, 0.86)
				slot0.desTip_[slot9].color = Color.New(slot0.desTip_[slot9].color.r, slot0.desTip_[slot9].color.g, slot0.desTip_[slot9].color.b, 1)
				slot0.des_[slot9].color = Color.New(slot0.des_[slot9].color.r, slot0.des_[slot9].color.g, slot0.des_[slot9].color.b, 1)
			end
		end

		for slot9 = 1, 3 do
			slot0.des_[slot9].text = "　　" .. SkillTools.GetAstrolabeDesc(slot2[slot9])
		end

		slot0.isOpen_ = false

		slot0:RefreshLayout()
	end
end

function slot0.RefreshLayout(slot0)
	for slot4 = 1, 3 do
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.desTrs_[slot4])
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.textPanelTrs_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.trs_)
end

function slot0.ChangeOpenType(slot0, slot1)
	if slot0.isOpen_ == slot1 then
		return
	end

	slot0.isOpen_ = slot1
	slot2 = #slot0.info_.pos

	for slot6 = 1, 3 do
		if slot2 < slot6 then
			SetActive(slot0.desTipGo_[slot6], slot1)
			SetActive(slot0.desGo_[slot6], slot1)
		end
	end

	slot0:RefreshLayout()
end

function slot0.Init(slot0)
	slot0:RefreshUI(slot0.info_)
end

function slot0.Dispose(slot0)
	slot0.clickFunc = nil

	uv0.super.Dispose(slot0)
end

function slot0.OnClick(slot0)
	if slot0.clickFunc then
		slot0.clickFunc(slot0.info_)
	end
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

function slot0.GetItemInfo(slot0)
	return slot0.info_
end

function slot0.ShowSelect(slot0, slot1)
	SetActive(slot0.select_, slot1)
end

return slot0
