class UserDecorator < ApplicationDecorator
  delegate_all
  decorates_finders
  decorates_association :bookmarks
  paginates_per 10

  def full_name
    "#{first_name.titleize} #{last_name.titleize}"
  end

  def like_count
    likes.count
  end
end
