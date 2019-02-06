class Sub < ApplicationRecord
  validates :title, :user_id, presence: true 
  validates :title, uniqueness: true

  belongs_to :moderator,
  primary_key: :id,
  foreign_key: :user_id, 
  class_name: :User

  has_many :post_subs

  has_many :posts, 
  through: :post_subs,
  source: :post

end

