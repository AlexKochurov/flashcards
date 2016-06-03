require 'rails_helper'

describe ActiveAdmin::ApplicationPolicy do
  subject { described_class }

  let(:user) do
    User.create(email: 'user@my.com', password: '12345', password_confirmation: '12345')
  end

  let(:admin) do
    a = User.create(email: 'admin@my.com', password: '12345', password_confirmation: '12345')
    a.add_role :admin
    a
  end

  permissions :index?, :show? do
    it "is imposible for user to see users' pages" do
      expect(subject).to_not permit(user, User)
    end

    it "is OK for admin to see users' pages" do
      expect(subject).to permit(admin, User)
    end
  end
end
