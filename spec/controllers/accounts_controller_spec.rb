require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')

describe "AccountsController" do
  context "Accounts index" do
    before :each do
      Account.should_receive(:find).with(nil).and_return(mock_account)
      Account.should_receive(:find).with(:all).and_return([mock_account])
      get '/admin/accounts'
    end
    it "should render index" do
      last_response.should be_ok
    end
  end
  context "New account" do
    it "should render new form" do
      Account.should_receive(:find).with(nil).and_return(mock_account)
      # TODO should be checked why
      Account.should_receive(:new).twice
      get '/admin/accounts/new'
      last_response.should be_ok
    end
  end
  context "Create account" do
    before :each do
      Account.should_receive(:find).with(nil).and_return(mock_account)
    end
    it "should redirect when account valid" do
      Account.should_receive(:new).and_return(mock_account)
      mock_account.should_receive(:save).and_return(true)
      post '/admin/accounts/create', :acount => mock_account_data
      last_response.should be_redirect
    end
    it "should render edit when account invalid" do
      Account.should_receive(:find).with(:first, {:conditions=>{:email=>nil}}).and_return(nil)
      post '/admin/accounts/create', {}
      last_response.should be_ok
    end
  end
  context "New " do
    it "should render edit form" do
      Account.should_receive(:find).with(nil).and_return(mock_account)
      Account.should_receive(:find).with("1").and_return(Account.new(mock_account_data))
      get '/admin/accounts/edit/1'
      last_response.should be_ok
    end
  end
  context "Update account" do
    before :each do
      Account.should_receive(:find).with(nil).and_return(mock_account)
    end
    it "should redirect when account valid" do
      Account.should_receive(:find).with("1").and_return(mock_account)
      mock_account.should_receive(:update_attributes).with(mock_account_data).and_return(true)
      put '/admin/accounts/update/1', :account => mock_account_data
      last_response.should be_redirect
    end
    it "should render edit when account invalid" do
      Account.should_receive(:find).with("1").and_return(Account.new)
      Account.should_receive(:find).with(:first, {:conditions=>{:email=>nil}}).and_return(nil)
      put '/admin/accounts/update/1'
      last_response.should be_ok
    end
  end
  context "New " do
    it "should kill account number 2" do
      Account.should_receive(:find).with(nil).and_return(mock_account)
      account_to_kill = mock(Account, mock_account_data('id' => '2'))
      account_to_kill.should_receive(:destroy).and_return(true)
      Account.should_receive(:find).with("2").and_return(account_to_kill)
      delete '/admin/accounts/destroy/2'
      last_response.should be_redirect
    end
    it "should not kill account number 1" do
      Account.should_receive(:find).with(nil).and_return(mock_account)
      Account.should_receive(:find).with("1").and_return(mock_account)
      mock_account.should_not_receive(:destroy)
      delete '/admin/accounts/destroy/1'
      last_response.should be_redirect
    end
  end
end

