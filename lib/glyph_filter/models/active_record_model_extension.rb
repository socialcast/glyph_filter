module GlyphFilter
  module ActiveRecordModelExtension
    extend ActiveSupport::Concern

    included do
      self.scope :glyph_filter, Proc.new {|column, glyph|
        if glyph.blank?
          where({})
        elsif glyph == GlyphFilter.config.left_over
          where("#{table_name}.#{column} regexp '^[^#{(GlyphFilter.config.glyphs + GlyphFilter.config.glyphs.map(&:downcase)).uniq.join("|")}]'")
        else
          where("#{table_name}.#{column} LIKE ?", glyph + "%")
        end
      }
      
    end
  end
end
