$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rails'
require 'sqlite3'
require 'glyph_filter'
require 'database_cleaner'

require 'fake_app'

require 'rspec/rails'
# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.mock_with :rr
  config.before :all do
    CreateAllTables.up unless ActiveRecord::Base.connection.table_exists? 'users'
  end
end