# frozen_string_literal: true

class Cms::TestimonialComponentPreview < ViewComponent::Preview
  def default
    testimonial = Cms::Mocks::DynamicComponents::ContentBlocks::Testimonial.as_model

    render(testimonial.render)
  end
end
