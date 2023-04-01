slot0 = class("ResourcesPool")
ASSET_TYPE = {
	WEAPON = 3,
	TPOSE = 1,
	SCENE = 2
}
MAX_TMP_NUM = {
	[ASSET_TYPE.TPOSE] = 5,
	[ASSET_TYPE.SCENE] = 2,
	[ASSET_TYPE.WEAPON] = 3
}
MAX_TMP_NUM_DONT_DESTROY = {
	[ASSET_TYPE.TPOSE] = 4
}

function slot0.Ctor(slot0)
	slot0.assetsPool_ = {}
	slot0.asyncIndex_ = 0
	slot0.asyncIndexQueue_ = {}
	slot0.asyncLoadAssetInfo_ = {}

	for slot4, slot5 in pairs(ASSET_TYPE) do
		slot0.assetsPool_[slot5] = {}
	end
end

function slot0.GetPooledAsset(slot0, slot1, slot2)
	slot0.assetsPool_[slot2] = slot0.assetsPool_[slot2] or {}

	for slot6, slot7 in ipairs(slot0.assetsPool_[slot2]) do
		if slot7.name == slot1 and not slot7.use then
			slot7.use = true

			slot0:MoveResourceToEnd(slot0.assetsPool_[slot2], slot6)

			return slot7, slot6
		end
	end
end

function slot0.MoveResourceToEnd(slot0, slot1, slot2)
	if slot1[slot2] then
		table.insert(slot1, slot1[slot2])
		table.remove(slot1, slot2)
	end
end

function slot0.AsyncLoad(slot0, slot1, slot2, slot3)
	if slot0:GetPooledAsset(slot1, slot2) then
		SetActive(slot4.go, true)
		slot3(slot4.go)

		return
	end

	table.insert(slot0.asyncIndexQueue_, slot0.asyncIndex_)

	if slot0.asyncLoadAssetInfo_[slot1] then
		slot0.asyncLoadAssetInfo_[slot1][slot5] = slot3
	else
		slot0.asyncLoadAssetInfo_[slot1] = {
			[slot5] = slot3
		}

		Asset.LoadAsync(slot1, function (slot0)
			slot1 = 0
			slot5 = uv1

			for slot5, slot6 in pairs(uv0.asyncLoadAssetInfo_[slot5]) do
				if table.keyof(uv0.asyncIndexQueue_, slot5) then
					slot1 = slot1 + 1

					table.remove(uv0.asyncIndexQueue_, slot7)
				else
					uv0.asyncLoadAssetInfo_[uv1][slot5] = nil
				end
			end

			if slot1 == 0 then
				uv0.asyncLoadAssetInfo_[uv1] = nil

				return
			end

			table.insert(uv0.assetsPool_[uv2], {
				use = true,
				name = uv1,
				go = Asset.Instantiate(uv1)
			})

			if MAX_TMP_NUM[uv2] < #uv0.assetsPool_[uv2] then
				uv0:DestroyNoUse(uv2, slot3 - MAX_TMP_NUM[uv2])
			end

			slot7 = uv1

			for slot7, slot8 in pairs(uv0.asyncLoadAssetInfo_[slot7]) do
				slot8(slot2)
			end

			uv0.asyncLoadAssetInfo_[uv1] = nil
		end)
	end

	slot0.asyncIndex_ = slot5 + 1

	return slot5
end

function slot0.StopAsyncQuest(slot0, slot1)
	if slot1 == nil then
		return
	end

	if table.keyof(slot0.asyncIndexQueue_, slot1) then
		table.remove(slot0.asyncIndexQueue_, slot2)
	end
end

function slot0.Get(slot0, slot1, slot2)
	if slot0:GetPooledAsset(slot1, slot2) then
		if slot2 == ASSET_TYPE.TPOSE then
			slot0:ResetBlendShapes(slot3.go)
		end

		SetActive(slot3.go, true)

		return slot3.go
	end

	slot0.assetsPool_[slot2] = slot0.assetsPool_[slot2] or {}

	table.insert(slot0.assetsPool_[slot2], {
		use = true,
		name = slot1,
		go = Asset.Instantiate(slot1)
	})

	if slot2 == ASSET_TYPE.TPOSE then
		slot0:ResetBlendShapes(slot4)
	end

	return slot4
end

function slot0.DestroyOrReturn(slot0, slot1, slot2)
	if not slot0.assetsPool_[slot2] then
		Object.DestroyImmediate(slot1)

		return
	end

	slot0:ResetBlendShapes(slot1)
	SetActive(slot1, false)

	for slot7 = #slot0.assetsPool_[slot2], 1, -1 do
		if slot0.assetsPool_[slot2][slot7].go == slot1 then
			slot0.assetsPool_[slot2][slot7].use = false
		end
	end

	if MAX_TMP_NUM[slot2] < slot3 then
		slot0:DestroyNoUse(slot2, slot3 - MAX_TMP_NUM[slot2])
	end
end

function slot0.DestroyNoUse(slot0, slot1, slot2)
	slot3 = slot2 or 1

	if slot0.assetsPool_[slot1] then
		slot5 = {}

		for slot9 = 1, #slot0.assetsPool_[slot1] do
			if not slot0.assetsPool_[slot1][slot9].use then
				if slot3 > 0 then
					table.insert(slot5, slot9)
				end

				slot3 = slot3 - 1
			end
		end

		for slot9 = #slot5, 1, -1 do
			slot10 = slot0.assetsPool_[slot1][slot5[slot9]]

			Object.DestroyImmediate(slot10.go)
			Asset.Unload(slot10.name)
			manager.gc:Collect()
			Resources.UnloadUnusedAssets()
			table.remove(slot0.assetsPool_[slot1], slot5[slot9])
		end
	end
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.assetsPool_) do
		for slot9, slot10 in ipairs(slot5) do
			Object.Destroy(slot10.go)
		end
	end

	slot0.assetsPool_ = {}

	for slot4, slot5 in pairs(ASSET_TYPE) do
		slot0.assetsPool_[slot5] = {}
	end
end

function slot0.ResetBlendShapes(slot0, slot1)
	slot7 = UnityEngine.Transform
	slot2 = slot1:GetComponentsInChildren(typeof(slot7), true)
	slot3 = nil
	slot8 = slot2

	for slot7, slot8 in pairs(slot2.ToTable(slot8)) do
		if slot8:GetComponent(typeof(Animator)) then
			slot3 = slot9
			slot9.enabled = false

			break
		end
	end

	slot8 = slot2

	for slot7, slot8 in pairs(slot2.ToTable(slot8)) do
		if slot8.name == "face" and slot8:GetComponent(typeof(UnityEngine.SkinnedMeshRenderer)) then
			for slot15 = 0, slot9.sharedMesh.blendShapeCount - 1 do
				slot9:SetBlendShapeWeight(slot15, 0)
			end
		end
	end

	if slot3 then
		slot3.enabled = true
	end
end

return slot0
