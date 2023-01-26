local function getmodules2()
	local RPTable = {}
	table.insert(RPTable, "local ModuleScripts = {")--1
		for i,v in pairs(ReplicatedStorage:GetChildren()) do
			if v:IsA("ModuleScript") then
					local Module = require(v)
					if string.find(tostring(v), "table") then
						table.insert(RPTable, '	'..tostring(v)..' = {')--2
							for i2,v2 in pairs(Module) do
								if string.find(tostring(v2), "table") then
									table.insert(RPTable, '		'..i2..' = {')--3
										for i3,v3 in pairs(v2) do
											table.insert(RPTable, '			"'..i3..'",')--4
										end
									table.insert(RPTable, "		},")--3
								elseif string.find(tostring(v2), "function") then
									table.insert(RPTable, '		"'..i2..'",')--4
								end
							end
						table.insert(RPTable, "	},")--2
					elseif string.find(tostring(v), "function") then
						table.insert(RPTable, '	"'..v..'",')
					else
						table.insert(RPTable, '	'..tostring(v)..' = {')--2
							for i2,v2 in pairs(Module) do
								if string.find(tostring(v2), "table") then
									table.insert(RPTable, '		'..i2..' = {')--3
										for i3,v3 in pairs(v2) do
											table.insert(RPTable, '			"'..i3..'",')--4
										end
									table.insert(RPTable, "		},")--3
								elseif string.find(tostring(v2), "function") then
									table.insert(RPTable, '		"'..i2..'",')--4
								end
							end
						table.insert(RPTable, "	},")--2
					end
			end
		end
	table.insert(RPTable, "}")--1
	return RPTable
end
local modules = getmodules2()
print(table.concat(modules, "\n"))
setclipboard(table.concat(modules, "\n"))
