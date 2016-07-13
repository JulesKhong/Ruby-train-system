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


end
