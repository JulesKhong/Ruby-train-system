require('sinatra')
require('sinatra/reloader')
require('./lib/train')
require('./lib/city')
require('pg')
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => 'train_system_test'})

get('/') do
  @trains = Train.all()
  @cities = City.all()
  erb(:index)
end

get('/train/:id') do
  @train = Train.find(params.fetch('id').to_i())
  @cities = City.all()
  erb(:train)
end

get('/city/:id') do
  @city = City.find(params.fetch('id').to_i())
  @trains = Train.all()
  erb(:city)
end

get('/train_stops/:id') do
  @train = Train.find(params.fetch('id').to_i())
  @cities = City.all()
  erb(:train_stops)
end

get('/city_stops/:id') do
  @city = City.find(params.fetch('id').to_i())
  @trains = Train.all()
  erb(:city_stops)
  end

post('/train') do
  @name = params.fetch('name')
  train = Train.new({:name => @name})
  train.save()
  erb(:success)
end

delete('/train/:id') do
  @train = Train.find(params.fetch('id').to_i())
  @train.delete()
  @trains = Train.all()
  @cities = City.all()
  erb(:index)
end

delete('/city/:id') do
  @city = City.find(params.fetch('id').to_i())
  @city.delete()
  @cities = City.all()
  @trains = Train.all()
  erb(:index)
end

post('/city_success') do
  @city = params.fetch('city-name')
  city = City.new({:name => @city})
  city.save()
  @cities = City.all()
  @trains = Train.all()
  erb(:city_success)
end

patch('/train/:id') do
  train_id = params.fetch('id').to_i()
  @train = Train.find(train_id)
  city_ids = params.fetch("city_ids")
  @train.update({:city_ids => city_ids})
  @cities = City.all()
  @trains = Train.all()
  erb(:index)
end

patch('/city/:id') do
  city_id = params.fetch('id').to_i()
  @city = City.find(city_id)
  train_ids = params.fetch("train_ids")
  @city.update({:train_ids => train_ids})
  @trains = Train.all()
  @cities = City.all()
  erb(:index)
end
