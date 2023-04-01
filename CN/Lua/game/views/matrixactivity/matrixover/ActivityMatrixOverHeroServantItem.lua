slot1 = class("ActivityMatrixOverHeroServantItem", import("game.views.matrixOver.MatrixOverHeroServantItem"))

function slot1.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.matrixServantID and uv0.matrixServantID ~= 0 then
			slot0 = uv0.transform_.position

			manager.matrixPop:ShowMatrixPopItem(uv0.matrixServantID, Vector3(-0.45, slot0.y + 0.1, slot0.z), nil, , uv0.matrix_activity_id)
		end
	end)
end

function slot1.SetMatrixActivityId(slot0, slot1)
	slot0.matrix_activity_id = slot1
end

return slot1
