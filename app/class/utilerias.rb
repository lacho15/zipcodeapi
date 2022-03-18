class Utilerias
	class C_File
		def initialize
			@file = File.open('db/cp.txt')
		end
		def getLinea(zipcode)
			sLineaRet= ""
			@file.readlines.each do |linea|
				if linea.strip.start_with? zipcode
					sLineaRet = linea.strip
					break
				end
			end
			return sLineaRet
		end
	end
	
	class C_JSON
		def initialize
			@dcJSON = {}
		end
		
		def b_existe?(zipcode)
			@dcJSON.has_key? zipcode
			#zipcode in @dcJSON
		end
		
		def getJSON(zipcode)
			hJSON = {}
			if b_existe? zipcode
				hJSON = @dcJSON[zipcode]
			end
			return hJSON
		end
		
		def parse(sLinea, zipcode="")
			dtJson_ret = {}
			
			ltCampos = sLinea.split('|')
			dtJson_ret = {
				:zip_code => ltCampos[0],
				:locality => ltCampos[5],
				:federal_entity => ltCampos[4],
				:settlements => 
				[
					{
					:name => ltCampos[1],
					:zone_type => ltCampos[13],
					:settlement_type => ltCampos[2]
					}
				],
				:municipality => ltCampos[3]
			}
			@dcJSON[zipcode] = dtJson_ret
			puts @dcJSON.length
			if(@dcJSON.length > 200)
				@dcJSON.delete(@dcJSON.first[0])
			end
			return dtJson_ret
		end
	end
end