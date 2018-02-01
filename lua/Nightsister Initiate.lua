--gg.setVisible(false)

print("Nightsister Initiate 10%")

gg.clearResults()
gg.setRanges(gg.REGION_ANONYMOUS | gg.REGION_C_BSS)

gg.searchNumber("9590;109;851::100", gg.TYPE_QWORD)

local size = 3
local cnt = gg.getResultCount()
if cnt > 0 and cnt%size == 0 then
	print(">>> Found", cnt, "results.")
	local r = gg.getResults(cnt)
	for i=0, cnt/size-1 do
		r[1+i*size].value = 100000 -- health
		r[2+i*size].value = 10000 -- speed
		r[3+i*size].value = 500000 -- physical damage
	end
	gg.setValues(r)
	print(">>> Done.")
else
	print("!!! Strange number of results: ", cnt)
end
