# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_08_26_061336) do

  create_table "ingredients", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "image_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "recipe_ingredients", primary_key: ["recipe_id", "ingredient_id"], options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "recipe_id", null: false
    t.bigint "ingredient_id", null: false
    t.decimal "amount", precision: 10
    t.string "unit"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ingredient_id"], name: "index_recipe_ingredients_on_ingredient_id"
    t.index ["recipe_id"], name: "index_recipe_ingredients_on_recipe_id"
  end

  create_table "recipe_tags", primary_key: ["recipe_id", "tag_id"], options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "recipe_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["recipe_id"], name: "index_recipe_tags_on_recipe_id"
    t.index ["tag_id"], name: "index_recipe_tags_on_tag_id"
  end

  create_table "recipes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title", null: false
    t.string "description", null: false
    t.string "step", null: false
    t.string "image_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tags", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "image_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "week_recipes", primary_key: ["user_id", "start_date"], options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.date "start_date", null: false
    t.bigint "saturday_recipe_id", null: false
    t.bigint "sunday_recipe_id", null: false
    t.bigint "monday_recipe_id", null: false
    t.bigint "tuesday_recipe_id", null: false
    t.bigint "wednesday_recipe_id", null: false
    t.bigint "thursday_recipe_id", null: false
    t.bigint "friday_recipe_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["friday_recipe_id"], name: "friday_recipe_id"
    t.index ["monday_recipe_id"], name: "monday_recipe_id"
    t.index ["saturday_recipe_id"], name: "saturday_recipe_id"
    t.index ["sunday_recipe_id"], name: "sunday_recipe_id"
    t.index ["thursday_recipe_id"], name: "thursday_recipe_id"
    t.index ["tuesday_recipe_id"], name: "tuesday_recipe_id"
    t.index ["user_id"], name: "index_week_recipes_on_user_id"
    t.index ["wednesday_recipe_id"], name: "wednesday_recipe_id"
  end

  add_foreign_key "recipe_ingredients", "ingredients"
  add_foreign_key "recipe_ingredients", "recipes"
  add_foreign_key "recipe_tags", "recipes"
  add_foreign_key "recipe_tags", "tags"
  add_foreign_key "week_recipes", "recipes", column: "friday_recipe_id", name: "friday_recipe_id"
  add_foreign_key "week_recipes", "recipes", column: "monday_recipe_id", name: "monday_recipe_id"
  add_foreign_key "week_recipes", "recipes", column: "saturday_recipe_id", name: "saturday_recipe_id"
  add_foreign_key "week_recipes", "recipes", column: "sunday_recipe_id", name: "sunday_recipe_id"
  add_foreign_key "week_recipes", "recipes", column: "thursday_recipe_id", name: "thursday_recipe_id"
  add_foreign_key "week_recipes", "recipes", column: "tuesday_recipe_id", name: "tuesday_recipe_id"
  add_foreign_key "week_recipes", "recipes", column: "wednesday_recipe_id", name: "wednesday_recipe_id"
  add_foreign_key "week_recipes", "users"
end
