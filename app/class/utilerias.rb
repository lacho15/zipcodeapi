class Utilerias

	# Clase para leer archivo con los codigos postales
	class C_File
		def initialize
			@file = File.open('db/cp.txt') #Cargamos el archivo 
		end
		def getLinea(zipcode)
			sLineaRet= ""
			
			# Leemos linea por linea hasta encontrar la que empiece con el CP recibido
			@file.readlines.each do |linea|
				if linea.strip.start_with? zipcode
					sLineaRet = linea.strip
					break
				end
			end
			
			# Si encontro el CP en el archivo la retorna, si no retorna vacio ""
			return sLineaRet
		end
	end
	
	# Clase para crear los json cuyo CP se encuentre en el archivo, asi como tambien guardarlos en
	# memoria para futuras consultas y agilizarlas
	class C_JSON
		def initialize
			@dcJSON = {}
		end
		
		# Funcion que busca los CP en memoria
		def b_existe?(zipcode)
			@dcJSON.has_key? zipcode
			#zipcode in @dcJSON
		end
		
		# Funcion que obtiene el CP si existe en memoria
		def getJSON(zipcode)
			hJSON = {}
			if b_existe? zipcode
				hJSON = @dcJSON[zipcode]
			end
			return hJSON
		end
		
		def parse(sLinea, zipcode="")
			dtJson_ret = {}
			
			ltCampos = sLinea.split('|') # Se genera lista con los elementos divididos por pipe
			
			# Se crea el json con los elementos necesarios
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
			
			# Almacenamos el json en el hash del objeto instanciado para futuras consultas
			@dcJSON[zipcode] = dtJson_ret
			
			# Log elementos en el hash 
			puts @dcJSON.length
			
			# Si el hash contiene mas de 200 json almacenados eliminamos el mas antiguo consultado
			# para optimizar la memoria
			if(@dcJSON.length > 200)
				@dcJSON.delete(@dcJSON.first[0])
			end
			return dtJson_ret
		end
	end
end