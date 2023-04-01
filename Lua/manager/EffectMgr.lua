slot0 = class("EffectMgr")

function slot0.Ctor(slot0)
	slot0:OnCtor()
end

function slot0.OnCtor(slot0)
	print("Initialize Effect Mgr")

	slot0._callback = {}
	slot0._effectMap = {}
	slot0._material = nil
end

function slot0.LoadEffect(slot0, slot1, slot2, slot3)
	if slot0._effectMap["effect/" .. slot1] then
		if slot3 then
			slot3()
		end

		return
	end

	if slot0._callback[slot4] then
		table.insert(slot0._callback[slot4], {
			callback = slot3
		})
	elseif slot2 == true then
		slot0._callback[slot4] = {
			{
				callback = slot3
			}
		}
		slot0._effectMap[slot4] = Object.Instantiate(Asset.Load("Effect/" .. slot1))
		slot8 = false

		SetActive(slot0._effectMap[slot4], slot8)

		for slot8, slot9 in pairs(slot0._callback[slot4]) do
			if slot9.callback then
				slot9.callback()
			end
		end

		slot0._callback[slot4] = nil
	else
		slot0.effectMap[slot4] = Object.Instantiate(Asset.Load("Effect/" .. slot1))

		SetActive(slot0._effectMap[slot4], false)

		if slot3 then
			slot3()
		end
	end
end

function slot0.PlayUIEffect(slot0, slot1, slot2, slot3, slot4)
	if not slot0._effectMap["effect/" .. slot1] then
		print(string.format("警告：<color=#ff0000>%s</color>特效未预加载", slot5))
		slot0:LoadEffect(slot1, false, function ()
		end)
	end

	slot6 = Object.Instantiate(slot0._effectMap[slot5], slot2.transform)
	slot6.transform.localPosition = Vector3(0, 0, 0)

	SetActive(slot6, true)

	if slot6:GetComponent("DftAniEvent") == nil then
		slot7 = slot6:AddComponent(typeof(DftAniEvent))
	end

	if slot3 then
		slot7:AddEndEvent(function (slot0)
			if uv0 then
				uv0()
			end

			UnityEngine.Object.Destroy(uv1)
		end)
	else
		slot7:AddEndEvent(function (slot0)
			if uv0 then
				uv0()
			end
		end)
	end

	return slot6
end

function slot0.PlayEffect(slot0, slot1, slot2, slot3, slot4, slot5)
	if not slot0._effectMap["effect/" .. slot1] then
		print(string.format("警告：<color=#ff0000>%s</color>特效未预加载", slot6))
		slot0:LoadEffect(slot1, false, function ()
		end)
	end

	Object.Instantiate(slot0._effectMap[slot6]).transform.localPosition = slot2 or Vector3(0, 0, 0)
	slot7.transform.localEulerAngles = slot3 or Vector3(0, 0, 0)

	SetActive(slot7, true)

	if slot7:GetComponent("ParticleSystemEvent") == nil then
		slot8 = slot7:AddComponent(typeof(ParticleSystemEvent))
	end

	if slot4 then
		slot8:SetEndEvent(function (slot0)
			if uv0 then
				uv0()
			end

			UnityEngine.Object.Destroy(uv1)
		end)
	else
		slot8:SetEndEvent(function (slot0)
			if uv0 then
				uv0()
			end

			SetActive(slot0, false)
		end)
	end

	return slot7
end

function slot0.SpriteEffect(slot0, slot1)
	if not slot0._effectMap["effect/" .. slot1] then
		print(string.format("警告：<color=#ff0000>%s</color>特效未预加载", slot2))
		slot0:LoadEffect(slot1, false, function ()
		end)
	end

	slot3 = Object.Instantiate(slot0._effectMap[slot2])

	SetActive(slot3, true)

	return slot3
end

function slot0.UnloadEffect(slot0, slot1)
	if slot0._effectMap["effect/" .. slot1] then
		Object.Destroy(slot0._effectMap[slot2])
	end

	slot0._effectMap[slot2] = nil
end

function slot0.UnloadAllEffect(slot0)
	for slot4, slot5 in pairs(slot0._effectMap) do
		Object.Destroy(slot0._effectMap[slot4])

		slot0._effectMap[slot4] = nil
	end

	slot0._effectMap = {}

	if slot0._material then
		Object.Destroy(slot0._material)

		slot0._material = nil
	end
end

function slot0.SetGrey(slot0, slot1, slot2)
	if slot2 then
		if slot0._material == nil then
			slot0._material = Object.Instantiate(Asset.Load("UI/Materials"))
		end

		slot1.material = slot0._material.transform:Find("grey"):GetComponent("SpriteRenderer").material
	else
		slot1.material = nil
	end
end

function slot0.SetNoise(slot0, slot1, slot2)
	if slot2 then
		if slot0._material == nil then
			slot0._material = Object.Instantiate(Asset.Load("UI/Materials"))
		end

		slot1.material = slot0._material.transform:Find("noise"):GetComponent("SpriteRenderer").material
	else
		slot1.material = nil
	end
end

function slot0.GetMat(slot0, slot1)
	if slot0._material == nil then
		slot0._material = Object.Instantiate(Asset.Load("UI/Materials"))
	end

	return slot0._material.transform:Find(slot1):GetComponent("SpriteRenderer").material
end

return slot0
