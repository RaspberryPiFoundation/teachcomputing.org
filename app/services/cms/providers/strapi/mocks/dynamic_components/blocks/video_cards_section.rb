module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          module Blocks
            class VideoCardsSection < StrapiMock
              strapi_component "blocks.video-cards-section"
              attribute(:cardsPerRow) { 3 }
              attribute(:title) { Faker::Lorem.sentence }
              attribute(:introText) { Text::RichBlocks.generate_data }
              attribute(:bkColor) { Meta::ColorScheme.generate_data(name: "light-grey") }
              attribute(:videoCards) { Array.new(3) { DynamicComponents::ContentBlocks::VideoCard.generate_data } }
            end
          end
        end
      end
    end
  end
end
