class ApplicationDecorator < Draper::Decorator
  delegate :current_page, :total_pages, :limit_value, to: :source
  def self.collection_decorator_class
    PaginatingDecorator
  end

  def creation_date
    created_at.strftime("%a %b %d, %I:%M%p")
  end
end