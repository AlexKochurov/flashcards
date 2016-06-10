require 'rails_helper'

describe Role do
  let(:user)  { create(:user) }
  let(:admin) { create(:admin_user) }

  it "creates the role object when add new role to user" do
    expect { user.add_role :absolutely_new_role }.to change{ Role.count }.by(1)
  end

  it "detects when user hasn't role" do
    expect(user.has_role? :admin).to be_falsey
  end

  it "detects when user has role" do
    expect(admin.has_role? :admin).to be_truthy
  end
end
