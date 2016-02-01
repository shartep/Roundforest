class UserQuery < ActiveRecord::Base
  belongs_to :product
  has_many :reviews, ->(user_query) { where('LOWER(content) LIKE LOWER(?)', "%#{user_query.search_text}%") }, through: :product

  after_create -> { self.product.reload_reviews }
end