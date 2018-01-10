print(">> Fixing Chief Chirpa 5% ...")

gg.clearResults()
gg.setRanges (gg.REGION_ANONYMOUS)

gg.searchNumber("7228;96;606", gg.TYPE_QWORD)

local size = 3
local cnt = gg.getResultCount()
if cnt%size == 0 then
	local r = gg.getResults(cnt)
	for i=0, cnt/size-1 do
		r[2+i*size].value = 2000 -- speed
		r[3+i*size].value = 90000 -- basic damage
	end
	gg.setValues(r)
	print("Done.")
else
	print("Strange number of results: ", cnt)
end
