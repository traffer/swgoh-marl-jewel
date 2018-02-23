--gg.setVisible(false)

print("Grand Admiral Thrawn 5%")

gg.clearResults()
gg.setRanges(gg.REGION_ANONYMOUS | gg.REGION_C_BSS)

gg.searchNumber("26741;210;2342;4025;40060::384", gg.TYPE_QWORD)

local size = 5
local cnt = gg.getResultCount()
if cnt > 0 and cnt%size == 0 then
	print(">>> Found", cnt, "results.")
	local r = gg.getResults(cnt)
	for i=0, cnt/size-1 do
		r[1+i*size].value = 1000000 -- health
		r[2+i*size].value = 15000 -- speed
		r[3+i*size].value = 2 * r[3+i*size].value -- physical damage
		r[4+i*size].value = 2 * r[4+i*size].value -- special damage
		r[5+i*size].value = 2000000 -- protection
	end
	gg.setValues(r)
	print(">>> Done.")
else
	print("!!! Strange number of results: ", cnt)
end
