# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170318191650) do

  create_table "breeds", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_breeds_on_name"
  end

  create_table "dogs", force: :cascade do |t|
    t.string  "name",        null: false
    t.integer "gender_cd",   null: false
    t.integer "breed_id",    null: false
    t.integer "castrate_cd", null: false
    t.date    "birth_date",  null: false
    t.string  "owner_name",  null: false
    t.string  "owner_phone", null: false
    t.date    "last_visit",  null: false
    t.index ["breed_id"], name: "index_dogs_on_breed_id"
    t.index ["name"], name: "index_dogs_on_name"
    t.index ["owner_name"], name: "index_dogs_on_owner_name"
    t.index ["owner_phone"], name: "index_dogs_on_owner_phone"
  end

end
