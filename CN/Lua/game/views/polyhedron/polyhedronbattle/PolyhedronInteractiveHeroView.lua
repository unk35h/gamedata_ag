slot1 = class("PolyhedronInteractiveHeroView", import("game.views.polyhedron.polyhedronBattle.PolyhedronInteractiveView"))

function slot1.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_btn, nil, function ()
		if PolyhedronConst.REWARD_TYEP.TEAMMATE == uv0.polyhedronInfo:GetRewardType() then
			slot2 = uv0.enlistHero.heroId

			if PolyhedronConst.ENLIST_TYPE.PAY == uv0.enlistHero.enlist_type and uv0.polyhedronInfo:GetCoinCount() < PolyhedronHeroCfg[slot2].need_coin then
				ShowTips("POLYHEDRON_INTERACTIVE_HERO_FAIL")

				return
			end

			PolyhedronAction.QueryEnlistHero(uv0.enlistHero)
		else
			DoPolyhedronNextTrigger()
		end
	end)
end

function slot1.RefreshUI(slot0)
	slot0.polyhedronInfo = PolyhedronData:GetPolyhedronInfo()
	slot0.enlistHeroList = slot0.polyhedronInfo:GetEnlistHeroList()
	slot0.enlistHero = slot0.enlistHeroList[slot0.index]

	if slot0.enlistHero then
		slot2 = slot0.enlistHero.heroId

		if PolyhedronConst.ENLIST_TYPE.BATTLE == slot0.enlistHero.enlist_type then
			slot0.m_des.text = GetTips("POLYHEDRON_INTERACTIVE_HERO_DES_1")
			slot0.m_btnLab.text = GetTips("POLYHEDRON_INTERACTIVE_HERO_TITLE_1")
		elseif PolyhedronConst.ENLIST_TYPE.PAY == slot1 then
			slot4 = PolyhedronHeroCfg[slot2].need_coin
			slot6 = slot4

			if slot0.polyhedronInfo:GetCoinCount() < slot4 then
				slot6 = string.format("<color=#F63D2F>%s</color>", slot4)
			end

			slot0.m_des.text = string.format(GetTips("POLYHEDRON_INTERACTIVE_HERO_DES_2"), slot6)
			slot0.m_btnLab.text = GetTips("POLYHEDRON_INTERACTIVE_HERO_TITLE_2")
		else
			slot0.m_des.text = GetTips("POLYHEDRON_INTERACTIVE_HERO_DES_3")
			slot0.m_btnLab.text = GetTips("POLYHEDRON_INTERACTIVE_HERO_TITLE_3")
		end
	else
		slot0.m_des.text = "error"
		slot0.m_btnLab.text = ""
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_desTrs)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_contentTrs)
end

return slot1
