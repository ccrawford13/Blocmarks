class BookmarkPolicy < ApplicationPolicy

  def create?
    user.present?
  end

  def edit?
    user.present? &&  record.user == user
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end
end