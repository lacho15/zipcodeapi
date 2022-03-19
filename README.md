# README

# curl with correct response
curl -i -X GET http://13.52.243.183:3000/zip-codes/80800

# curl with incorrect response
curl -i -X GET http://13.52.243.183:3000/zip-codes/08080



# Ejecutar las pruebas unitarias
rspec spec/tests/zipcodes_spec.rb