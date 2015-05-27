class Topic < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  has_many :bookmarks
  validates_length_of :title, minimum: 5, maximum: 20
end
