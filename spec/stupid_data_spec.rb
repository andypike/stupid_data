require "spec_helper"

describe StupidData do
  context "When retrieving data" do
    subject(:database) { StupidData.new("dbname=stupid_data") }

    it "populates a collection with the correct number of records" do
      results = database.query("select id, name from users")
      results.count.should == 3
    end

    it "defines attributes that match the columns matched on the result objects" do
      results = database.query("select id, name from users")
      results.each do |result|
        result.respond_to?(:id).should be_true
        result.respond_to?(:name).should be_true
      end
    end

    it "hydrates result object attributes with varchars" do
      results = database.query("select id, name from users order by name asc")
      results[0].name.should == "Amber"
      results[1].name.should == "Andy"
      results[2].name.should == "Michela"
    end

    it "hydrates result object attributes with integers" do
      results = database.query("select name, age from users order by age asc")
      results[0].age.should == 8
      results[1].age.should == 35
      results[2].age.should == 36
    end

    it "hydrates result object attributes with bigserial ids" do
      results = database.query("select id from users order by id asc")
      results[0].id.should == 1
      results[1].id.should == 2
      results[2].id.should == 3
    end

    it "hydrates result object attributes with booleans" do
      results = database.query("select male from users order by id asc")
      results[0].male.should be_true
      results[1].male.should be_false
      results[2].male.should be_false
    end

    it "adds magic question mark attributes for booleans" do
      results = database.query("select male from users order by id asc")
      results[0].male?.should be_true
      results[1].male?.should be_false
      results[2].male?.should be_false
    end

    it "hydrates result object attributes with dates" do
      pending
    end

    it "hydrates result object attributes with timestamps" do
      pending
    end

    it "hydrates result object attributes with numerics" do
      pending
    end

    it "hydrates result object attributes with nulls" do
      pending
    end

    it "raises an exception if there is a syntax error within the query" do
      expect { database.query("select does_not_exist from wtf") }.to raise_error
    end
  end
end
