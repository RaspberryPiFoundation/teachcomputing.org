# frozen_string_literal: true

class EnrolmentConfirmationComponent < ViewComponent::Base
  attr_reader :logged_in_button_text, :logged_out_button_text

  delegate :auth_url, :current_user, to: :helpers

  def initialize(programme:, full_width: true, logged_in_button_text: "Enrol", logged_out_button_text: "Log in", pathway: nil)
    @programme = programme
    @full_width = full_width
    @logged_in_button_text = logged_in_button_text
    @logged_out_button_text = logged_out_button_text
    @pathway = pathway
  end

  def button_classes
    classes = ["govuk-button button"]
    classes << "button--full-width" if @full_width
    classes
  end
end
