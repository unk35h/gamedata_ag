return {
	CreatTips = function (slot0, slot1)
		if BulletinData.GetCacheStringIsShowByID(slot1) == false then
			BulletinData.CreatTips(slot0, slot1)
			BulletinData.SetCacheStringIsShowByID(slot1)
			BulletinData.CreateTimer()
		end
	end,
	CreatTipsWithoutTimer = function (slot0, slot1)
		if BulletinData.GetCacheStringIsShowByID(slot1) == false then
			BulletinData.CreatTips(slot0, slot1)
			BulletinData.SetCacheStringIsShowByID(slot1)
		end
	end,
	TryToCreatTips = function ()
		if BulletinData.GetCachePop() == true and BulletinData.GetIslogin() then
			slot0, slot1 = BulletinData.GetCurCacheStringAndID()

			if slot0 then
				BulletinData.SetCachePop(false)
				uv0.CreatTips(slot0, slot1)
			end
		end
	end,
	CreatTipsWithoutCount = function (slot0, slot1)
		BulletinData.CreatTips(slot0, slot1)
	end
}
