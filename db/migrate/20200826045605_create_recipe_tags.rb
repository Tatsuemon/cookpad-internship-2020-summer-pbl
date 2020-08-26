class CreateRecipeTags < ActiveRecord::Migration[6.0]
  def change
    create_table :recipe_tags, primary_key: ["recipe_id", "tag_id"] do |t|
      t.references :recipe, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true
      t.timestamps
    end
  end
end
