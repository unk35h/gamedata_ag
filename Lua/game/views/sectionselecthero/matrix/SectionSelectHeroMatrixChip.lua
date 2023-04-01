slot0 = class("SectionSelectHeroMatrixChip", import("..SectionSelectHeroChip"))

function slot0.AddListener(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0:GetChipManagerID() ~= 0 then
			uv0:Go("/chipMatrixManager")
		end
	end)
end

function slot0.GetChipManagerID(slot0)
	return MatrixData:GetChipManagerID()
end

function slot0.GetChipList(slot0)
	return MatrixData:GetChipList()
end

return slot0
