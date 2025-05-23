module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          module Blocks
            class HomepageHero < StrapiMock
              strapi_component "blocks.homepage-hero"

              attribute(:title) { Faker::Lorem.sentence }
              attribute(:houseText) { Text::RichBlocks.generate_data }
              attribute(:buttons) { Array.new(2) { Buttons::NcceButton.generate_raw_data } }
            end
          end
        end
      end
    end
  end
end
