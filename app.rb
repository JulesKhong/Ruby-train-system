require('sinatra')
require('sinatra/reloader')
require('./lib/train')
require('pg')
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => 'train_system_test'})

get('/') do
  @trains = Train.all()
  erb(:index)
end

get('/train/:id') do
  @train = Train.find(params.fetch('id').to_i())
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
  erb(:index)
end
