slot0 = class("MatrixOverHeroAstrolabeItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.astrolabeID and uv0.astrolabeID ~= 0 then
			slot0 = uv0.transform_.position

			manager.matrixPop:ShowMatrixPopItem(uv0.astrolabeID, Vector3(-0.45, slot0.y + 0.1, slot0.z), nil, uv0.heroId)
		end
	end)
end

function slot0.Refresh(slot0, slot1, slot2)
	slot0.heroId = slot2
	slot0.astrolabeID = slot1 or 0

	if slot1 and slot1 ~= 0 then
		slot0.icon_.sprite = MatrixTools.GetMatrixItemSprite(slot1)

		SetActive(slot0.gameObject_, true)
	else
		SetActive(slot0.gameObject_, false)
	end
end

return slot0
