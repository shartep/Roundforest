class ChangeFieldNameInReviews < ActiveRecord::Migration
  def up
    rename_column :reviews, :user_query_id, :product_id
  end

  def down
    rename_column :reviews, :product_id, :user_query_id
  end
end
