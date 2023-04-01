slot1 = manager.net

slot1:Bind(30017, function (slot0)
	LetterData.LetterInit(slot0)
	uv0.UpdateLettersRedPoint()
end)

return {
	TryToCheckLetter = function (slot0)
		manager.net:SendWithLoadingNew(30018, {
			id = slot0
		}, 30019, uv0.OnCheckLetter)
	end,
	OnCheckLetter = function (slot0)
	end,
	SortLetters = function ()
		LetterData.SortLetters()
	end,
	ReadLetter = function (slot0)
		uv0.TryToCheckLetter(slot0)
		LetterData.CacheReadFlag(slot0)
	end,
	UpdateLettersRedPoint = function ()
		for slot4, slot5 in pairs(LetterData.GetLetters()) do
			uv0.UpdateLetterRedPoint(slot4)
		end
	end,
	UpdateLetterRedPoint = function (slot0)
		manager.redPoint:setTip(RedPointConst.LETTER_ID .. slot0, LetterData.GetLetter(slot0).isViewed and 0 or 1)
	end
}
