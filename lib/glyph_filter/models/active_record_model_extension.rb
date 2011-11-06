module GlyphFilter
  module ActiveRecordModelExtension
    extend ActiveSupport::Concern

    included do
      self.scope :glyph_filter, Proc.new {|column, glyph|
        if glyph.blank?
          where({})
        elsif glyph == GlyphFilter.config.left_over
          where(column => /^[^#{(GlyphFilter.config.glyphs + GlyphFilter.config.glyphs.map(&:downcase)).uniq.join("|")}]/)
        else
          a_table = self.arel_table
          where(a_table[column.to_sym].matches(glyph + "%"))
        end
      }
      
    end
  end
end
