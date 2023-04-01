slot0 = LuaProfiler
slot1 = debug
slot2 = {}
slot3 = 0

function slot4(slot0, slot1)
	if uv0.getinfo(2, "Sn").what ~= "Lua" then
		return
	end

	if (slot2.name or "[unknown]") == "lua_profiler_attach" or slot3 == "lua_profiler_detach" then
		return
	end

	slot8 = uv1[slot2.short_src .. ":" .. slot2.linedefined .. ":" .. slot2.lastlinedefined]

	if slot0 == "call" then
		if not slot8 then
			uv2.BeginSample(uv3, slot3 .. ":" .. slot4 .. ":" .. slot6)

			uv1[slot7] = uv3
			uv3 = uv3 + 1
		else
			uv2.BeginSample(slot8)
		end
	elseif slot0 == "return" or slot0 == "tail return" then
		uv2.EndSample()
	end
end

function lua_profiler_attach()
	uv0.sethook(uv1, "cr", 0)
end

function lua_profiler_detach()
	uv0.sethook()

	uv1 = {}

	uv2.Clear()
end
