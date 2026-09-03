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

ActiveRecord::Schema[8.1].define(version: 2026_09_03_050832) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "admin_users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "password_digest"
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.decimal "cost_price", precision: 10, scale: 2, default: "0.0"
    t.datetime "created_at", null: false
    t.text "description"
    t.integer "minimum_stock"
    t.string "name"
    t.decimal "selling_price", precision: 10, scale: 2, default: "0.0"
    t.string "sku"
    t.string "status", default: "active"
    t.integer "stock_quantity"
    t.bigint "supplier_id", null: false
    t.string "unit"
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["supplier_id"], name: "index_products_on_supplier_id"
  end

  create_table "stock_movements", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "movement_type"
    t.bigint "product_id", null: false
    t.integer "quantity"
    t.text "reason"
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_stock_movements_on_product_id"
  end

  create_table "suppliers", force: :cascade do |t|
    t.text "address"
    t.string "company_name"
    t.string "contact_person"
    t.datetime "created_at", null: false
    t.string "email"
    t.text "notes"
    t.string "phone"
    t.string "status", default: "active"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "products", "categories"
  add_foreign_key "products", "suppliers"
  add_foreign_key "stock_movements", "products"
end
