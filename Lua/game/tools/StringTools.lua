slot0 = require("cjson")

function wordSplit(slot0)
	slot1 = {}
	slot5 = "[-\\xc2-\\xf4][\\x80-\\xbf]*"

	for slot5 in slot0:gmatch(slot5) do
		slot1[#slot1 + 1] = slot5
	end

	return slot1
end

slot1 = "-"
slot2 = "."

function encodeUID(slot0)
	if tonumber(slot0) == nil then
		return ""
	end

	slot2 = ""

	while slot1 > 0 do
		slot3 = slot1 % 10
		slot4 = ""

		for slot8 = 3, 0, -1 do
			if math.floor(slot3 / 2^slot8) == 0 then
				slot4 = slot4 .. uv0
			elseif slot9 == 1 then
				slot4 = slot4 .. uv1
			end

			slot3 = slot3 % 2^slot8
		end

		slot2 = slot4 .. slot2
		slot1 = math.floor(slot1 / 10)
	end

	return slot2
end

slot3 = 0

function WordVerifyBySDK(slot0, slot1, slot2)
	slot4, slot5 = wordVerify(string.gsub(slot0, " ", ""))

	if string.match(slot0, "<.+>.*</.+>") ~= nil then
		slot1(not slot6)

		return
	end

	slot7 = slot4 <= 0

	if GameToSDK.CURRENT_SDK_ID == SDK_PLATFORM.DEV then
		slot8 = slot7 and ChatConst.VERIFY_STATUS.PASS or ChatConst.VERIFY_STATUS.NO_PASS

		SendJudgeResult(slot2, slot0, slot8, "")
		slot1(slot7, slot8)

		return
	end

	if not slot7 then
		SendJudgeResult(slot2, slot0, ChatConst.VERIFY_STATUS.NO_PASS, "")
		slot1(slot7, ChatConst.VERIFY_STATUS.NO_PASS)

		return
	end

	slot8 = uv0.encode({
		messageType = "CheckText",
		text = slot3
	})

	if uv1 == 0 then
		SetForceShowQuanquan(true)
	end

	uv1 = uv1 + 1

	SendMessageToSDKWithCallBack(slot8, "CheckTextResult", function (slot0)
		slot1 = slot0.code
		slot2 = slot0.code == ChatConst.VERIFY_STATUS.PASS or slot0.code == ChatConst.VERIFY_STATUS.OBSERVE

		print("callbackInfo.code", slot0.code)
		print("callbackInfo.respInfo", slot0.respInfo)
		print("callbackInfo.extraData", slot0.extraData)

		if slot0.code == ChatConst.VERIFY_STATUS.ERROR then
			slot2 = uv0
			slot1 = ChatConst.VERIFY_STATUS.OBSERVE
		end

		uv1 = uv1 - 1

		if uv1 == 0 then
			SetForceShowQuanquan(false)
		end

		SendJudgeResult(uv2, uv3, slot1, slot0.respInfo or "")
		uv4(slot2, slot1)
	end)
end

function SendJudgeResult(slot0, slot1, slot2, slot3)
	if slot0 then
		SDKAction.SendMessageToSDK("shield_log", {
			type = slot0,
			content = slot1,
			shield_type = slot2,
			report_json = slot3 or ""
		})
	end
end

function wordVerMatch(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	if slot3 > #slot0 then
		return slot5, slot6, slot7
	end

	slot8 = slot0[slot3]
	slot9 = nil

	for slot13, slot14 in ipairs(slot1) do
		if slot9 then
			table.deepMerge(slot9, slot14[slot8] or {})
		else
			slot9 = slot9 or slot14[slot8]
		end
	end

	if slot9 then
		if slot9.result then
			if slot2.isReplace then
				return wordVerMatch(slot0, {
					slot9
				}, slot2, slot3 + 1, slot4 .. slot2.replaceWord, true, slot3 + 1, slot4 .. slot2.replaceWord)
			else
				return wordVerMatch(slot0, {
					slot9
				}, slot2, slot3 + 1, slot4, true, slot3 + 1, slot4)
			end
		elseif slot2.isReplace then
			return wordVerMatch(slot0, {
				slot9
			}, slot2, slot3 + 1, slot4 .. slot2.replaceWord, slot5, slot6, slot7)
		else
			return wordVerMatch(slot0, {
				slot9
			}, slot2, slot3 + 1, slot4, slot5, slot6, slot7)
		end
	else
		return slot5, slot6, slot7
	end
end

function isContainChineseNumEnglish(slot0)
	slot1 = 1

	while slot1 <= #slot0 do
		if string.byte(slot0, slot1) >= 48 and slot2 <= 57 or slot2 >= 65 and slot2 <= 90 or slot2 >= 97 and slot2 <= 122 then
			slot1 = slot1 + 1
		else
			if #slot0 - slot1 <= 1 then
				return false
			end

			slot6 = 15318693

			if 14989440 > string.byte(slot0, slot1 + 2) + string.byte(slot0, slot1 + 1) * 256 + slot2 * 65536 or slot6 < slot7 then
				return false
			else
				slot1 = slot1 + 3
			end
		end
	end

	return true
end

function textLimit(slot0, slot1)
	slot2 = 1
	slot3 = 0

	while slot2 <= #slot0 do
		slot4 = 0
		slot10 = slot2
		slot6 = 0

		for slot10 = 0, getByteLength(string.byte(slot0, slot10)) - 1 do
			slot6 = slot6 * 256 + string.byte(slot0, slot2 + slot10)
		end

		if slot1 < slot3 + (isNumOrEn(slot6) and 1 or isChinese(slot6) and 2 or isJanpanese(slot6) and 2 or 1) then
			return string.sub(slot0, 1, slot2 - 1), false
		end

		slot2 = slot2 + slot5
		slot3 = slot3 + slot4
	end

	return slot0, true
end

function getByteLength(slot0)
	if slot0 >= 0 and slot0 <= 127 then
		return 1
	elseif slot0 >= 192 and slot0 <= 223 then
		return 2
	elseif slot0 >= 224 and slot0 <= 239 then
		return 3
	elseif slot0 >= 240 and slot0 <= 247 then
		return 4
	else
		print("不是一个字符开头！")
	end
end

function isNumOrEn(slot0)
	return slot0 >= 48 and slot0 <= 57 or slot0 >= 65 and slot0 <= 90 or slot0 >= 97 and slot0 <= 122
end

function isFullNumOrEn(slot0)
	return isNumOrEn(slot0 - 65248)
end

function isMars()
end

function isChinese(slot0)
	return 14989440 <= slot0 and slot0 <= 15318693
end

function isEnglish(slot0)
	return slot0 >= 65 and slot0 <= 90 or slot0 >= 97 and slot0 <= 122
end

function isJanpanese(slot0)
	return 14909825 <= slot0 and slot0 <= 14910399 or 14911408 <= slot0 and slot0 <= 14911423
end

function isKorean(slot0)
	return 15380608 <= slot0 and slot0 <= 15572655 or 14779520 <= slot0 and slot0 <= 14780303 or 14910640 <= slot0 and slot0 <= 14911119
end

function isSymbol(slot0)
	return 14909568 <= slot0 and slot0 <= 14909631 or 15711360 <= slot0 and slot0 <= 15712175 or 14844032 <= slot0 and slot0 <= 14844335 or 32 <= slot0 and slot0 <= 127 or 49824 <= slot0 and slot0 <= 50111 or slot0 >= 48 and slot0 <= 57 or slot0 >= 65 and slot0 <= 90 or slot0 >= 97 and slot0 <= 122
end

function nameRule(slot0, slot1)
	if AreaDifferenceCfg[GameToSDK.CURRENT_SERVER] then
		slot4 = 1

		while slot4 <= #slot0 do
			slot10 = slot4
			slot6 = 0

			for slot10 = 0, getByteLength(string.byte(slot0, slot10)) - 1 do
				slot6 = slot6 * 256 + string.byte(slot0, slot4 + slot10)
			end

			slot7 = false
			slot8 = slot3.language_sent

			if isChinese(slot6) then
				slot7 = table.indexof(slot8, 0) ~= false
			elseif isJanpanese(slot6) then
				slot7 = table.indexof(slot8, 1) ~= false
			elseif isEnglish(slot6) then
				slot7 = table.indexof(slot8, 2) ~= false
			elseif isKorean(slot6) then
				slot7 = table.indexof(slot8, 3) ~= false
			elseif slot6 >= 48 and slot6 <= 57 then
				slot7 = true
			elseif slot1 then
				slot7 = isSymbol(slot6)
			end

			if not slot7 then
				return false
			end

			slot4 = slot4 + slot5
		end

		return true
	else
		print("未定义命名规则 area = ", slot2)

		return false
	end
end

function filterEgyUnicode(slot0)
	return string.gsub(string.gsub(slot0, "\\xf0\\x93[\\x80-\\x8f][\\x80-\\xbf]", ""), "\\xf0\\x93\\x90[\\x80-\\xaf]", "")
end

function wordVerify(slot0, slot1)
	slot1 = slot1 or {}

	if #filterEgyUnicode(slot0) ~= #slot0 then
		if slot1.isReplace then
			slot0 = slot2
		else
			return 1
		end
	end

	slot4 = {
		WordVerifyCfg,
		WordVerifyCfg2,
		WordVerifyCfg3,
		WordVerifyCfg4,
		WordVerifyCfg5,
		WordVerifyCfg6,
		WordVerifyCfg7,
		WordVerifyCfg8,
		WordVerifyCfg9,
		WordVerifyCfg10
	}
	slot1.isReplace = slot1.isReplace or false
	slot1.replaceWord = slot1.replaceWord or "*"
	slot5 = #wordSplit(slot0)
	slot6 = 1
	slot7 = ""
	slot8 = 0

	while slot6 <= slot5 do
		slot9, slot10, slot11 = wordVerMatch(slot3, slot4, slot1, slot6, "", false, slot6, "")

		if slot9 then
			slot6 = slot10
			slot8 = slot8 + 1

			if slot1.isReplace then
				slot7 = slot7 .. slot11
			end
		else
			if slot1.isReplace then
				slot7 = slot7 .. slot3[slot6]
			end

			slot6 = slot6 + 1
		end
	end

	if slot1.isReplace then
		return slot8, slot7
	else
		return slot8
	end
end

function shortenString(slot0, slot1)
	slot2 = 0
	slot3 = 0
	slot4 = 0
	slot5 = #slot0

	while slot2 < slot5 do
		slot7 = 1

		if string.byte(slot0, slot2 + 1) < 128 then
			slot2 = slot2 + 1
		elseif slot6 >= 192 and slot6 < 224 then
			slot2 = slot2 + 2
		elseif slot6 >= 224 and slot6 < 240 then
			slot2 = slot2 + 3
		elseif slot6 >= 240 and slot6 < 248 then
			slot2 = slot2 + 4
		elseif slot6 >= 248 and slot6 < 252 then
			slot2 = slot2 + 5
		elseif slot6 >= 252 and slot6 < 254 then
			slot2 = slot2 + 6
		else
			error("invalid utf8 string")
		end

		if slot1 <= slot3 + slot7 then
			slot4 = slot2

			break
		end
	end

	if slot4 == 0 or slot4 == slot5 then
		return slot0
	end

	return string.sub(slot0, 1, slot4) .. ".."
end

function fixColor(slot0, slot1)
	return "<color=" .. slot1 .. ">" .. slot0 .. "</color>"
end

function strrchr(slot0, slot1)
	slot4, slot5 = string.find(string.reverse(slot0), string.reverse(slot1))

	if slot4 then
		return #slot0 - slot5 + 1, #slot0 - slot4 + 1
	else
		return 0, 0
	end
end

function IsAllSpace(slot0)
	slot1, slot2 = string.find(slot0, "%s*")

	return slot1 == 1 and slot2 == string.len(slot0)
end

function StringCount(slot0)
	if not slot0 or type(slot0) ~= "string" or #slot0 <= 0 then
		return nil
	end

	slot1 = 0
	slot2 = 1

	while true do
		slot4 = 1
		slot1 = slot1 + 1

		if slot2 + (string.byte(slot0, slot2) > 239 and 4 or slot3 > 223 and 3 or slot3 > 128 and 2 or 1) > #slot0 then
			break
		end
	end

	return slot1
end

function ExStringCount(slot0)
	if not slot0 or type(slot0) ~= "string" or #slot0 <= 0 then
		return nil
	end

	slot1 = 0
	slot2 = 1

	while true do
		slot4 = 1

		if string.byte(slot0, slot2) > 239 then
			slot4 = 4
			slot1 = slot1 + 2
		elseif slot3 > 223 then
			slot4 = 3
			slot1 = slot1 + 2
		elseif slot3 > 128 then
			slot4 = 2
			slot1 = slot1 + 1
		else
			slot4 = 1
			slot1 = slot1 + 1
		end

		if slot2 + slot4 > #slot0 then
			break
		end
	end

	return slot1
end

function replaceSensitiveWordAll(slot0, slot1)
	slot2 = slot0
	slot3 = replaceSensitiveWord(slot0, slot1)

	while slot2 ~= slot3 do
		slot2 = slot3
		slot3 = replaceSensitiveWord(slot3, slot1)
	end

	return slot3
end

function replaceSensitiveWord(slot0, slot1)
	slot2 = slot0
	slot3, slot4 = string.find(slot0, slot1, 1, true)

	if slot3 and slot4 then
		slot5 = string.len(slot0)
		slot7 = ""

		for slot11 = 1, getWordCount(slot1) do
			slot7 = slot7 .. "*"
		end

		slot2 = slot3 == 1 and slot7 .. string.sub(slot0, slot4 + 1, -1) or slot4 == slot5 and string.sub(slot0, 1, slot3 - 1) .. slot7 or string.sub(slot0, 1, slot3 - 1) .. slot7 .. string.sub(slot0, slot4 + 1, -1)
	end

	return slot2
end

function getWordCount(slot0)
	slot1, slot2 = string.gsub(slot0, "[^\\x80-\\xc1]", "")

	return slot2
end

symbolTable = {
	"！",
	"（",
	"）",
	"，",
	"．",
	"：",
	"；",
	"？"
}

function containSymbol(slot0)
	if not (string.find(slot0, "%p") ~= nil) then
		for slot6, slot7 in ipairs(wordSplit(slot0)) do
			if table.keyof(symbolTable, slot7) then
				return true
			end
		end
	end

	return slot1
end

function getWordTable(slot0)
	function slot1(slot0)
		for slot5 = #{
			0,
			192,
			224,
			240
		}, 1, -1 do
			if slot1[slot5] <= slot0 then
				return slot5
			end
		end

		return 1
	end

	slot2 = {}
	slot3 = 1
	slot4 = 0

	while slot3 <= string.len(slot0) do
		slot5 = slot1(string.byte(slot0, slot3))

		table.insert(slot2, string.sub(slot0, slot3, slot3 + slot5 - 1))

		slot3 = slot3 + slot5
	end

	return slot2
end

function dealEnter(slot0)
	if not slot0.transform:GetComponent("InputField") then
		print("缺少组件！！！")
	end

	slot2 = slot1.onValueChanged

	slot2:AddListener(function (slot0)
		uv0.text = string.gsub(slot0, "\n", "")
	end)
end

function chsize(slot0)
	if not slot0 then
		return 0
	elseif slot0 > 240 then
		return 4
	elseif slot0 > 225 then
		return 3
	elseif slot0 > 192 then
		return 2
	else
		return 1
	end
end

function utf8sub(slot0, slot1, slot2)
	slot3 = 1

	while slot1 > 1 do
		slot3 = slot3 + chsize(string.byte(slot0, slot3))
		slot1 = slot1 - 1
	end

	slot4 = slot3

	while slot2 > 0 and slot4 <= #slot0 do
		slot4 = slot4 + chsize(string.byte(slot0, slot4))
		slot2 = slot2 - 1
	end

	return slot0.sub(slot0, slot3, slot4 - 1), slot2
end

function utf8len(slot0)
	slot1 = 0
	slot2 = 1

	while slot2 <= #slot0 do
		slot2 = slot2 + chsize(string.byte(slot0, slot2))
		slot1 = slot1 + 1
	end

	return slot1
end
