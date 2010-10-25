source :rubygems

# Project requirements
gem 'rake'
gem 'rack-flash'
gem 'thin' # or mongrel
gem 'vlad'
gem 'vlad-git'

# Component requirements
gem 'haml'
gem 'mongoid', '>=2.0.0.beta.19'
gem 'bson_ext', '>=1.1.1'

# Test requirements
group :test do
  gem "rspec-core", '~>2.0.0'
  gem "rspec-expectations", '~>2.0.0'
  gem "rspec-mocks", '~>2.0.0'
  gem 'capybara'
  gem 'cucumber'
  gem 'rack-test', :require => 'rack/test', :group => 'test'
  gem 'autotest'
  gem 'ruby-debug19'
  gem 'autotest-fsevent' if RUBY_PLATFORM.include? "darwin10"
end

# Padrino
gem 'padrino', '=0.9.18'

# Pepe
gem 'writeexcel'
