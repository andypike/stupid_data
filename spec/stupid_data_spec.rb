require "spec_helper"

describe StupidData do
  subject(:database) { StupidData.new("dbname=stupid_data") }

  context "#query" do
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

    it "hydrates result object attributes with numerics" do
      results = database.query("select avg_rating from users order by avg_rating asc")
      results[0].avg_rating.should == 4.5
      results[1].avg_rating.should == 4.75
      results[2].avg_rating.should == 5.0
    end

    it "hydrates result object attributes with nulls" do
      results = database.query("select school from users order by id asc")
      results[0].school.should be_nil
      results[1].school.should be_nil
      results[2].school.should == "A cool school"
    end

    it "hydrates result object attributes with dates" do
      results = database.query("select dob from users order by id asc")
      results[0].dob.should == Date.new(1977, 10, 4)
      results[1].dob.should == Date.new(1978, 3, 3)
      results[2].dob.should == Date.new(2005, 12, 14)
    end

    it "hydrates result object attributes with timestamps" do
      results = database.query("select created_at from users order by id asc")
      results[0].created_at.should == DateTime.new(2013, 10, 11, 20, 10, 05)
      results[1].created_at.should == DateTime.new(2013, 10, 11, 12, 18, 00)
      results[2].created_at.should == DateTime.new(2013, 10, 11, 05, 01, 59)
    end

    it "returns concrete type records if a class is supplied" do
      results = database.query("select * from users order by id asc", User)
      results[0].should be_a_kind_of User
      results[0].name.should == "Andy"
    end

    it "raises an exception if there is a syntax error within the query" do
      expect { database.query("select does_not_exist from wtf") }.to raise_error
    end
  end

  context "#count" do
    it "returns the number of matching records" do
      num_of_users = database.count("select count(*) from users")
      num_of_users.should == 3
    end
  end
end
