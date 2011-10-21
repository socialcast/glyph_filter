require 'rails'

require 'alphabet_filter/config'
require 'alphabet_filter/helpers/action_view_extension'

module AlphabetFilter
  class Railtie < ::Rails::Railtie #:nodoc:
    initializer 'alphabet_filter' do |app|
      ActiveSupport.on_load(:active_record) do
        require 'alphabet_filter/models/active_record_extension'
        ::ActiveRecord::Base.send :include, AlphabetFilter::ActiveRecordExtension
      end

      ActiveSupport.on_load(:action_view) do
        ::ActionView::Base.send :include, AlphabetFilter::ActionViewExtension
      end
    end
  end
end