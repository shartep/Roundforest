class CreateUserQueries < ActiveRecord::Migration
  def change
    create_table :user_queries do |t|
      t.references :product, index: true
      t.string :search_text

      t.timestamps null: false
    end
    add_foreign_key :user_queries, :products
  end
end
