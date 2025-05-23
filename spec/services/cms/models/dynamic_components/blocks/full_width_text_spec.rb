require "rails_helper"

RSpec.describe Cms::Models::DynamicComponents::Blocks::FullWidthText do
  before do
    @text = Cms::Providers::Strapi::Factories::ComponentFactory.process_component(
      Cms::Mocks::DynamicComponents::Blocks::FullWidthText.generate_raw_data
    )
  end

  it "should render as FullWidthTextBlockComponent" do
    expect(@text.render).to be_a(Cms::FullWidthTextBlockComponent)
  end
end
