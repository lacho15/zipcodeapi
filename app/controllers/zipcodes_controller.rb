#Se crea objeto para obtener la informacion con el formato JSON
$oJSON = Utilerias::C_JSON.new 

class ZipcodesController < ActionController::API
	before_action :set_zipcode, only: %i[ show ]
 
	def index
		render nothing: true
	end

  # GET /zip-codes/1
	def show
		#Log en consola
		puts "zipcode = #{@zipcode}"
		
		sLinea = ""
		hJson = {}
		
		hJson = $oJSON.getJSON(@zipcode)
		if hJson.empty?
			#Se crea objeto para leer el archivo con la informacion
			oFile = Utilerias::C_File.new
			#Del archivo se obtiene la linea que tenga el codigo postal solicitado
			sLinea = oFile.getLinea(@zipcode)
			
			if !sLinea.empty?
				hJson = $oJSON.parse(sLinea, @zipcode)
			end
		end
		
		
		if hJson.empty?
			render json: {error: "zipcode #{@zipcode} not found"}, status: :not_found
		else
			render json: hJson
		end
	end

	private
		#Funcion para obtener el codigo postal parseado a minimo 5 caracteres => 00001
		def set_zipcode
		  @zipcode = params[:id].rjust(5,'0')
		end

end
