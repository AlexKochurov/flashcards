require 'rails_helper'

describe ActiveAdmin::ApplicationPolicy do
  subject { described_class }

  let(:user)  { create(:user) }
  let(:admin) { create(:admin_user) }

  permissions :index?, :show? do
    it "is imposible for user to see users' pages" do
      expect(subject).to_not permit(user, User)
    end

    it "is OK for admin to see users' pages" do
      expect(subject).to permit(admin, User)
    end
  end
end
