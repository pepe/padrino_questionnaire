# encoding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')

describe "SheetController" do
  it "should render index" do
    mock_admin_login
    get '/admin/sheets'
  end
  
end
