IlluMusicInfoItem = import("game.views.IllustratedHandleBook.IlluMusic.IlluMusicInfoItem")
slot0 = class("VolumeMusicMainItem", IlluMusicInfoItem)

function slot0.InitUI(slot0)
	uv0.super.InitUI(slot0)
	slot0.m_animator:Play("detail_item_off", -1, 1)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_btn, nil, function ()
		if uv0.clickFunc2 then
			uv0.clickFunc2(uv0.index)
		end
	end)
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc2 = slot1
end

function slot0.UpdateAnima(slot0, slot1)
	if slot1 == slot0.index then
		slot0.m_animator:Play("detail_item_off", -1, 0)
	else
		slot0.m_animator:Play("detail_item_off", -1, 1)
	end
end

return slot0
