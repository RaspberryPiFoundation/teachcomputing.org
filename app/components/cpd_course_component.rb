class CpdCourseComponent < ViewComponent::Base
  attr_reader :activity, :current_user, :course, :last_margin, :achievement

  delegate :activity_icon_class,
    :activity_type,
    to: :helpers

  def initialize(activity:, current_user:, last_margin: true)
    @current_user = current_user
    @last_margin = last_margin

    if activity.replaced_by
      begin
        @activity = activity
        @course = Achiever::Course::Template.find_by_activity_code(@activity.stem_activity_code)
      rescue ActiveRecord::RecordNotFound
        @activity = activity.replaced_by
        @course = Achiever::Course::Template.maybe_find_by_activity_code(@activity.stem_activity_code)
      end
    else
      @activity = activity
      @course = Achiever::Course::Template.maybe_find_by_activity_code(@activity.stem_activity_code) if @activity.stem_activity_code.present?
    end

    @achievement = current_user.achievements.to_a.find { _1.activity_id == @activity.id }
  end
end
