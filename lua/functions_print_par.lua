
function decorate_field(value,data)
    local string_var = data .. ". "
    if value == "doi" then 
        string_var= "\\url{https://doi.org/" .. data .. "}. "
    elseif value == "jcrindex"  then
        string_var= "JCR index: ".. data .. ". "
    elseif value == "jcrcuartil"  then
        string_var= "JCR Cuartil: ".. data .. ". "
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
    elseif value == "SCIEquivalence" then
        string_var= "Equivalencia según la SCIE al índice JCR: ".. data .. ". "
    end
    if data == "" or data== " " then
        string_var=  ""
    end
    return string_var
end

function print_conference(v)
    write( "\\subsubsection{" ..v["acronymn"].." - ".. decorate_field("year",v["year"]).."}"
    .. decorate_field("authors",boldName(v["authors"], "José A. Galindo") )
    .. decorate_field("title",v["title"])
    .. decorate_field("conference",v["conference"])
    .. decorate_field("year",v["year"])
    .. decorate_field("doi",v["doi"])
    .. decorate_field("city",v["city"])
    .. decorate_field("country",v["country"])
    .. decorate_field("ISBN",v["ISBN"])
    .. decorate_field("rankingSCIE",getConferenceRank(v["acronymn"]))
    .. decorate_field("ratingSCIE",getConferenceRating(v["acronymn"]))
    .. decorate_field("SCIEquivalence",getISICuartileEquivalence(v["acronymn"])))
    
    --write("\\\\\\\\")
    
    if(print_proofs == true) then
        
        --todas las del indice
        path=getPath(v["index"])
        pagnumber=pdfPagesNumber(path);

        for i=1,pagnumber do 
            write("\\insertpage{"..i.."}{"..path.."}")
        end

        path = getPath(v["document"])
        pagnumber=pdfPagesNumber(path);
        write("\\insertpage{1}{"..path.."}")
        write("\\insertpage{"..pagnumber.."}{"..path.."}")      
    end
end


function print_journal(v)
    write( 
        "\\subsubsection{"..decorate_field("journal",v["journal"]) ..  decorate_field("year",v["year"]).."}"
    .. decorate_field("authors",boldName(v["authors"], "José A. Galindo") )
    .. decorate_field("title", v["title"])  
    .. decorate_field("journal",v["journal"])
    .. decorate_field("year",v["year"])
    .. decorate_field("editorial",v["editorial"])
--  .. decorate_field("pages",v["pages"])
    .. decorate_field("doi",v["doi"])
    .. decorate_field("volumen",v["volumen"])
--    .. decorate_field("number",v["number"]) 
    .. decorate_field("ISBN",v["ISSBN"]) 
    .. decorate_field("jcrindex",getJCRIndex(v["journal"],"2016"))
    .. decorate_field("jcrcuartil",getJCRCuartile(v["journal"],"2016")))

   -- write("\\\\\\\\")
    
    if(print_proofs == true) then
        path = getPath(v["document"])
        pagnumber=pdfPagesNumber(path);
        write("\\insertpage{1}{"..path.."}")
        write("\\insertpage{"..pagnumber.."}{"..path.."}")      
        if(not (v["just"]== nil or v["just"]== "")) then
            path = getPath(v["just"])
            write("\\insertpage{1}{"..path.."}")      

        end
    end
end

function print_jcr_resume(q1,q2,q3,q4,others)
    write("El candidato ha publicado ".. q1 .. " artículos del primer cuartil, " .. q2 .. " artículos del segundo, " .. 
    q3 .. " artículos del tercer cuartil y ".. q4 .. " artículos en el cuarto. ".. "Asimismo, ha publicado " .. 
    others .." artículos de revista no indexados.")
end

function print_chapter(v)
    write( 
        "\\subsubsection{"..decorate_field("editorial",v["editorial"]) .."-"..  decorate_field("year",v["year"]).."}"
    .. decorate_field("title",v["title"]) 
    .. decorate_field("authors",boldName(v["authors"],"José A. Galindo"))
    .. decorate_field("book",v["book"])
    .. decorate_field("year",v["year"])
    .. decorate_field("editorial",v["editorial"])
    .. decorate_field("pages",v["pages"])
    .. decorate_field("doi",v["doi"]))

  --  write("\\\\\\\\")
  if(print_proofs == true) then
    for number in string.gmatch(v["document-pages"], '([^,]+)') do
        path = getPath(v["document"])
        write("\\insertpage{".. number .."}{"..path.."}")           
    end  
   end
end

function print_project(v)
    write( 
        "\\subsubsection{"..v["title"] .."}"

     ..   "Proyecto  " .. v["title"] .. ". " 
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
    write( 
        "\\subsubsection{"..v["institution"] .." " .. v["start"] .." - ".. v["end"] .."}"

    ..    " \\textbf{" .. v["institution"] .. "} " 
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
    write( 
        "\\subsubsection{"..v["title"] .." ".. v["start"] .. " - ".. v["end"] .."}"
    .. "\\textbf{" .. v["title"] .. "} " 
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
    write( "\\subsubsection{"..v["title"] .."}"
     .. "\\textbf{" .. v["title"] .. "}. " 
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
   write( "\\subsubsection{"..v["title"]  .."}"
    .. "\\textbf{" .. v["title"] .. "}. " 
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
    
    outstr = "\\subsubsection{"..v["title"]  .."}"
    .. "\\textbf{" .. v["title"] .. "}. " 
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
    write( "\\subsubsection{"..v["title"]  .."}"
    .. "\\textbf{" .. v["title"] .. "}. " 
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
    write( "\\subsubsection{"..v["title"]  .."}"
    .. "\\textbf{" .. v["title"] .. "}. " 
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

function print_other(v)
    write("\\paragraph{" .. v["title"] .. "}. ")
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
function string.ends(String,End)
    return End=='' or string.sub(String,-string.len(End))==End
 end
function print_teaching(v)
    write(  "\\subsubsection{"..v["title"]  .."}"
        .. "\\textbf{" .. v["title"] .. "}. Docencia impartida en la entidad " .. v["university"].." como ".. v["cathegory"].." y dedicación a " .. v["employment"].." durante el año "..v["year"])
  --  write("\\\\\\\\")

    if(print_proofs == true) then
        path = getPath(v["document"])
        
        for number in string.gmatch(v["pages"], '([^,]+)') do
            write("\\insertpage{".. number .."}{"..path.."}")              
        end  
    end
end