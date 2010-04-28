require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')

describe "BaseController" do
  context "Admin index" do
    before :each do
      Account.should_receive(:find).with(nil).and_return(mock(Account, {:id => 1, :role => 'admin'}))
    end
    it "should render index" do
      get '/admin'
      last_response.should be_ok
    end
  end
end

