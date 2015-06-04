class TopicDecorator < ApplicationDecorator
  delegate_all
  decorates_finders
  decorates_association :user
  paginates_per 20

  def creation_date
    created_at.time.to_formatted_s(:long)
  end

  def author_name
    "#{user.first_name.titleize} #{user.last_name.titleize}"
  end

  def author_information
    "Created by: #{author_name} on #{creation_date}"
  end

  def bookmark_count
    object.bookmarks.count
  end

  def topic_link
    h.link_to object.title.titleize, h.topic_path(object)
  end

  def linked_title_with_count
    h.capture do
      h.concat "# "
      h.concat topic_link
      h.concat " ("
      h.concat bookmark_count
      h.concat ")"
    end
  end
end
