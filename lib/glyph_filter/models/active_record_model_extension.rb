module GlyphFilter
  module ActiveRecordModelExtension
    extend ActiveSupport::Concern

    included do
      self.scope :letter_filter, Proc.new {|column, filter_letter|
        if filter_letter.blank?
          where({})
        elsif filter_letter == GlyphFilter.config.left_over
          where("#{table_name}.#{column} regexp '^[^#{GlyphFilter.config.letters.join("|")}|#{GlyphFilter.config.letters.map(&:downcase).join("|")}]'")
        else
          where("#{table_name}.#{column} like ?", filter_letter + "%")
        end
      }
      
    end
  end
end
