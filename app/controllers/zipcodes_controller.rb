#Se crea objeto global para obtener la informacion con el formato JSON en memoria
$oJSON = Utilerias::C_JSON.new 

class ZipcodesController < ActionController::API
	before_action :set_zipcode, only: %i[ show ]
 
	#GET /zip-codes/ responde en blanco
	def index
		render nothing: true
	end

  # GET /zip-codes/{zipcode}
	def show
		#Log en consola del parametro recibido
		puts "zipcode = #{@zipcode}"
		
		sLinea = "" # Variable que obtendra la linea donde se encuentre el zipcode
		hJson = {} # Obtendra el json que se obtuvo de memoria o que se genero en oJson.parse()
		
		# Tratamos de obtener el json de memoria si ya se ha consultado anteriormente para mas rapidez
		hJson = $oJSON.getJSON(@zipcode)
		
		# Si no lo buscamos en el archivo cp.txt
		if hJson.empty?
			# Se crea objeto para leer el archivo con la informacion
			oFile = Utilerias::C_File.new
			# Del archivo se obtiene la linea que tenga el codigo postal solicitado
			sLinea = oFile.getLinea(@zipcode)
			
			if !sLinea.empty?
				# Si se encontro el zipcode se genera el json a retornar
				hJson = $oJSON.parse(sLinea, @zipcode)
			end
		end
		
		# Si no se encontro en memoria ni en el archivo retorna un 404
		if hJson.empty?
			render json: {}, status: :not_found
		else
			render json: hJson
		end
	end

	private
		#Funcion para obtener el codigo postal parseado a minimo 5 caracteres "zip-codes/1" => "00001"
		def set_zipcode
		  @zipcode = params[:id].rjust(5,'0')
		end

end
