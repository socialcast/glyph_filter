require 'glyph_filter/models/active_record_model_extension'

module GlyphFilter
  module ActiveRecordExtension
    extend ActiveSupport::Concern
    included do
      # Future subclasses will pick up the model extension
      class << self
        def inherited_with_glyph_filter(kls) #:nodoc:
          inherited_without_glyph_filter kls
          kls.send(:include, GlyphFilter::ActiveRecordModelExtension) if kls.superclass == ActiveRecord::Base
        end
        alias_method_chain :inherited, :glyph_filter
      end

      # Existing subclasses pick up the model extension as well
      self.descendants.each do |kls|
        kls.send(:include, GlyphFilter::ActiveRecordModelExtension) if kls.superclass == ActiveRecord::Base
      end
    end
  end
end