class Product < ActiveRecord::Base
  has_many :reviews
  has_many :user_queries

  def reload_reviews
    page = Mechanize.new.get("https://www.walmart.com/reviews/product/#{self.code}")
    reviews = page.css('p.js-customer-review-text').to_a.map(&:content).uniq

    diff = reviews - self.reviews.pluck(:content)
    diff.each { |review| self.reviews.build(content: review) }

    self.save!
  end
end
