slot0 = class("MatrixOverBeaconItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		slot0 = uv0.transform_.position

		manager.matrixPop:ShowMatrixBeaconPopItem(uv0.id, Vector3(-0.8, slot0.y + 0.1, slot0.z))
	end)
end

function slot0.Refresh(slot0, slot1)
	slot0.id = slot1
	slot0.icon_.sprite = getSpriteWithoutAtlas("Textures/MatrixItem/MatrixArtifact/" .. MatrixBeaconCfg[slot1].icon)
end

return slot0
