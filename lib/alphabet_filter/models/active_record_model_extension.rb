module AlphabetFilter
  module ActiveRecordModelExtension
    extend ActiveSupport::Concern

    included do
      self.send(:include, AlphabetFilter::ConfigurationMethods)

      self.scope :letter_filter, Proc.new {|column, filter_letter|
        return where({}) if filter_letter.blank?
        return where("#{table_name}.#{column} regexp '^[^#{letters.join("|")}|#{letters.map(&:downcase).join("|")}]'") if filter_letter == punctuation
        where("#{table_name}.#{column} like ?", filter_letter + "%")
      }
      
    end
  end
end
