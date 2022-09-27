# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_09_27_015952) do
  create_table "blog_contents", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "blogs_id", null: false
    t.bigint "blog_titles_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blog_titles_id"], name: "index_blog_contents_on_blog_titles_id"
    t.index ["blogs_id"], name: "index_blog_contents_on_blogs_id"
  end

  create_table "blog_sub_heading_contents", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "blog_id", null: false
    t.bigint "blog_title_id", null: false
    t.bigint "blog_sub_heading_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blog_id"], name: "index_blog_sub_heading_contents_on_blog_id"
    t.index ["blog_sub_heading_id"], name: "index_blog_sub_heading_contents_on_blog_sub_heading_id"
    t.index ["blog_title_id"], name: "index_blog_sub_heading_contents_on_blog_title_id"
  end

  create_table "blog_sub_headings", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "blogs_id", null: false
    t.bigint "blog_titles_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blog_titles_id"], name: "index_blog_sub_headings_on_blog_titles_id"
    t.index ["blogs_id"], name: "index_blog_sub_headings_on_blogs_id"
  end

  create_table "blog_titles", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "blogs_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blogs_id"], name: "index_blog_titles_on_blogs_id"
  end

  create_table "blogs", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "users_id", null: false
    t.string "name"
    t.string "blog_logo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["users_id"], name: "index_blogs_on_users_id"
  end

  create_table "users", charset: "utf8mb3", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password"
    t.integer "user_level", limit: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "blog_contents", "blog_titles", column: "blog_titles_id"
  add_foreign_key "blog_contents", "blogs", column: "blogs_id"
  add_foreign_key "blog_sub_heading_contents", "blog_sub_headings"
  add_foreign_key "blog_sub_heading_contents", "blog_titles"
  add_foreign_key "blog_sub_heading_contents", "blogs"
  add_foreign_key "blog_sub_headings", "blog_titles", column: "blog_titles_id"
  add_foreign_key "blog_sub_headings", "blogs", column: "blogs_id"
  add_foreign_key "blog_titles", "blogs", column: "blogs_id"
  add_foreign_key "blogs", "users", column: "users_id"
end
