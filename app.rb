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

post('/train') do
  @name = params.fetch('name')
  train = Train.new({:name => @name})
  train.save()
  erb(:success)
end
