# README

# curl con respuesta correcta
curl -i -X GET http://13.52.243.183:3000/zip-codes/80800

# curl con respuesta incorrecta
curl -i -X GET http://13.52.243.183:3000/zip-codes/08080



# Ejecutar las pruebas unitarias
rspec spec/tests/zipcodes_spec.rb