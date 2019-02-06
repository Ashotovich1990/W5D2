class Comment < ApplicationRecord
  validates :content, :user_id, :post_id, null: false 

  belongs_to :author, 
  primary_key: :id,
  foreign_key: :user_id,
  class_name: :User 

  belongs_to :post 

  has_many :child_comments,
  primary_key: :id,
  foreign_key: :parent_comment_id,
  class_name: :Comment 
  
  belongs_to :comment, 
  primary_key: :id,
  foreign_key: :parent_comment_id,
  class_name: :Comment,
  optional: true


end
