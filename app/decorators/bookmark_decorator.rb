class BookmarkDecorator < ApplicationDecorator
  delegate_all
  decorates_finders
end
