class Product < ActiveRecord::Base
  require 'mechanize'

  has_many :reviews
  has_many :user_queries

  def reload_reviews
    agent = Mechanize.new
    reviews = []
    (1..20).each do |i|
      page = agent.get("https://www.walmart.com/reviews/product/#{self.code}?limit=20&page=#{i}&sort=relevancy")
      reviews += page.css('p.js-customer-review-text').to_a.map(&:content).uniq
    end
    reviews.uniq!
    diff = reviews - self.reviews.pluck(:content)
    diff.each { |review| self.reviews.build(content: review) }

    self.save!
  end
end
