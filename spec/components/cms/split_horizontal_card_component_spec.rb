# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cms::SplitHorizontalCardComponent, type: :component do
  before do
    render_inline(described_class.new(
      section_title: Faker::Lorem.sentence,
      card_content: Cms::Mocks::Text::RichBlocks.as_model,
      aside_content: Cms::Mocks::Text::RichBlocks.as_model,
      aside_icon: Cms::Mocks::Images::Image.as_model,
      aside_title: Faker::Lorem.sentence
    ))
  end

  it "should render component" do
    expect(page).to have_css(".cms-split-horizontal-card-wrapper")
  end

  it "should render section title" do
    expect(page).to have_css(".govuk-heading-m")
  end
end
