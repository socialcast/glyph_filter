module AlphabetFilter
  module ActionViewExtension
    extend ::ActiveSupport::Concern
    module InstanceMethods
      def alphabet_filter(options = {})
        options.reverse_merge! :current_class => "current", :container_class => "pagination_wrapper", :parent_class => "pagination", :param_name => AlphabetFilter.config.param_name, :all => AlphabetFilter.config.all, :punctuation => AlphabetFilter.config.punctuation, :all_class => "all", :excluded_params => [:page]
        
        links=[]
        ([AlphabetFilter.config.all] + AlphabetFilter.config.letters + [AlphabetFilter.config.punctuation]).each do |letter|
          new_params = params.except(options[:excluded_params])
          case letter
          when AlphabetFilter.config.all
            if !new_params[options[:param_name].to_sym]
              links << content_tag(:span, I18n.t(letter), :class => "#{options[:all_class]} #{options[:current_class]}")
            else
              links << link_to(I18n.t(letter), url_for(new_params.except(options[:param_name].to_sym)), :class => options[:all_class])
            end
          else
            if new_params[options[:param_name].to_sym] && letter == new_params[options[:param_name].to_sym].upcase
              links << content_tag(:span, letter, :class => options[:current_class])
            else
              links << link_to(letter, url_for(new_params.merge(options[:param_name].to_sym => letter)))
            end
          end
        end
        content_tag(:div, :class => options[:container_class]) do
          content_tag(:div, links.join(' ').html_safe, :class => options[:parent_class])
        end
      end
    end
  end
end