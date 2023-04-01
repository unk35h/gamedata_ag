slot0 = class("MatrixHeroEquipPage", ReduxView)

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

	slot0.list_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.m_list, MatrixHeroEquipItem)
end

function slot0.SetMatirxHeroInfo(slot0, slot1)
	slot0.heroId_ = slot1
	slot0.equipListData_ = slot0:GetHeroData(slot1):GetEquipList()

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot1 = #slot0.equipListData_

	slot0.list_:StartScroll(slot1)

	slot0.m_countLab.text = slot1 .. "/" .. slot0:GetHeroEquipMaxCount()
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:Refresh(slot0.equipListData_[slot1])
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

function slot0.GetHeroData(slot0, slot1)
	return MatrixData:GetHeroData(slot1)
end

function slot0.GetHeroEquipMaxCount(slot0)
	return MatrixData:GetHeroEquipMaxCount()
end

return slot0
