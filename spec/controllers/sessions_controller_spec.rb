require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')

describe "SessionsController" do
  context "New session" do
    it "should render login form" do
      get '/admin/sessions/new'
      last_response.should be_ok
    end
  end
  context "Creating session" do
    before(:each) do
      Account.should_receive(:authenticate).with('example@example.com', 'secret').and_return(mock(Account, {:id => 1}))
    end
    it "should try to authenticate and redirect to /admin" do
      post '/admin/sessions/create', {:email => 'example@example.com', :password => 'secret'}
      last_response.should be_redirect
      last_response.headers["Location"].should == '/admin/'
    end
  end
  context "Destroying session" do
    it "should destroy session and redirect to login form" do
      get '/admin/sessions/destroy'
      last_response.should be_redirect
      last_response.headers["Location"].should == '/admin/sessions/new'
    end
  end
end
