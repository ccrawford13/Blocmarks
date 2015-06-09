class Bookmark < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic
  has_many :likes, dependent: :destroy
  
  # validates_presence_of :user
  validates_presence_of :topic
  validates_presence_of :description
  validates_length_of :description, minimum: 3, maximum: 30;
  validates_presence_of :url
  validates :url, :format => URI::regexp(%w(http https))

  default_scope { order(created_at: :desc) }
end
