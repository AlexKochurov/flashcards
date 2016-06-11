require 'rails_helper'

describe ActiveAdmin::PagePolicy do
  subject { described_class }

  let(:user)  { create(:user) }
  let(:admin) { create(:admin_user) }

  permissions :show? do
    it "is imposible for user to see AA pages" do
      expect(subject).to_not permit(user)
    end

    it "is OK for admin to see AA pages" do
      expect(subject).to permit(admin)
    end
  end
end
