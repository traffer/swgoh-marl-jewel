
local filepath = string.match(debug.getinfo(1).source, "^@(.*)$")
local dir = string.gsub(filepath, "/[^/]+$", "")

package.path = package.path .. string.format(";%s/?.lua", dir)
--print(package.path)

local utils = require("__utils")

-- Opens a file in read
file = assert(io.open(dir.."/db.csv", "r"))

-- sets the default input file
io.input(file)

-- parse CSV
local dataSet = {}
for line in io.lines() do
	local t = utils.parseCSVLine(line)
	local key = t[1]
	dataSet[key] = {
		["name"] = key,
		["query"] = t[2]
	}
end

-- closes the open file
io.close(file)

-- get all names
local names={}
for k,v in pairs(dataSet) do
  table.insert(names, k)
end
table.sort(names)

-- show selection dialog and process the selection

local choice

repeat
	choice = gg.multiChoice(names, {}, "CHOOSE TOONS TO PATCH:")
until choice == nil or utils.lengthOfTable(choice) > 0

if choice == nil then
	print("Cancelled!!!")
	return
end	

-- create patch

gg.setRanges(gg.REGION_ANONYMOUS | gg.REGION_C_BSS)

local patch = {}

for k,v in pairs(choice) do

	local name = names[k]
	local data = dataSet[name]
	
	local resObj = {}
	resObj.name = name

	gg.clearResults()
	gg.searchNumber(data.query, gg.TYPE_QWORD)

	local size = 3
	local cnt = gg.getResultCount()
	if cnt > 0 and cnt%size == 0 then
		local r = gg.getResults(cnt)
		for i=0, cnt/size-1 do
			--r[1+i*size].value = 10000 -- health
			r[2+i*size].value = 190 + r[2+i*size].value -- speed
			r[3+i*size].value = 2000 + r[3+i*size].value -- physical damage
		end
		resObj.table = r
	else
		resObj.error = "Strange number of results: "..cnt
	end

	table.insert(patch, resObj)
end

-- apply patch

for k,resObj in ipairs(patch) do

	if resObj.error == nil and resObj.table ~= nil then
		gg.setValues(resObj.table)
		print(resObj.name.." : Success!")
	elseif resObj.error ~= nil then
		print(resObj.name.." : Failed. "..resObj.error)
	else 
		print(resObj.name.." : Exception.")
	end

end
