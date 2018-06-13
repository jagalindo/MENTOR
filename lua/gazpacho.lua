require("lualibs.lua")
require ("epdf")
 --flag to include documents
 print_proofs=true
 
 itemType="subsubsection"
 --itemType=""
 authorName="José A. Galindo"
 --research-
 journals_file='objects/research/journals.json'
 editorials_file='objects/research/editorials.json'
 bookchapters_file='objects/research/chapters.json'
 conferences_file='objects/research/conferences.json'
 projects_file='objects/research/projects.json'
 stays_file='objects/research/stays.json'
 groups_file='objects/research/groups.json'
 funding_file='objects/research/funding.json'
 --index
 jcrindex_file='objects/index/jcr_index.json' -- file with the jcr index information
 scie_file='objects/index/scie_index_2018.json' -- file where the scie conference ranking appears
 last_index='2016' -- last year of JCR index

 --teaching
 teaching_file='objects/teaching.json'
 teaching_file_quality='objects/teaching_quality.json'

 --studies
 studies_file='objects/formacion_academica.json'

 --others
 others_file='objects/others.json'

 -- relative if . else absolute
 basepath='.' 

 subpaths={
    '/documentos/investigacion/asistencia/',
    '/documentos/investigacion/comites/',
    '/documentos/investigacion/comites/organizacion/',
    '/documentos/investigacion/comites/programa/',
    '/documentos/investigacion/congresos/',
    '/documentos/investigacion/congresos/nacionales/',
    '/documentos/investigacion/congresos/nacionales/talleres/',
    '/documentos/investigacion/congresos/internacionales/',
    '/documentos/investigacion/congresos/internacionales/workshops/',
    '/documentos/investigacion/congresos/indicadores/',
    '/documentos/investigacion/contratos/',
    '/documentos/investigacion/transferencia/BeTTy/',
    '/documentos/investigacion/transferencia/FAMA/',
    '/documentos/investigacion/transferencia/TESALIA/',
    '/documentos/investigacion/indicios_calidad/',
    '/documentos/investigacion/informes/',
    '/documentos/investigacion/libros/',
    '/documentos/investigacion/otros/',
    '/documentos/investigacion/postdoc/',
    '/documentos/investigacion/grupos/',
    '/documentos/investigacion/seminarios/',
    '/documentos/investigacion/proyectos/',
    '/documentos/investigacion/proyectos/autonomico/',
    '/documentos/investigacion/proyectos/ayudas/',
    '/documentos/investigacion/proyectos/europeo/',
    '/documentos/investigacion/proyectos/nacional/',
    '/documentos/investigacion/proyectos/redes/',
    '/documentos/investigacion/revisiones/',
    '/documentos/investigacion/revistas/',
    '/documentos/investigacion/revistas/editorials/',
    '/documentos/investigacion/revistas/indexadas/',
    '/documentos/investigacion/tesis_dirigidas/',
    '/documentos/investigacion/transferencia/',
    '/documentos/docencia/congresos/',
    '/documentos/docencia/cursos/recibidos/',
    '/documentos/docencia/tesis/',
    '/documentos/docencia/cursos/',
    '/documentos/docencia/publicaciones/',
    '/documentos/docencia/proyectos/',
    '/documentos/docencia/docencia_impartida/',
    '/documentos/docencia/evaluaciones/',
    '/documentos/docencia/innovacion/',
    '/documentos/docencia/material/',
    '/documentos/docencia/material/ISBN/',
    '/documentos/docencia/tribunales/',
    '/documentos/docencia/otros/',
    '/documentos/formacion/becas/',
    '/documentos/formacion/acreditacion/',
    '/documentos/formacion/estancias/',
    '/documentos/formacion/doctorado/',
    '/documentos/formacion/doctorado/periodico/',
    '/documentos/formacion/cursos/',
    '/documentos/formacion/idiomas/',
    '/documentos/formacion/titulacion/',
    '/documentos/experiencia_profesional/',
    '/documentos/gestion/',
    '/documentos/otros/',
    '/documentos/dni/'
}

rep, write = string.rep, tex.print


------------------------
------BASIC UTILS-------
------------------------

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

function pdfPagesNumber(file)
    
    local doc = epdf.open(file, 'r')
    local pages
    if (doc) then
      pages = doc:getCatalog():getNumPages()
    else
      pages = 0
    end
    return pages
end

function file_exists(name)
    local f=io.open(name,"r")
    if f~=nil then 
        io.close(f) 
        return true 
    else 
        return false 
    end
end

function getPath(filename)
    for i, sp in ipairs(subpaths) do
        fullpath=basepath..sp..filename
        
        if file_exists(fullpath)  then
            return fullpath
        end        
    end
  -- return filename
end
---------------------
------JOURNALS-------
---------------------

-- In some evaluations processes, the candidite has to select a set of relevant outputs. In such a case, this function can be used to print those from the conference and journal files. In the json, a "relevant" filed is needed to select the output as relevant. 
function printRelevants (tabj,tabc)
	for k, v in pairs (tabc) do
    	if type(v) == "table" then
	 if(not (v["relevant"] == nil)) then
        	print_conference_relevant(v)
         end
    	end
	end

	for j, t in pairs (tabj) do
    	if type(t) == "table" then
	 if(not (t["relevant"] == nil)) then
        	print_journal_relevant(t)
         end
    	end
	end
end

-- In some evaluations processes, the candidite has to select a set of relevant outputs that have been done in collaboration with external partners
function printCollaborations (tabj,tabc)
	for k, v in pairs (tabc) do
    	if type(v) == "table" then
	 if(not (v["collaboration"] == nil)) then
        	print_conference_collaboration(v)
         end
    	end
	end

	for j, t in pairs (tabj) do
    	if type(t) == "table" then
	 if(not (t["collaboration"] == nil)) then
        	print_journal_collaboration(t)
         end
    	end
	end
end



function printJournals (tab)
	for k, v in pairs (tab) do
    	if type(v) == "table" then
        	print_journal(v)
    	end
	end
end

function printJCRJournalsResume(tab)
    local q1 = 0
    local q2 = 0
    local q3 = 0
    local q4 = 0
    local others = 0
    for k, v in pairs (tab) do
    	if type(v) == "table" then	
            local cuartile = getJCRCuartile(v["journal"],"2016")
            if cuartile == "Q1" then
                q1 = q1 + 1
            elseif cuartile == "Q2" then
                q2 = q2 + 1
            elseif cuartile == "Q3" then
                q3 = q3 + 1
            elseif cuartile == "Q4" then
                q4 = q4 + 1
            else
                others = others + 1
            end
        end
    end
    print_jcr_resume(q1,q2,q3,q4,others)
end

function getJCRIndex (journal, year)
   local string_var = "" 
   local indices =  utilities.json.tolua(getjsonfile(jcrindex_file))
    
    for k, v in pairs (indices) do
    	if type(v) == "table" then
           if (v["journal"] == journal) then
                   string_var =  v[year] 
            end
    	end
    end
    return string_var
end

function getJCRCuartile (journal, year)
    local indices =  utilities.json.tolua(getjsonfile(jcrindex_file))
    
    for k, v in pairs (indices) do
    	if type(v) == "table" then
           if (v["journal"] == journal) then
                return v["Q-"..year]
            end
    	end
    end
    return ""
end

function getJCRTercil (journal, year)
    local indices =  utilities.json.tolua(getjsonfile(jcrindex_file))
    
    for k, v in pairs (indices) do
    	if type(v) == "table" then
           if (v["journal"] == journal) then
                return v["T-"..year]
            end
    	end
    end
    return ""
end

function getJCRPos (journal, year)
    local indices =  utilities.json.tolua(getjsonfile(jcrindex_file))
    
    for k, v in pairs (indices) do
    	if type(v) == "table" then
           if (v["journal"] == journal) then
                return v["P-"..year]
            end
    	end
    end
    return ""
end

function getJCRTotal (journal, year)
    local indices =  utilities.json.tolua(getjsonfile(jcrindex_file))
    
    for k, v in pairs (indices) do
    	if type(v) == "table" then
           if (v["journal"] == journal) then
                return v["TO-"..year]
            end
    	end
    end
    return ""
end

function getJCRField (journal)
    local indices =  utilities.json.tolua(getjsonfile(jcrindex_file))
    
    for k, v in pairs (indices) do
    	if type(v) == "table" then
           if (v["journal"] == journal) then
                return v["field"]
            end
    	end
    end
    return ""
end

function getJCRYear (journal, year)
   local string_var = "" 
   local indices =  utilities.json.tolua(getjsonfile(jcrindex_file))
    
    for k, v in pairs (indices) do
    	if type(v) == "table" then
           if (v["journal"] == journal) then
                   if (string.len(v[year])>0) then
			 string_var = year 
		   else string_var = last_index 
		   end
            end
    	end
    end
    return string_var
end



---------------------
------CHAPTERS-------
---------------------

function printChapters (tab)
	for k, v in pairs (tab) do
    	if type(v) == "table" then
            print_chapter(v)
    	end
	end
end

------------------------
------CONFERENCES-------
------------------------

function printConferences (tab)
    for k, v in pairs (tab) do
    	if type(v) == "table" then
            print_conference(v)
        end
	end
end

function isPlusConference(conference)
    local indices =  utilities.json.tolua(getjsonfile(scie_file))
    for k, v in pairs (indices) do
        if type(v) == "table" then
           if (v["Acronym"] == conference) and (v["GGS Class"] == "1" or v["GGS Class"] == "2") then
                return true
            end
    	end
    end
    return false
end

function getISICuartileEquivalence(conference)
    local rating=getConferenceRating(conference)
    local result=""
    if rating == "A++" then
        result="Q1"
    elseif rating == "A+" then
        result="Q2"
    elseif rating == "A" then
        result="Q3"
    elseif rating == "A-" then
        result ="Q4"
    end
    return result
end

function getConferenceRank(conference)
    local indices =  utilities.json.tolua(getjsonfile(scie_file))
    for k, v in pairs (indices) do
        if type(v) == "table" then
           if (v["Acronym"] == conference) then
                return v["GGS Class"]
            end
    	end
    end
    return ""
end

function getConferenceRating(conference)
    local indices =  utilities.json.tolua(getjsonfile(scie_file))
    for k, v in pairs (indices) do
        if type(v) == "table" then
           if (v["Acronym"] == conference) then
                return v["GGS Rating"]
            end
    	end
    end
    return ""
end

--This function allows to only print those conferences that are ranked in the SCIE ranking according to the information put in the json
function printSCIEConferences (tab)
	for k, v in pairs (tab) do
    	if type(v) == "table"  and isPlusConference(v["acronymn"]) then
            print_conference(v)
    	end
	end
end

function printNoSCIEConferences (tab)
	for k, v in pairs (tab) do
    	if type(v) == "table"  and not isPlusConference(v["acronymn"]) then
            print_conference(v)
    	end
	end
end

---------------------
------PROJECTS-------
---------------------

function printProjects (tab)
	for k, v in pairs (tab) do
    	if type(v) == "table" then
            print_project(v)
    	end
	end
end

---------------------
--------STAYS--------
---------------------

function printStays (tab)
	for k, v in pairs (tab) do
    	if type(v) == "table" then
            print_stay(v)
    	end
	end
end

-----------------------
--------STUDIES--------
-----------------------

function printUndergratuatedStudies (tab,studyType)
	for k, v in pairs (tab) do
    	if type(v) == "table" then       	
        	if (studyType == "undergrad") and ("undergrad" == v["type"]) then
                print_undergrad(v)
            elseif studyType == "superior" and ("superior" == v["type"]) then
                print_undergrad(v)
            elseif studyType == "tecnica" and ("tecnica" == v["type"]) then
                print_undergrad(v)
            elseif studyType == "master" and ("master" == v["type"]) then
                print_master(v)
            elseif studyType == "phd" and ("phd" == v["type"]) then
             	print_phd(v)
            elseif studyType == "prize" and ("prize" == v["type"]) then
                print_prize(v)
            end
    	end
	end
end


-----------------------
--------Funding--------
-----------------------

function printFunding (tab,studyType)
	for k, v in pairs (tab) do
        if type(v) == "table" then   
            if(studyType == "all") then
                print_funding(v)
            else
                if (studyType == "predoctoral") and ("predoctoral" == v["type"]) then
                    print_funding(v)
                elseif studyType == "postdoctoral" and ("postdoctoral" == v["type"]) then
                    print_funding(v)
                end
            end
    	end
	end
end

-----------------------
--------groups--------
-----------------------

function printGroups (tab)
    for k, v in pairs (tab) do
        if type(v) == "table" then   
            print_group(v)
        end
    end
end 
-----------------------
--------Others--------
-----------------------

function printOthers (tab,otype)
    for k, v in pairs (tab) do
        if type(v) == "table" then   
           if(v["type"]==otype) then
                print_other(v)
           end
        end
    end
end 

function printOthersSimple (tab,otype)
    for k, v in pairs (tab) do
        if type(v) == "table" then   
           if(v["type"]==otype) then
                print_other_simple(v)
           end
        end
    end
end 



-----------------------
--------Theaching--------
-----------------------

function printTeaching (tab)
    for k, v in pairs (tab) do
        if type(v) == "table" then   
            print_teaching(v)
        end
    end
end 

function printTeachingQuality (tab)
    for k, v in pairs (tab) do
        if type(v) == "table" then   
            print_teaching_quality(v)
        end
    end
end 
