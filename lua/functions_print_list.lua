
function decorate_field(value,data)
    local string_var = data .. ". "
    if value == "doi" then
	if string.sub(data, 1, 1) == "h" then 
		string_var= "\\url{" .. data .. "}. "
        elseif value == "doi" then
		string_var= "\\url{https://doi.org/" .. data .. "}. "
	end
    elseif value == "jcrindex"  then
        string_var= "JCR-IF: ".. data  
    elseif value == "jcrpos"  then
        string_var= "(".. data 
    elseif value == "jcrtotal"  then
        string_var= "/".. data .. ") " 
    elseif value == "jcrcuartil"  then
        string_var= "JCR-Q: ".. data  .. ". "
    elseif value == "jcrtercil"  then
        string_var= "JCR-T: ".. data .. ". " 
    elseif value == "jcrcat"  then
        string_var= "JCR-Category/year: ".. data .. " - " 
    elseif value == "jcryear"  then
        string_var= data .. "." 
    elseif value == "volumen"  then
        string_var= "Volumen: ".. data .. ". "
    elseif value == "number"  then
        string_var= "Número: ".. data .. ". "
    elseif value == "pages"  then
        string_var= "Páginas: ".. data .. ". "
    elseif value == "editorial"  then
        string_var= "Editorial: ".. data .. ". "
    elseif value == "ISBN"  then
        string_var= "ISBN: ".. data .. ". "    
    elseif value == "rankingSCIE"  then
        string_var= "Ranking SCIE: ".. data .. ". "
    elseif value == "ratingSCIE"  then
        string_var= "Rating SCIE: ".. data .. ". "
    elseif value == "conference"  then
        string_var= "\\textit{ ".. data .. "}. "
    elseif value == "journal"  then
        string_var= "\\textit{ ".. data .. "}. "
    elseif value == "SCIEquivalence" then
        string_var= "Equivalencia según la SCIE al índice JCR: ".. data .. ". "
    end
    if data == "" or data== " " then
        string_var=  ""
    end
    return string_var
end


---------------------
------CONFERENCES-------
---------------------

function print_conference(v)
    if(itemType ~= "") then
        write( 
        "\\"..itemType.."{"..v["acronymn"].." - ".. decorate_field("year",v["year"]).."}")
    end

    write( 
       decorate_field("authors",boldName(v["authors"], authorName) )
    .. decorate_field("title",v["title"])
    .. decorate_field("conference",v["conference"])
    .. decorate_field("year",v["year"])
    .. decorate_field("doi",v["doi"])
--    .. decorate_field("city",v["city"])
--    .. decorate_field("country",v["country"])
--    .. decorate_field("ISBN",v["ISBN"])
    .. decorate_field("rankingSCIE",getConferenceRank(v["acronymn"]))
    .. decorate_field("ratingSCIE",getConferenceRating(v["acronymn"]))
    .. decorate_field("SCIEquivalence",getISICuartileEquivalence(v["acronymn"])))
    
    --write("\\\\\\\\")
    
    if(print_proofs == true) then
        
        --This is to print the index, if not needed, can be commented.
--        path=getPath(v["index"])
--        pagnumber=pdfPagesNumber(path);

--        for i=1,pagnumber do 
--            write("\\insertpage{"..i.."}{"..path.."}")
--        end

	-- This is to print the first and last page of a document
        path = getPath(v["document"])
        pagnumber=pdfPagesNumber(path);
        write("\\insertpage{1}{"..path.."}")
        write("\\insertpage{"..pagnumber.."}{"..path.."}")      
    end
end

-- This is a function to print the data of a relevant selected conference with the rational of why it was selected as a relevant conference by the candidate
function print_conference_relevant(v)
    if(itemType ~= "") then
        write( 
        "\\"..itemType.."{"..v["acronymn"].." - ".. decorate_field("year",v["year"]).."}")
    end
    write( 
       decorate_field("authors",boldName(v["authors"], authorName) )
    .. decorate_field("title",v["title"])
    .. decorate_field("conference",v["conference"])
    .. decorate_field("year",v["year"])
    .. decorate_field("doi",v["doi"])
    .. decorate_field("rankingSCIE",getConferenceRank(v["acronymn"]))
    .. decorate_field("ratingSCIE",getConferenceRating(v["acronymn"]))
    .. decorate_field("SCIEquivalence",getISICuartileEquivalence(v["acronymn"]))
    .. "\\textbf{ Motivo de la selección}: "
    ..  v["relevant"]
    .. "\\\\")
end

-- This is a function to print the data of a relevant selected conference with the rational of why it was selected as a relevant conference by the candidate
function print_conference_collaboration(v)
    if(itemType ~= "") then
        write( 
        "\\"..itemType.."{"..v["acronymn"].." - ".. decorate_field("year",v["year"]).."}")
    end
    write( 
       decorate_field("authors",boldName(v["authors"], authorName) )
    .. decorate_field("title",v["title"])
    .. decorate_field("conference",v["conference"])
    .. decorate_field("year",v["year"])
    .. decorate_field("doi",v["doi"])
    .. decorate_field("rankingSCIE",getConferenceRank(v["acronymn"]))
    .. decorate_field("ratingSCIE",getConferenceRating(v["acronymn"]))
    .. decorate_field("SCIEquivalence",getISICuartileEquivalence(v["acronymn"])))
end



---------------------
------JOURNALS-------
---------------------


function print_journal(v)

    local jcr_year =  getJCRYear(v["journal"],v["year"])

    if(itemType ~= "") then
        write( 
        "\\"..itemType.."{"..decorate_field("journal",v["journal"]) ..  decorate_field("year",v["year"]).."}")
    end
     
    write( 
       decorate_field("authors",boldName(v["authors"], authorName) )
    .. decorate_field("title", v["title"])  
    .. decorate_field("journal",v["journal"])
    .. decorate_field("year",v["year"])
--    .. decorate_field("editorial",v["editorial"])
--  .. decorate_field("pages",v["pages"])
    .. decorate_field("volumen",v["volumen"])
    .. decorate_field("doi",v["doi"])
--    .. decorate_field("number",v["number"]) 
--    .. decorate_field("ISBN",v["ISSBN"]) 
    .. decorate_field("jcrindex",getJCRIndex(v["journal"],jcr_year))
    .. decorate_field("jcrpos",getJCRPos(v["journal"],jcr_year))
    .. decorate_field("jcrtotal",getJCRTotal(v["journal"],jcr_year))
    .. decorate_field("jcrcuartil",getJCRCuartile(v["journal"],jcr_year))
    .. decorate_field("jcrtercil",getJCRTercil(v["journal"],jcr_year))
    .. decorate_field("jcrcat",getJCRField(v["journal"],jcr_year))
    .. decorate_field("jcryear",jcr_year))

    if(print_proofs == true) then
        path = getPath(v["document"])
        pagnumber=pdfPagesNumber(path);
        write("\\insertpage{1}{"..path.."}")
        write("\\insertpage{"..pagnumber.."}{"..path.."}")      
    end
end


function print_journal_relevant(v)

    local jcr_year =  getJCRYear(v["journal"],v["year"])

    if(itemType ~= "") then
        write( 
            "\\"..itemType.."{"..decorate_field("journal",v["journal"]) ..  decorate_field("year",v["year"]).."}")
    end

    write( 
       decorate_field("authors",boldName(v["authors"], authorName) )
    .. decorate_field("title", v["title"])  
    .. decorate_field("journal",v["journal"])
    .. decorate_field("year",v["year"])
--    .. decorate_field("editorial",v["editorial"])
--  .. decorate_field("pages",v["pages"])
    .. decorate_field("volumen",v["volumen"])
    .. decorate_field("doi",v["doi"])
--    .. decorate_field("number",v["number"]) 
--    .. decorate_field("ISBN",v["ISSBN"]) 
    .. decorate_field("jcrindex",getJCRIndex(v["journal"],jcr_year))
    .. decorate_field("jcrpos",getJCRPos(v["journal"],jcr_year))
    .. decorate_field("jcrtotal",getJCRTotal(v["journal"],jcr_year))
    .. decorate_field("jcrcuartil",getJCRCuartile(v["journal"],jcr_year))
    .. decorate_field("jcrtercil",getJCRTercil(v["journal"],jcr_year))
    .. decorate_field("jcrcat",getJCRField(v["journal"],jcr_year))
    .. decorate_field("jcryear",jcr_year)
    .. "\\textbf{ Motivo de la selección}: "
    ..  v["relevant"]
    .. "\\\\" )

end

function print_journal_collaboration(v)

   local jcr_year =  getJCRYear(v["journal"],v["year"])

   if(itemType ~= "") then
    write( 
    "\\"..itemType.."{"..decorate_field("journal",v["journal"]) ..  decorate_field("year",v["year"]).."}")
    end
     
    write( 
       decorate_field("authors",boldName(v["authors"], authorName) )
    .. decorate_field("title", v["title"])  
    .. decorate_field("journal",v["journal"])
    .. decorate_field("year",v["year"])
--    .. decorate_field("editorial",v["editorial"])
--  .. decorate_field("pages",v["pages"])
    .. decorate_field("volumen",v["volumen"])
    .. decorate_field("doi",v["doi"])
--    .. decorate_field("number",v["number"]) 
--    .. decorate_field("ISBN",v["ISSBN"]) 
    .. decorate_field("jcrindex",getJCRIndex(v["journal"],jcr_year))
    .. decorate_field("jcrpos",getJCRPos(v["journal"],jcr_year))
    .. decorate_field("jcrtotal",getJCRTotal(v["journal"],jcr_year))
    .. decorate_field("jcrcuartil",getJCRCuartile(v["journal"],jcr_year))
    .. decorate_field("jcrtercil",getJCRTercil(v["journal"],jcr_year))
    .. decorate_field("jcrcat",getJCRField(v["journal"],jcr_year))
    .. decorate_field("jcryear",jcr_year))

end



function print_jcr_resume(q1,q2,q3,q4,others)
    write("El candidato ha publicado ".. q1 .. " artículos del primer cuartil, " .. q2 .. " artículos del segundo, " .. 
    q3 .. " artículos del tercer cuartil y ".. q4 .. " artículos en el cuarto. ".. "Asimismo, ha publicado " .. 
    others .." artículos de revista no indexados.")
end



---------------------
------CHAPTERS-------
---------------------

function print_chapter(v)

    if(itemType ~= "") then
        write( 
        "\\"..itemType.."{"..decorate_field("editorial",v["editorial"]) .."-"..  decorate_field("year",v["year"]).."}")
    end

    write( 
       decorate_field( "authors",boldName(v["authors"],authorName))
    .. decorate_field("title",v["title"])
    .. decorate_field("book",v["book"])
    .. decorate_field("year",v["year"])
    .. decorate_field("editorial",v["editorial"])
    .. decorate_field("pages",v["pages"])
    .. decorate_field("doi",v["doi"]))

--    write("\\\\\\\\")
  if(print_proofs == true) then
    for number in string.gmatch(v["document-pages"], '([^,]+)') do
        path = getPath(v["document"])
        write("\\insertpage{".. number .."}{"..path.."}")           
    end  
  end
end

function print_project(v)

    if(itemType ~= "") then
        write( 
        "\\"..itemType.."{"..v["title"] .."}")
    end

    write( "Proyecto  " .. v["title"] .. ". " 
    .. "Pais: " .. v["country"] .. ". "
    .. "Ambito: " ..v["scope"].. ". "
    .. "Entidad: " .. v["entity"] ..". "
    .. "Investigador principal: " .. v["ip"] .. ". "
    .. v["start"] .. " - "
    .. v["end"] .. ". "
    .. "Cantidad " .. v["quantity"].. "€")

    --write("\\\\\\\\")    
    if(print_proofs == true) then
        path = getPath(v["document"])
        write("\\insertpage{1}{"..path.."}")
        if(not (v["contrato"] == nil)) then
            path = getPath(v["contrato"]["document"])
            write("\\paragraph{Contrato a cargo del proyecto}")
            for number in string.gmatch(v["contrato"]["pags"], '([^,]+)') do
                write("\\insertpage{".. number .."}{"..path.."}")              
            end
        end
    end
end 

function print_stay(v)

    if(itemType ~= "") then
        write( 
        "\\"..itemType.."{"..v["institution"] .." " .. v["start"] .." - ".. v["end"] .."}")
    end

    write( " \\textbf{" .. v["institution"] .. "} " 
    .. "dentro del grupo de investigación "..v["team"].." y a cargo del investigador "..v["title"] .. ". "
    .. "Estancia de tipo " .. v["type"] .. " "
    .. "en " .. v["country"] .. " "
    .. "desde el " .. v["start"] .. " "
    .. "hasta el " .. v["end"] .. ". "
    .. "Lo que representa una duración de ".. v["duration"].."." )

    --write("\\\\\\\\")    
    if(print_proofs == true) then
        for k, v in pairs (v["document"]) do
            write("\\paragraph{"..k.."}")
            path = getPath(v)
            
            write("\\insertpage{1}{"..path.."}\\vspace{0.5cm}")
            if(not(k == "Justificante estancia")) then
                pagnumber=pdfPagesNumber(path);
                for i=2,pagnumber do 
                    write("\\insertpage{"..i.."}{"..path.."}")
                end
            end
        end
    end
end

function print_group(v)

    if(itemType ~= "") then
        write( 
        "\\"..itemType.."{"..v["title"] .." " .. v["start"] .." - ".. v["end"] .."}")
    end

    write( "\\textbf{" .. v["title"] .. "} " 
    .. "en la institución "..v["institution"] .. ". "
    .. "Desde " .. v["start"] .. " "
    .. "hasta " .. v["end"] .. ". "
    .. "Ejerciendo la categoría de ".. v["category"]..".")

    --write("\\\\\\\\")    
    if(print_proofs == true) then
        path = getPath(v["document"])
        
        for number in string.gmatch(v["pages"], '([^,]+)') do
            write("\\insertpage{".. number .."}{"..path.."}")              
        end  
    end
end

function print_undergrad(v)

    if(itemType ~= "") then
        write( 
        "\\"..itemType.."{"..v["title"] .."}")
    end


    write( "\\textbf{" .. v["title"] .. "}. " 
    .. v["institution"] .. ". "
    .. "Nota Media " .. v["scores"])
    --write("\\\\\\\\")    

    if(print_proofs == true) then
        write("\\paragraph{Título}")
        path = getPath(v["document"])
        
        write("\\insertpage{1}{"..path.."}")              
        write("\\paragraph{Certificado}")
        path = getPath(v["scoresDocument"])
        
        for number in string.gmatch(v["pages"], '([^,]+)') do
            write("\\insertpage{".. number .."}{"..path.."}")              
        end  
    end
end

function print_master(v)
    if(itemType ~= "") then
        write( 
        "\\"..itemType.."{"..v["title"] .."}")
    end
   write( "\\textbf{" .. v["title"] .. "}. " 
    .. v["institution"] .. ". "
    .. "Nota Media " .. v["scores"])
    --write("\\\\\\\\")    

    if(print_proofs == true) then
        write("\\paragraph{Título}")
        path = getPath(v["document"])
        
        write("\\insertpage{1}{"..path.."}")

        write("\\paragraph{Certificado}")
        path = getPath(v["scoresDocument"])
        for number in string.gmatch(v["pages"], '([^,]+)') do
            write("\\insertpage{".. number .."}{"..path.."}")              
        end  
    end
end

function print_phd(v)
    
    if(itemType ~= "") then
        write( 
        "\\"..itemType.."{"..v["title"] .."}")
    end

    outstr = "\\textbf{" .. v["title"] .. "}. " 
    .. v["institution"] .. ". ";
    --write("\\\\\\\\")    
    if not v["scores"] == "" then 
        out=out .."Nota Media " .. v["scores"]
    end
    
    write(outstr)

    if(print_proofs == true) then
        path = getPath(v["document"])
        
        for number in string.gmatch(v["pages"], '([^,]+)') do
            write("\\insertpage{".. number .."}{"..path.."}")              
        end  
    end
end

function print_prize(v)
    if(itemType ~= "") then
        write( 
        "\\"..itemType.."{"..v["title"] .."}")
    end
    write( "\\textbf{" .. v["title"] .. "}. " 
    .. v["institution"] ) 
    --write("\\\\\\\\")    
    if(print_proofs == true) then
        path = getPath(v["document"])
        
        for number in string.gmatch(v["pages"], '([^,]+)') do
            write("\\insertpage{".. number .."}{"..path.."}")              
        end  
    end
end

function print_funding(v)
    if(itemType ~= "") then
        write( 
        "\\"..itemType.."{"..v["title"] .."}")
    end
    write( "\\textbf{" .. v["title"] .. "}. " 
    .. v["description"] .. ". "
    .. "Financiación obtenida durante "..v["date"])
    
    --write("\\\\\\\\")    

    if(print_proofs == true) then
        path = getPath(v["document"])
        
        for number in string.gmatch(v["pages"], '([^,]+)') do
            write("\\insertpage{".. number .."}{"..path.."}")              
        end  
    end
end


---------------------
------OTHERS-------
---------------------

function print_other(v)
   
    write( "\\textbf{" .. v["title"] .. "}. ") 
   -- write("\\\\\\\\")

    if(print_proofs == true) then
        if string.ends(v["document"],".tex") then
            write("\\input{./sections/"..v["document"].."}")                          
        else 
            path = getPath(v["document"])
            
            for number in string.gmatch(v["pages"], '([^,]+)') do
                write("\\insertpage{".. number .."}{"..path.."}")              
            end
        end  
    end

end


function print_other_simple(v)
    write( "\\textbf{" .. v["title"] .. "}. ") 
end




function string.ends(String,End)
    return End=='' or string.sub(String,-string.len(End))==End
 end


---------------------
------TEACHING -------
---------------------
function print_teaching(v)
    if(itemType ~= "") then
        write( 
        "\\"..itemType.."{"..v["title"] .."}")
    end

    write("\\textbf{" .. v["title"] .. "}. Docencia impartida en la entidad " .. v["university"].." como ".. v["cathegory"].." y dedicación a " .. v["employment"].." durante el año "..v["year"])
  --  write("\\\\\\\\")

    if(print_proofs == true) then
        path = getPath(v["document"])
        
        for number in string.gmatch(v["pages"], '([^,]+)') do
            write("\\insertpage{".. number .."}{"..path.."}")              
        end  
    end
end

function print_teaching_quality(v)
    if(itemType ~= "") then
        write( 
        "\\"..itemType.."{"..v["title"] .." "..v["year"].."}")
    end

    write("\\textbf{" .. v["title"] .. "}. Docencia impartida en la entidad " .. v["university"].." durante el curso "..v["year"].." para la titulación "
        ..v["titulacion"]     )
  --  write("\\\\\\\\")

    if(print_proofs == true) then
        path = getPath(v["document"])
        write("\\insertpage{1}{"..path.."}")              
    end
end