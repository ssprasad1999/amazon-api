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

ActiveRecord::Schema[7.0].define(version: 2023_03_06_113946) do
  create_table "carts", force: :cascade do |t|
    t.string "product_name"
    t.text "description"
    t.integer "price"
    t.integer "quantity"
    t.integer "total_price"
    t.integer "product_id"
    t.integer "customer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_carts_on_customer_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.integer "mobile_number"
    t.string "password_digest"
    t.string "email"
    t.date "date_of_birth"
    t.string "gender"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "product_name"
    t.string "brand"
    t.integer "actual_price"
    t.integer "offer"
    t.integer "offer_price"
    t.text "description"
    t.string "category"
    t.string "consumer_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "seller_id"
  end

  create_table "sellers", force: :cascade do |t|
    t.string "seller_email"
    t.string "password_digest"
    t.string "seller_name"
    t.string "store_name"
    t.string "seller_address"
    t.date "seller_creation_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "carts", "customers"
end
