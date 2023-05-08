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

ActiveRecord::Schema.define(version: 2023_01_14_111957) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.string "body"
    t.integer "user_id"
    t.integer "question_id"
  end

  create_table "genres", force: :cascade do |t|
    t.string "name"
  end

  create_table "grades", force: :cascade do |t|
    t.string "name"
  end

  create_table "question_tags", force: :cascade do |t|
    t.integer "question_id"
    t.integer "tag_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "body"
    t.string "image"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "user_id"
    t.integer "subject_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.string "name"
    t.integer "genre_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
  end

  create_table "user_questions", force: :cascade do |t|
    t.integer "user_id"
    t.integer "question_id"
    t.boolean "favorite"
  end

  create_table "users", force: :cascade do |t|
    t.string "mail"
    t.string "name"
    t.integer "grade_id"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "icon"
  end

end
