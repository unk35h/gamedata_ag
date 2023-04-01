slot1 = RandomUtil.GenRandom(os.time())
slot2 = os.time()

return {
	RandomSeed = function (slot0)
		uv0 = slot0
		uv1 = RandomUtil.GenRandom(slot0)
	end,
	GetRandomSeed = function ()
		return uv0
	end,
	Random = function (slot0, slot1)
		slot2 = nil
		slot2 = (slot0 ~= nil or slot1 ~= nil or uv0:NextDouble()) and (slot1 == nil and 1 + uv0:NextInt(slot0) or slot0 + uv0:NextInt(slot1 - slot0 + 1))

		if MathRandomFlag == false then
			print("<color=#ff0000>渲染帧请使用math.random()产生随机数</color>" .. " source:" .. debug.getinfo(2, "nfS").source, debug.traceback("", 2))
		end

		return slot2
	end
}
