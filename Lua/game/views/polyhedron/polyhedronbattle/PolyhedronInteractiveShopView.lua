slot1 = class("PolyhedronInteractiveShopView", import("game.views.polyhedron.polyhedronBattle.PolyhedronInteractiveView"))

function slot1.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_btn, nil, function ()
		JumpTools.OpenPageByJump("polyhedronBattle/polyhedronShop")
	end)
end

function slot1.RefreshUI(slot0)
	slot0.m_des.text = GetTips("POLYHEDRON_INTERACTIVE_SHOP_DES")
	slot0.m_btnLab.text = GetTips("POLYHEDRON_INTERACTIVE_SHOP_TITLE")

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_desTrs)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_contentTrs)
end

return slot1
