# encoding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')

describe "SheetsController" do
  before :each do
    mock_admin_login
  end
  it "should render index" do
    get '/admin/sheets'
    last_response.should be_ok
  end

  it "should render new" do
    get '/admin/sheets/new'
    last_response.should be_ok
  end

  it "should render edit" do
    Sheet.should_receive(:find).with('1').and_return(Sheet.new(:id => 1))
    get '/admin/sheets/edit/1'
    last_response.should be_ok
  end

end
