class CreateArticleUpvotes < ActiveRecord::Migration[5.2]
  def change
    create_table :article_upvotes do |t|
      t.timestamps
    end
  end
end
