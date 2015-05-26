class BookmarkPolicy < ApplicationPolicy

  def create?
    user.present?
  end
end