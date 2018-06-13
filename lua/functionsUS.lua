require("lualibs.lua")


-- @json file
function getjsonfile (file)
    local f, s
      f = io.open(file, 'r')
        s = f:read('*a')
        f.close()
        return s
 end

function boldName (string, author)
	return string.gsub(string, author,"\\textbf{" .. author .. "}")
end

function printChapters (tab)
	local i = 1
	for k, v in pairs (tab) do
    	if type(v) == "table" then
        write( "~ &" .. i .. " & " .. v["title"] .. " & " 
            .. v["book"] .. ". Pags ".. v["pages"] .."&~\\\\\\hline")
            i= i + 1
    	end
	end
end

function printJournals (tab)
	local i = 1
	for k, v in pairs (tab) do
    	if type(v) == "table" then
        	write( "~ &" .. i .. " & " .. v["title"] .. " & " 
            .. v["journal"]  .."&~\\\\\\hline")
			i= i + 1
    	end
	end
end


function printConferences (tab)
		local i = 1

	for k, v in pairs (tab) do
    	if type(v) == "table" then
         write( "~ &" .. i .. " & " .. v["title"] .. " & " 
            .. v["conference"]  .."&~\\\\\\hline")
			i= i + 1
          
    	end
	end
end


function printProjects (tab)
		local i = 1

	for k, v in pairs (tab) do
    	if type(v) == "table" then
       		write( "~ &" .. i .. " & " .. v["acronymn"] .. ": " .. v["title"] .. " & " .. v["start"] .. " - " .. v["end"]  .."&~\\\\\\hline")
			i= i + 1
    	end
	end
end

function printStays (tab)
	local i = 1
	for k, v in pairs (tab) do
    	if type(v) == "table" then
        
         write( i .. " ) \\textbf{" .. v["title"] .. "}. " 
            .. v["institution"] .. ". "
            .. "Estancia " .. v["type"] .. ". "
            .. "Pais " .. v["country"] .. ". "
            .. "Desde " .. v["start"] .. " "
            .. "hasta " .. v["end"] .. " ."
			.. "Duración ".. v["duration"] .. "\\\\\\\\")
			i= i + 1
            
    	end
	end
end
