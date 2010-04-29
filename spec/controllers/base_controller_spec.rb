require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')

describe "BaseController" do
  context "Admin index" do
    before :each do
      mock_admin_login
    end
    it "should render index" do
      get '/admin'
      last_response.should be_ok
    end
  end
end

