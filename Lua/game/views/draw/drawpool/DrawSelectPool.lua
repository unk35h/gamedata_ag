slot0 = class("DrawSelectPool", DrawBasePool)

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = Object.Instantiate(Asset.Load("UI/Draw/PoolUI/pool_select"), slot1)
	slot0.transform_ = slot0.gameObject_.transform
	slot0.poolId = slot2
	slot0.showId = slot3
	slot0.detailBtnList_ = {}
	slot0.btnNameList_ = {}

	slot0:Init()
end

function slot0.InitUI(slot0)
	uv0.super.InitUI(slot0)

	slot0.firstController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "first")
	slot0.campController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "camp")
	slot0.limitController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "limit")
end

function slot0.AddUIListener(slot0)
	uv0.super.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.detailBtn_, nil, function ()
		slot0 = DrawPoolCfg[uv0.poolId]

		JumpTools.OpenPageByJump("/heroPreviewMain", {
			isEnter = true,
			hid = slot0.optional_detail[table.indexof(slot0.optional_lists, uv0.showId)]
		})
	end)

	if slot0.m_changeBtn then
		slot0:AddBtnListener(slot0.m_changeBtn, nil, function ()
			slot1 = DrawData:GetPoolUpTimes(uv0.poolId)

			if DrawPoolCfg[uv0.poolId].pool_change == 0 or slot1 < slot0 then
				slot2 = DrawPoolCfg[uv0.poolId]

				uv0:Go("/drawAllHeroSelect", {
					poolId = uv0.poolId,
					heroIdList = slot2.optional_detail,
					heroId = slot2.optional_detail[table.indexof(slot2.optional_lists, uv0.showId)]
				})
			else
				ShowTips("DRAW_LACK_UP_TIMES")
			end
		end)
	end
end

function slot0.Refresh(slot0, slot1)
	uv0.super.Refresh(slot0, slot1)

	slot0.showId = slot1
	slot2 = DrawPoolCfg[slot0.poolId]
	slot5 = HeroCfg[slot2.optional_detail[table.indexof(slot2.optional_lists, slot1)]]

	if slot0.m_changeCount then
		if DrawPoolCfg[slot0.poolId].pool_change == 0 then
			slot0.m_changeCount.text = ""
		else
			slot0.m_changeCount.text = string.format(GetTips("DRAW_REMAIN_UP_TIMES"), tostring(slot6 - DrawData:GetPoolUpTimes(slot0.poolId)))
		end
	end

	slot0.nameText_.text = string.format("%s·%s", slot5.name, slot5.suffix)
	slot0.starImage_.sprite = getSpriteWithoutAtlas(string.format("Textures/Rare/%d", slot5.rare))

	slot0.campController_:SetSelectedState(tostring(slot5.race))

	slot0.pic_.sprite = getSpriteWithoutAtlas(string.format("Textures/Character/Portrait/%d", slot4))

	slot0.pic_:SetNativeSize()

	if slot2.pool_change == 0 then
		slot0.limitController_:SetSelectedState("false")
	else
		slot0.limitController_:SetSelectedState("true")

		slot0.countText_.text = DrawData:GetUpRemainTime(slot0.poolId)
	end

	TimeTools.StartAfterSeconds(0.1, function ()
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.nameContainer_)
	end, {})
end

return slot0
