require('helper_spec')

describe(City) do

  describe('.all') do
    it("shows the city array as empty at first") do
      expect(City.all()).to(eq([]))
    end
  end

  describe('#==') do
    it("shows a city as being the same when they share the same id and name") do
      test_city = City.new({:id => nil, :name => "Portland"})
      test_city2 = City.new({:id => nil, :name => "Portland"})
      expect(test_city).to(eq(test_city2))
    end
  end

  describe('#save') do
    it("saves a new city object in the database") do
      test_city = City.new({:id => nil, :name => "Portland"})
      test_city.save()
      expect(City.all()).to(eq([test_city]))
    end
  end

  describe('.find') do
    it('returns a city by an id') do
      test_city = City.new({:id => nil, :name => "Rome"})
      test_city2 = City.new({:id => nil, :name => "Addis Ababa"})
      test_city.save()
      test_city2.save()
      expect(City.find(test_city2.id())).to(eq(test_city2))
    end
  end

  describe('#delete') do
    it('deletes a city from the database') do
      test_city = City.new({:id => nil, :name => "Paris"})
      test_city.save()
      test_city.delete()
      expect(City.all()).to(eq([]))
    end
  end

end
