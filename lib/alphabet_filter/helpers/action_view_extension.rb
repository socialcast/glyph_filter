module AlphabetFilter
  module ActionViewExtension
    extend ::ActiveSupport::Concern
    module InstanceMethods
      def alphabet_filter(options = {}, &block)
        filter_section = AlphabetFilter::Helpers::FilterSection.new(self, options.reverse_merge(:param_name => AlphabetFilter.config.param_name, :all => AlphabetFilter.config.all, :left_over => AlphabetFilter.config.left_over, :excluded_params => [:page], :letters => AlphabetFilter.config.letters, :current_section => params[AlphabetFilter.config.param_name] ? params[AlphabetFilter.config.param_name] : AlphabetFilter.config.all))
        filter_section.to_s
      end
    end
  end
end