class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :user_query, index: true
      t.text :content

      t.timestamps null: false
    end
    add_foreign_key :reviews, :user_queries
  end
end
