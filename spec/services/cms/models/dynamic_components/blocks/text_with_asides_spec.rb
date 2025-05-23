require "rails_helper"

RSpec.describe Cms::Models::DynamicComponents::Blocks::TextWithAsides do
  before do
    @text_with_asides = Cms::Providers::Strapi::Factories::ComponentFactory.process_component(
      Cms::Mocks::DynamicComponents::Blocks::TextWithAsides.generate_raw_data
    )
  end

  it "should render as CmsTextWithAsides" do
    expect(@text_with_asides.render).to be_a(Cms::TextWithAsidesComponent)
  end
end
