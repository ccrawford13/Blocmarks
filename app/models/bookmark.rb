class Bookmark < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  belongs_to :topic, dependent: :destroy
  
  # validates_presence_of :user
  validates_presence_of :topic
  validates_presence_of :description
  validates_length_of :description, minimum: 3
  validates :url, :format => URI::regexp(%w(http https))
end
