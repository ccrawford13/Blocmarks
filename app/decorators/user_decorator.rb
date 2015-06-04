class UserDecorator < ApplicationDecorator
  delegate_all
  decorates_finders
  paginates_per 10

  def full_name
    [first_name, last_name].join(" ").titleize
  end

  def like_count
    likes.count
  end

  def topic_count
    topics.count
  end
end
