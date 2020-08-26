class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.string :title, null:false
      t.string :description, null:false
      t.string :step, null:false
      t.string :image_url
      t.timestamps
    end
  end
end
