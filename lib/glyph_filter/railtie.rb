require 'rails'
require 'wherex'

require 'glyph_filter/config'
require 'glyph_filter/helpers/action_view_extension'

module GlyphFilter
  class Railtie < ::Rails::Railtie #:nodoc:
    initializer 'glyph_filter' do |app|
      ActiveSupport.on_load(:active_record) do
        require 'glyph_filter/models/active_record_extension'
        ::ActiveRecord::Base.send :include, GlyphFilter::ActiveRecordExtension
      end

      ActiveSupport.on_load(:action_view) do
        ::ActionView::Base.send :include, GlyphFilter::ActionViewExtension
      end
    end
  end
end