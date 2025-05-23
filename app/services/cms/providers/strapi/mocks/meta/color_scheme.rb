module Cms
  module Providers
    module Strapi
      module Mocks
        module Meta
          class ColorScheme
            def self.generate_data(name: "standard")
              {
                id: 1,
                attributes: generate_raw_data(name: name)
              }
            end

            def self.generate_raw_data(name: "standard")
              {
                name: name,
                publicName: "TC Green"
              }
            end
          end
        end
      end
    end
  end
end
