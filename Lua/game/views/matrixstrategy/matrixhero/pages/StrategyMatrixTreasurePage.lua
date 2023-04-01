slot0 = class("StrategyMatrixTreasurePage", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.handler_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.m_list, MatrixTreasureAtlasItem)
end

function slot0.SetMatirxHeroInfo(slot0, slot1, slot2)
	slot0.matrix_activity_id = slot1
	slot0.data = slot0:GetArtifactList()

	table.sort(slot0.data, function (slot0, slot1)
		if MatrixItemCfg[slot0.id].rare ~= MatrixItemCfg[slot1.id].rare then
			return slot3.rare < slot2.rare
		end

		return slot0.id < slot1.id
	end)
	slot0.list_:StartScroll(#slot0.data)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:Refresh(slot0.data[slot1].id, slot0.data[slot1].wins)
end

function slot0.Hide(slot0)
	SetActive(slot0.gameObject_, false)
end

function slot0.Show(slot0)
	SetActive(slot0.gameObject_, true)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	slot0.handler_ = nil

	slot0.list_:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.GetArtifactList(slot0)
	return StrategyMatrixData:GetArtifactList(slot0.matrix_activity_id)
end

return slot0
