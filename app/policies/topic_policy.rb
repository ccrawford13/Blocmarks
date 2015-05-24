class TopicPolicy < ApplicationPolicy

  def index?
    true
  end

  def create?
    user.present?
  end

  def update?
    user.present? && record.user == user
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end
end