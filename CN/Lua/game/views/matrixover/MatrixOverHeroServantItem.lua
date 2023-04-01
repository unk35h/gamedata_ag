slot0 = class("MatrixOverHeroServantItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.matrixServantID and uv0.matrixServantID ~= 0 then
			slot0 = uv0.transform_.position

			manager.matrixPop:ShowMatrixPopItem(uv0.matrixServantID, Vector3(-0.45, slot0.y + 0.1, slot0.z))
		end
	end)
end

function slot0.Refresh(slot0, slot1)
	slot0.matrixServantID = slot1

	if slot1 ~= 0 then
		slot0.icon_.sprite = MatrixTools.GetMatrixItemSprite(slot1)

		SetActive(slot0.mask_, true)
	else
		SetActive(slot0.mask_, false)
	end
end

return slot0
