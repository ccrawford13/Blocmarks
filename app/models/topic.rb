class Topic < ActiveRecord::Base
  belongs_to :user
  has_many :bookmarks, dependent: :destroy
  validates_length_of :title, minimum: 5, maximum: 30
  default_scope { order(created_at: :desc) }
end
