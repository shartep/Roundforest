class UserQuery < ActiveRecord::Base
  require 'net/http'

  has_many :reviews

  after_create :load_reviews

  def load_reviews
    source = Net::HTTP.get('www.walmart.com', "/ip/#{self.product_id}")
    html_doc = Nokogiri::HTML(source)
    cur_reviews = html_doc.css('div.customer-review-text').css('p.js-customer-review-text').to_a.map(&:content).uniq

    cur_reviews.each {|review| self.reviews.build(content: review)}

    self.save!
  end
end