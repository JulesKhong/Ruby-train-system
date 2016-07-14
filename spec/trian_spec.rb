require('helper_spec')

describe(Train) do

  describe('.all') do
    it("shows the train array as empty at first") do
      expect(Train.all()).to(eq([]))
    end
  end

 describe('#==') do
   it("shows a train as being the same when they share the same id and name") do
     test_train = Train.new({:id => nil, :name => "Thomas"})
     test_train1 = Train.new({:id => nil, :name => "Thomas"})
     expect(test_train).to(eq(test_train1))
   end
 end

  describe('#save') do
    it("saves a new train object in the database") do
      test_train = Train.new({:id => nil, :name => 'Thomas'})
      test_train.save()
      expect(Train.all()).to(eq([test_train]))
    end
  end

  describe('.find') do
    it('returns a train by an ID') do
      test_train_one = Train.new({:id => nil, :name => "Thomas"})
      test_train_one.save()
      test_train_two = Train.new({:id => nil, :name => "Soul Train"})
      test_train_two.save()
      expect(Train.find(test_train_two.id())).to(eq(test_train_two))
    end
  end

  describe('#delete') do
    it('deletes a train from the database') do
      test_train = Train.new({:id => nil, :name => "Freight"})
      test_train.save()
      test_train.delete()
      expect(Train.all()).to(eq([]))
    end
  end

  describe('#update') do
    it("lets you update trains in the database") do
      train = Train.new({:id => nil, :name => "Ruby"})
      train.save()
      train.update({:name => "Rails"})
      expect(train.name()).to(eq("Rails"))
    end
    it("lets you add a city to a train") do
      test_train = Train.new({:id => nil, :name => "Thomas"})
      test_train.save()
      test_city = City.new({:id => nil, :name => "Walla Walla"})
      test_city.save()
      test_city_two = City.new({:id => nil, :name => "Scapouse"})
      test_city_two.save()
      test_train.update({:city_ids => [test_city.id(), test_city_two.id()]})
      expect(test_train.cities()).to(eq([test_city, test_city_two]))
    end
  end

  describe("#cities") do
    it("returns all of the cities for a particular train") do
      test_train = Train.new({:id => nil, :name => "Thomas"})
      test_train.save()
      test_city = City.new({:id => nil, :name => "New York"})
      test_city.save()
      test_city_two = City.new({:id => nil, :name => "Vancouver"})
      test_city_two.save()
      test_train.update({:city_ids => [test_city.id(), test_city_two.id()]})
      expect(test_train.cities()).to(eq([test_city, test_city_two]))
    end
  end

end
