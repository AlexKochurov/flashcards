require 'rails_helper'

describe Role do
  let(:user) { User.create(email: 't@t.com',
                           password: '12345', password_confirmation: '12345') }

  it "creates the role object when add new role to user" do
    expect { user.add_role :absolutely_new_role }.to change{ Role.count }.by(1)
  end

  it "detects when user hasn't role" do
    expect(user.has_role? :admin).to be_falsey
  end

  it "detects when user has role" do
    user.add_role :admin
    expect(user.has_role? :admin).to be_truthy
  end
end
