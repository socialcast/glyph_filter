module AlphabetFilter
  module ActiveRecordModelExtension
    extend ActiveSupport::Concern

    included do
      self.scope :letter_filter, Proc.new {|column, filter_letter|
        if filter_letter.blank?
          where({})
        elsif filter_letter == AlphabetFilter.config.punctuation
          where("#{table_name}.#{column} regexp '^[^#{AlphabetFilter.config.letters.join("|")}|#{AlphabetFilter.config.letters.map(&:downcase).join("|")}]'")
        else
          where("#{table_name}.#{column} like ?", filter_letter + "%")
        end
      }
      
    end
  end
end
