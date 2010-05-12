# encoding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')

describe "QuestionnaireController" do
  context "Home page" do
    it "should render page with basic informations" do
      get '/'
      last_response.should be_ok
    end
  end
  context "Questionnaire" do
    before(:each) do
      @sheet = Sheet.start_new
      @sheet.save
      @uid = @sheet.id
    end

    it "should render first part of form" do
      get '/first_part/' + @uid
      last_response.should be_ok
    end

    it "should save first part parameters" do
      post '/save_first/' + @uid, 'questionnaire' => {'frequency' => 'none'}
      last_response.should be_redirect
    end

    it "should render second part of form" do
      get '/second_part/' + @uid
      last_response.should be_ok
    end

    it "should save second part parameters" do
      post '/save_second/' + @uid, 'questionnaire' => {'relation' => 'none'}
      last_response.should be_redirect
    end

    it "should render thanks page" do
      get '/thanks/' + @uid
      last_response.should be_ok
    end

    it "should save final part parameters" do
      post '/save_final/' + @uid, 'questionnaire' => {'email' => 'none'}
      last_response.should be_redirect
    end

  end
  # TODO move to its own controller
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
      @uid = @sheet.id
    end

    it "should show printable version of what was filled" do
      @sheet.finish
      get '/print/' + @uid
      last_response.should be_ok
    end

    it "should render list of all filled in questionnaires" do
      get '/list'     
      last_response.should be_ok
    end

    it "should render page with simple statistics" do
      get '/stats'
      last_response.should be_ok
    end
  end
end
