require 'rails_helper'

describe 'zipcodes unit test', type: :request do

	# Prueba 1: la api responde status 200 en el index y al consultar codigo postal correcto
	it 'API index responde status 200' do
		get '/zip-codes'
		expect(response).to have_http_status(:success)
		
		get '/zip-codes/80090'
		expect(response).to have_http_status(:success)
	end
	
	# Prueba 2: api responde con un json de 5 elementos para un CP que existe
	# {zip_code, locality, federal_entity, settlements {}, municipality}
	it 'API GET resonde con 5 elementos' do
		get '/zip-codes/80800'

		expect(JSON.parse(response.body).size).to eq(5)
	end
	
	# Prueba 3: CP 80805 responde con estado = Sinaloa
	it 'API GET 80800 estado= SINALOA' do
		get '/zip-codes/80805'
		json = JSON.parse(response.body)
		expect(json["federal_entity"]).to eql("Sinaloa")
	end
	
	# Prueba 4: api responde status 404 para un CP que no existe y un json con un mensaje de error
	it 'API GET responde status 404 not found' do
		get '/zip-codes/00001'
		expect(response).to have_http_status(:not_found)
		
		json = JSON.parse(response.body)
		expect(json["error"]). to include("not found")
	end
	
	
end