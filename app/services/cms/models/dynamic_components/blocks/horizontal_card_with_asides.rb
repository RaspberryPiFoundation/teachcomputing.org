module Cms
  module Models
    module DynamicComponents
      module Blocks
        class HorizontalCardWithAsides
          attr_accessor :text, :button, :aside_sections, :background_color, :color_theme

          def initialize(text:, button:, aside_sections:, background_color:, color_theme:)
            @text = text
            @button = button
            @aside_sections = aside_sections
            @background_color = background_color
            @color_theme = color_theme
          end

          def render
            Cms::HorizontalCardWithAsidesComponent.new(text:, button:, aside_sections:, background_color:, color_theme:)
          end
        end
      end
    end
  end
end
