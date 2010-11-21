# encoding: utf-8

PADRINO_ENV = 'test' unless defined?(PADRINO_ENV)
require File.expand_path(File.dirname(__FILE__) + "/../config/boot")

Rspec.configure do |conf|
  conf.include Rack::Test::Methods
end

def app
  ##
  # You can hanlde all padrino applications using instead:
  Padrino.application
  # Padquest.tap { |app|  }
end

def create_random_sheets(options = {})
  Sheet.destroy_all
  (options[:amount] || 2).times {|i|
    Sheet.create(
      {"frequency" => i%2 == 1 ? "yearly" : "none",
      "frequency_other" => "jak rikam",
      "time_spent" => (i+1)*10,
      "purpose_gathering" => (i%4) + 1,
      "purpose_hobbitry" => (i%4) + 1,
      "purpose_fuel" => (i%4) + 1,
      "purpose_relaxation" => (i%4) + 1,
      "favorite_place" => i%2 == 1 ? "Jizerské hory" : "Šumava",
      "once_receive" => (i+1)*20,
      "once_payment" => (i+1)*30,
      "important_nature" => (i%4) + 1,
      "important_wood" => (i%4) + 1,
      "important_gathering" => (i%4) + 1,
      "important_water" => (i%4) + 1,
      "important_climate" => (i%4) + 1,
      "important_health" => (i%4) + 1,
      "important_ground" => (i%4) + 1,
      "relation" => "none",
      "started_at" => Time.now - (i*90),
      "finished_at" => Time.now - (i*60)
    })
  }
end

def create_not_finished_sheet
  Sheet.create(
    {"frequency" => "yearly",
    "frequency_other" => "jak rikam",
    "time_spent" => 10,
    "purpose_gathering" => 1,
    "purpose_hobbitry" => 1,
    "purpose_fuel" => 1,
    "purpose_relaxation" => 1,
    "favorite_place" => "Jizerské hory",
    "once_receive" => 20,
    "once_payment" => 30,
    "important_nature" => 1,
    "important_wood" => 1,
    "important_gathering" => 1,
    "important_water" => 1,
    "important_climate" => 1,
    "important_health" => 1,
    "important_ground" => 1,
    "relation" => "none",
    "started_at" => Time.now
  })
end

# returns mocked account
def mock_account
  @account ||= mock(Account, mock_account_data)
end

def mock_account_data(stubs = nil)
  if stubs
    mock_account_data.merge stubs
  else
    @account_data ||= {
      'id' => "1",
      'role' => 'admin',
      'name' => 'god',
      'surname' => 'hides',
      'email' => 'god@laststar.eu'
    }
  end
end

# mocks admin login
def mock_admin_login
  Account.should_receive(:find).with(nil).and_return(mock_account) 
end
