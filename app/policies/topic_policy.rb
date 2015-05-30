class TopicPolicy < ApplicationPolicy

  def index?
    true
  end

  def create?
    user.present?
  end

  def edit?
    user.present? && (record.user == user)
  end

  def update?
    update?
  end

  def destroy?
    update?
  end
end