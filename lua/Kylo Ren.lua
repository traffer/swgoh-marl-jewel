--gg.setVisible(false)

print("Kylo Ren 5%")

gg.clearResults()
gg.setRanges(gg.REGION_ANONYMOUS | gg.REGION_C_BSS)

gg.searchNumber("17414;116;1949;9235::384", gg.TYPE_QWORD)

local size = 4
local cnt = gg.getResultCount()
if cnt > 0 and cnt%size == 0 then
	print(">>> Found", cnt, "results.")
	local r = gg.getResults(cnt)
	for i=0, cnt/size-1 do
		r[1+i*size].value = 100000 -- health
		r[2+i*size].value = 10000 -- speed
		r[3+i*size].value = 500000 -- physical damage
		r[4+i*size].value = 200000 -- protection
	end
	gg.setValues(r)
	print(">>> Done.")
else
	print("!!! Strange number of results: ", cnt)
end
