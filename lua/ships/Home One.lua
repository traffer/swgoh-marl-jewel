--gg.setVisible(false)

print("Home One")

gg.clearResults()
gg.setRanges(gg.REGION_ANONYMOUS | gg.REGION_C_BSS)

gg.searchNumber("144;5064;13718::100", gg.TYPE_QWORD)

local size = 3
local cnt = gg.getResultCount()
if cnt>0 and cnt%size == 0 then
	print(">>> Found", cnt, "results.")
	local r = gg.getResults(cnt)
	for i=0, cnt/size-1 do
		r[1+i*size].value = 1500 -- speed
		r[2+i*size].value = 94000 -- physical damage
		r[3+i*size].value = 94000 -- special damage
	end
	gg.setValues(r)
	print(">>> Done.")
else
	print("!!! Strange number of results: ", cnt)
end