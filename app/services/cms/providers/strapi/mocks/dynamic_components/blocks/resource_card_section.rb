module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          module Blocks
            class ResourceCardSection < StrapiMock
              strapi_component "blocks.resource-card-section"
              attribute(:cardsPerRow) { 3 }
              attribute(:sectionTitle) { Faker::Lorem.sentence }
              attribute(:introText) { Text::RichBlocks.generate_data }
              attribute(:colorTheme) { nil }
              attribute(:resourceCards) { Array.new(3) { DynamicComponents::ContentBlocks::ResourceCard.generate_data } }
            end
          end
        end
      end
    end
  end
end
