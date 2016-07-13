require('rspec')
require('pry')
require('train')
require('pg')

# DON'T FORGET TO REQUIRE CITY ONCE IT'S BUILT

DB = PG.connect({:dbname => 'train_system_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM trains *;")
  end
end

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

end
