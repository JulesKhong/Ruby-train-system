require('pry')

class Train
  attr_reader(:id, :name)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes[:id]
  end

  define_singleton_method(:all) do
    returned_trains = DB.exec("SELECT * FROM trains;")
    trains = []
    returned_trains.each() do |train|
      name = train.fetch('name')
      id = train.fetch('id')
      trains.push(Train.new({:name => name, :id => id}))
    end
    trains
  end

end
