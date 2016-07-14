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
#
post('/train/:id') do
  @city = params.fetch('city-name')
  city = City.new({:name => @city})
  city.save()
  @cities = City.all()
  @trains = Train.all()
  erb(:index)
end
