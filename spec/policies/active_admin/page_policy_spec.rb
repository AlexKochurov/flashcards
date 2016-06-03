require 'rails_helper'

describe ActiveAdmin::PagePolicy do
  subject { described_class }

  let(:user) do
    User.create(email: 'user@my.com', password: '12345', password_confirmation: '12345')
  end

  let(:admin) do
    a = User.create(email: 'admin@my.com', password: '12345', password_confirmation: '12345')
    a.add_role :admin
    a
  end

  permissions :show? do
    it "is imposible for user to see AA pages" do
      expect(subject).to_not permit(user)
    end

    it "is OK for admin to see AA pages" do
      expect(subject).to permit(admin)
    end
  end
end
