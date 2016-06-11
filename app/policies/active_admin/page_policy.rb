class ActiveAdmin::PagePolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def show?
    @user.has_role?(:admin)
  end
end