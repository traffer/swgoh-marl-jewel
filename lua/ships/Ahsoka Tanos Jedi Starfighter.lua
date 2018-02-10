--gg.setVisible(false)

print("Ahsoka Tano's Jedi Starfighter")

gg.clearResults()
gg.setRanges(gg.REGION_ANONYMOUS | gg.REGION_C_BSS)

gg.searchNumber("46184;155;7920::100", gg.TYPE_QWORD)

local size = 3
local cnt = gg.getResultCount()
if cnt > 0 and cnt%size == 0 then
	print(">>> Found", cnt, "results.")
	local r = gg.getResults(cnt)
	for i=0, cnt/size-1 do
		r[2+i*size].value = 10000 -- speed
		r[3+i*size].value = 500000 -- physical offense
	end
	gg.setValues(r)
	print(">>> Done.")
else
	print("!!! Strange number of results: ", cnt)
end
