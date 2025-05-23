module Cms
  module Models
    module DynamicComponents
      module ContentBlocks
        class FileLink
          attr_accessor :url, :filename, :size, :updated_at

          def initialize(url:, filename:, size:, updated_at:)
            @url = url
            @filename = filename
            @size = size
            @updated_at = updated_at
          end

          def extension
            ::File.extname(url).delete(".").upcase
          end

          def file_size
            size
          end

          def render
            Cms::FileComponent.new(file: self)
          end
        end
      end
    end
  end
end
