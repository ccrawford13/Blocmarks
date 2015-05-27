class Topic < ActiveRecord::Base
  belongs_to :user
  has_many :bookmarks
  validates_length_of :title, minimum: 5
end
