require "rails_helper"

RSpec.describe Cms::Models::DynamicComponents::ContentBlocks::VideoCard do
  before do
    @card_section = Cms::Providers::Strapi::Factories::ComponentFactory.process_component(
      Cms::Mocks::DynamicComponents::Blocks::VideoCardsSection.generate_raw_data
    )
  end

  it "should render as Cms::CardWrapperComponent" do
    expect(@card_section.render).to be_a(Cms::CardWrapperComponent)
  end

  it "should render cards as Cms::VideoCardComponent" do
    expect(@card_section.cards_block.first.render).to be_a(Cms::VideoCardComponent)
  end
end
