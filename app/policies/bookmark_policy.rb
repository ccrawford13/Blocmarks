class BookmarkPolicy < ApplicationPolicy

  def create?
    user.present?
  end

  def edit?
    @topic = record.topic
    user.present? && record.topic_id = @topic.id
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end
end