require "rails_helper"

RSpec.describe CSADash do
  let!(:csa) { instance_double(Programmes::CSAccelerator) }
  let(:dash) { described_class.new(user:, programme: csa) }
  let(:user) { instance_double(User) }

  describe "#user_programme_pathway" do
    it "calls pathway method on user" do
      allow(user).to receive(:programme_pathway)
      dash.user_programme_pathway
      expect(user).to have_received(:programme_pathway).with(csa)
    end
  end

  describe "#course_achievements" do
    it "calls through to course_achievements achievements method on programme" do
      allow(csa).to receive(:course_achievements)
      dash.course_achievements
      expect(csa).to have_received(:course_achievements).with(user)
    end
  end

  describe "#other_programme_pathways_for_user" do
    it "calls correct method on programme" do
      allow(csa).to receive(:pathways_excluding)
      pathway = instance_double(Pathway)
      allow(user).to receive(:programme_pathway) { pathway }

      dash.other_programme_pathways_for_user
      expect(csa).to have_received(:pathways_excluding).with(pathway)
    end
  end

  describe "#recommended_activities_for_user" do
    it "calls correct method on users pathway" do
      allow(csa).to receive(:pathways_excluding)
      pathway = instance_double(Pathway)
      allow(pathway).to receive(:recommended_activities_for_user)
      allow(user).to receive(:programme_pathway) { pathway }

      dash.recommended_activities_for_user
      expect(pathway)
        .to have_received(:recommended_activities_for_user)
        .with(user)
    end
  end

  describe "#enough_credits_for_test?" do
    it "calls method on programme" do
      allow(csa).to receive(:enough_credits_for_test?)
      dash.has_enough_activities_for_test
      expect(csa).to have_received(:enough_credits_for_test?).with(user)
    end
  end

  describe "#user_programme_assessment" do
    it "returns a new instance of UserProgrammeAssessment" do
      allow(UserProgrammeAssessment).to receive(:new)
      dash.user_programme_assessment
      expect(UserProgrammeAssessment).to have_received(:new).with(csa, user)
    end
  end
end
