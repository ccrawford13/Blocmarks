class ApplicationDecorator < Draper::Decorator
  delegate :current_page, :total_pages, :limit_value, to: :source
  def self.collection_decorator_class
    PaginatingDecorator
  end
end