require 'alphabet_filter/models/active_record_model_extension'

module AlphabetFilter
  module ActiveRecordExtension
    extend ActiveSupport::Concern
    included do
      # Future subclasses will pick up the model extension
      def self.inherited(kls) #:nodoc:
        super
        kls.send(:include, AlphabetFilter::ActiveRecordModelExtension) if kls.superclass == ActiveRecord::Base
      end

      # Existing subclasses pick up the model extension as well
      self.descendants.each do |kls|
        kls.send(:include, AlphabetFilter::ActiveRecordModelExtension) if kls.superclass == ActiveRecord::Base
      end
    end
  end
end