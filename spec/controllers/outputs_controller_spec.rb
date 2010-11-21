# encoding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')

describe "QutputsController" do
  context "Outputs" do
    before(:each) do
      @sheet = Sheet.start_new
      @sheet.update_attributes(
        {"frequency" => "vůbec",
        "important_wood" => 5,
        "important_gathering" => 5,
        "frequency_other" => "",
        "relation" => "none",
        "once_receive" => "",
        "time_spent" => 5,
        "purpose_hobbitry" => 5,
        "favorite_place" => "favorite_place",
        "important_ground" => 5,
        "important_nature" => 5,
        "purpose_fuel" => 5,
        "purpose_relaxation" => 5,
        "important_water" => 5,
        "important_climate" => 5,
        "important_health" => 5,
        "purpose_gathering" => 5,
        "once_payment" => 10})
      @sheet.finish
      @uid = @sheet.id.to_s
    end

    it "shows printable version of what was filled" do
      @sheet.finish
      get '/print/' + @uid
      last_response.should be_ok
    end

    it "renders list of all filled in questionnaires" do
      get '/list'     
      last_response.should be_ok
    end

    it "renders page with simple statistics" do
      get '/stats'
      last_response.should be_ok
    end

    it "serves CSV file with all questionnaires" do
      get '/list.csv'
      last_response.should be_ok
    end
  end
end
