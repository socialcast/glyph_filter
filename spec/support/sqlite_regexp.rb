# user-defined function to add regexp support for sqlite (from wherex gem)
RSpec.configure do |config|
  config.before :all do
    if ::ActiveRecord::Base.connection.raw_connection.respond_to? :create_function
      ::ActiveRecord::Base.connection.raw_connection.create_function( "regexp", 2 ) do |context, pattern, string|
        if string.present?
          context.result = 1 if string.match pattern
        end
      end
    end
  end
end
