class LikeDecorator < ApplicationDecorator
  delegate_all
  decorates_finders
  paginates_per 5
  
  def author_output
    h.capture do
      h.concat author_message
      h.concat " "
      h.concat author_link
    end
  end

  def author_message
    "Bookmark created by:"
  end

  def author_name
    "#{object.bookmark.user.first_name.titleize} #{object.bookmark.user.last_name.titleize}"
  end

  def author_link
    h.link_to author_name, h.user_path(object.bookmark.user)
  end

end
