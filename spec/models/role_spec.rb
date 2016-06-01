require 'rails_helper'

RSpec.describe Role, type: :model do
  it "creates the role object when add new role to user" do
    initial_amount = Role.count
    user = User.create(email: 't@t.com', password: '12345', password_confirmation: '12345')
    user.add_role :absolutely_new_role

    expect(Role.count).to equal(initial_amount + 1)
  end
end
