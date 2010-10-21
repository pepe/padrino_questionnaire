# encoding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')
describe "Sheet Model" do
  context "Initialization" do
    it "should inialize new sheet" do
      Sheet.new
    end
    it "should have timestamps" do
      sheet = Sheet.new
      sheet.save
      sheet.created_at.should < Time.now
    end
    it "should have class method for starting new sheet" do
      sheet = Sheet.start_new
      sheet.should_not be_nil
      sheet.started_at.should < Time.now
    end
  end

  context "Filling methods" do
    before(:each) do
      @sheet = Sheet.start_new
    end
    
    it "should have start method" do
      @sheet.start
      @sheet.started_at.should be_an_instance_of(Time)
      @sheet.started_at.should < Time.now + 100
    end
    it "should have finish method" do
      @sheet.finish
      @sheet.finished_at.should_not be_nil
    end
    it "should finish itself and save to db" do
      @sheet.finish
      id = @sheet.id
      Sheet.find(id).finished_at.should_not be_nil
    end
    it "should be filled with form hash" do
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

  context "Views" do
    before(:all) do
      random_sheets
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
  
  context "Statistics" do
    before(:all) do
      random_sheets(:amount => 5)
    end

    it "should compute occurences of frequency" do
      stats = Sheet.sumas_for(:frequency)
      stats.should_not be_nil
      stats['none'].should == 3
      stats['yearly'].should == 2
    end
    it "computes occurences of purposes" do
      stats = Sheet.sumas_for(:purpose_hobbitry)
      stats.should_not be_nil
      stats['1'].should == 2
      stats['2'].should == 1
      stats['3'].should == 1
      stats['4'].should == 1
      stats['5'].should be_nil
      stats[:all].should == 5
    end
    it "computes relation occurences" do
      stats = Sheet.sumas_for(:relation)
      stats.should_not be_nil
      stats['none'].should == 5
    end
    it "should compute min/max/average for value attributes" do
      stat = Sheet.minmax_for(:time_spent)
      stat.should_not be_nil
      stat['min'].should == 10
      stat['max'].should == 50
      stat['avg'].should == 30
      stat = Sheet.minmax_for(:once_receive)
      stat.should_not be_nil
      stat['min'].should == 20
      stat['max'].should == 100
      stat['avg'].should == 60
      stat = Sheet.minmax_for(:once_payment)
      stat.should_not be_nil
      stat['min'].should == 30
      stat['max'].should == 150
      stat['avg'].should == 90
    end
  end
  
end
