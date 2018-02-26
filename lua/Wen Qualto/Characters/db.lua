
local filepath = string.match(debug.getinfo(1).source, "^@(.*)$")
local dir = string.gsub(filepath, "/[^/]+$", "")

package.path = package.path .. string.format(";%s/?.lua", dir)
print(package.path)

local CSV = require("CSV")


-- Opens a file in read
file = assert(io.open(dir.."/db.csv", "r"))

-- sets the default input file
io.input(file)

-- parse CSV
local dataSet = {}
for line in io.lines() do
	local t = CSV.parseLine(line)
	dataSet[t[1]] = {
		["name"] = t[1],
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
local choice = gg.multiChoice(names)
if choice == nil then
	print("Cancelled")
else
	for k,v in pairs(choice) do
		local name = names[k]
		local data = dataSet[name]
		print(data)
	end
end


