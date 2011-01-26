# encoding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')
describe "Sheet Model" do
  describe "Initialization" do
    it "inializes new sheet" do
      Sheet.new
    end
    it "has timestamps" do
      sheet = Sheet.new
      sheet.save
      sheet.created_at.should < Time.now
    end
    it "has class method for starting new sheet" do
      sheet = Sheet.start_new
      sheet.started_at.should < Time.now
    end
  end

  describe "Filling methods" do
    before(:each) do
      @sheet = Sheet.start_new
    end

    it "has method for starting" do
      @sheet.start
      @sheet.started_at.should be_an_instance_of(Time)
      @sheet.started_at.should < Time.now + 100
    end
    it "has method for finishing" do
      @sheet.finish
      @sheet.finished_at.should_not be_nil
    end
    it "saves to db after finishing itself" do
      @sheet.finish
      id = @sheet.id
      Sheet.find(id).finished_at.should_not be_nil
    end
    it "is filled with form hash" do
      @sheet.update_attributes(
        {"frequency" => "vůbec",
        "frequency_other" => "jak rikam",
        "relation" => "žádný",
        "time_spent" => "12",
        "purpose_gathering" => "5",
        "purpose_hobbitry" => "5",
        "purpose_fuel" => "5",
        "purpose_relaxation" => "5",
        "favorite_place" => "questionnaire[favorite_place]",
        "once_receive" => "10",
        "once_payment" => "10",
        "important_nature" => "5",
        "important_wood" => "5",
        "important_gathering" => "5",
        "important_water" => "5",
        "important_climate" => "5",
        "important_health" => "5",
        "important_ground" => "5"}).should be_true
      @sheet.update_attributes({:email => 'no@on.cz'})
      @sheet.update_attributes({:note => 'note'})
    end
  end

  describe "Scopes" do
    before(:all) do
      create_random_sheets
      create_not_finished_sheet
    end

    it "should return all finished " do
      @sheets = Sheet.finished
      @sheets.size.should == 2
    end
    it "should return all finished ordered by finish time" do
      @sheets = Sheet.finished
      @sheets.sort{|a,b| a.finished_at <=> b.finished_at}.map{|q| q.id}.should =~ @sheets.map{|q| q.id}
    end
  end

  describe "Statistics" do
    before(:all) do
      create_random_sheets(:amount => 5)
      create_not_finished_sheet
    end

    describe '#sumas_for' do
      it "computes occurences of frequency" do
        stats = Sheet.sumas_for(:frequency)
        stats.should == {'none' => 3, 'yearly' => 2, :all => 5}
      end
      it "computes occurences of purposes" do
        stats = Sheet.sumas_for(:purpose_hobbitry)
        stats.should == {'1' => 2, '2' => 1, '3' => 1, '4' => 1, :all => 5}
      end
      it "computes relation occurences" do
        stats = Sheet.sumas_for(:relation)
        stats['none'].should == 5
      end
    end
    describe "#minmax_for" do
      it "computes min/max/average for time spent" do
        stat = Sheet.minmax_for(:time_spent)
        stat.should == {'min' => 10, 'max' => 50, 'avg' => 30}
      end
      it "computes min/max/average for once receive" do
        stat = Sheet.minmax_for(:once_receive)
        stat.should == {'min' => 20, 'max' => 100, 'avg' => 60}
      end
      it "computes min/max/average for once payment" do
        stat = Sheet.minmax_for(:once_payment)
        stat.should == {'min' => 30, 'max' => 150, 'avg' => 90}
      end
    end
    describe "#all_stats" do
      it "returns all stats as hash" do
        @stats = Sheet.all_stats
        @stats.should == {
          :frequency=>{"yearly"=>2, "none"=>3, :all=>5},
          :purpose_relaxation=>{"4"=>1, "1"=>2, "2"=>1, "3"=>1, :all=>5},
          :purpose_fuel=>{"4"=>1, "1"=>2, "2"=>1, "3"=>1, :all=>5},
          :purpose_gathering=>{"4"=>1, "1"=>2, "2"=>1, "3"=>1, :all=>5},
          :purpose_hobbitry=>{"4"=>1, "1"=>2, "2"=>1, "3"=>1, :all=>5},
          :important_wood=>{"4"=>1, "1"=>2, "2"=>1, "3"=>1, :all=>5},
          :important_nature=>{"4"=>1, "1"=>2, "2"=>1, "3"=>1, :all=>5},
          :important_ground=>{"4"=>1, "1"=>2, "2"=>1, "3"=>1, :all=>5},
          :important_climate=>{"4"=>1, "1"=>2, "2"=>1, "3"=>1, :all=>5},
          :important_gathering=>{"4"=>1, "1"=>2, "2"=>1, "3"=>1, :all=>5},
          :important_health=>{"4"=>1, "1"=>2, "2"=>1, "3"=>1, :all=>5},
          :important_water=>{"4"=>1, "1"=>2, "2"=>1, "3"=>1, :all=>5},
          :relation=>{"none"=>5, :all=>5},
          :time_spent=>{"min"=>10, "max"=>50, "avg"=>30},
          :once_payment=>{"min"=>30, "max"=>150, "avg"=>90},
          :once_receive=>{"min"=>20, "max"=>100, "avg"=>60}}
      end
    end
  end

  context "Representations" do
    it "returns self as csv line separated by ," do
     @sheet = Sheet.create(
      {"frequency" => "yearly",
      "frequency_other" => "jak rikam",
      "time_spent" => 10,
      "purpose_gathering" => 1,
      "purpose_hobbitry" => 2,
      "purpose_fuel" => 3,
      "purpose_relaxation" => 4,
      "favorite_place" => "Jizerské hory",
      "once_receive" => 100,
      "once_payment" => 100,
      "important_nature" => 5,
      "important_wood" => 1,
      "important_gathering" => 2,
      "important_water" => 3,
      "important_climate" => 4,
      "important_health" => 5,
      "important_ground" => 1,
      "relation" => "none",
      "started_at" => "2010-10-26 13:48:07 +0200",
      "finished_at" => "2010-10-26 13:58:07 +0200"})
    @sheet.to_csv_line.should == %("#{@sheet.id}";"2010-10-26 13:48:07 +0200";"2010-10-26 13:58:07 +0200";"yearly";"jak rikam";"10";"1";"2";"3";"4";"Jizerské hory";"100";"100";"5";"1";"2";"3";"4";"5";"1";"none")
    end
  end
end
