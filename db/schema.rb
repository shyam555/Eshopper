# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20170220122621) do

  create_table "addresses", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "email"
    t.text     "address_one"
    t.text     "address_two"
    t.string   "zip_code"
    t.string   "country"
    t.string   "state"
    t.string   "mobile_number"
    t.string   "address_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "status"
  end

  add_index "addresses", ["user_id"], name: "index_addresses_on_user_id"

  create_table "banners", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.string   "picture"
    t.string   "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "brand_categories", force: :cascade do |t|
    t.integer  "category_id"
    t.integer  "brand_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "brand_categories", ["brand_id"], name: "index_brand_categories_on_brand_id"
  add_index "brand_categories", ["category_id"], name: "index_brand_categories_on_category_id"

  create_table "brands", force: :cascade do |t|
    t.string   "name"
    t.boolean  "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cart_items", force: :cascade do |t|
    t.integer  "quantity",   default: 0
    t.integer  "user_id"
    t.integer  "product_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "cart_items", ["product_id"], name: "index_cart_items_on_product_id"
  add_index "cart_items", ["user_id"], name: "index_cart_items_on_user_id"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.boolean  "status"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "category_id"
    t.integer  "parent"
  end

  create_table "checkouts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "email"
    t.string   "subject"
    t.text     "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "reply"
  end

  add_index "contacts", ["user_id"], name: "index_contacts_on_user_id"

  create_table "coupon_useds", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "order_id"
    t.integer  "coupon_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "coupon_useds", ["coupon_id"], name: "index_coupon_useds_on_coupon_id"
  add_index "coupon_useds", ["order_id"], name: "index_coupon_useds_on_order_id"
  add_index "coupon_useds", ["user_id"], name: "index_coupon_useds_on_user_id"

  create_table "coupons", force: :cascade do |t|
    t.string   "code"
    t.decimal  "percent_off"
    t.integer  "no_of_uses"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "orderitems", force: :cascade do |t|
    t.integer  "quantity"
    t.decimal  "amount"
    t.integer  "order_id"
    t.integer  "product_id"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.decimal  "tax"
    t.decimal  "shipping_charges"
  end

  add_index "orderitems", ["order_id"], name: "index_orderitems_on_order_id"
  add_index "orderitems", ["product_id"], name: "index_orderitems_on_product_id"
  add_index "orderitems", ["user_id"], name: "index_orderitems_on_user_id"

  create_table "orders", force: :cascade do |t|
    t.string   "payment_gateway_id"
    t.string   "transection_id"
    t.string   "order_status"
    t.decimal  "grand_total"
    t.decimal  "shipping_charges"
    t.integer  "user_id"
    t.integer  "address_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.decimal  "tax"
  end

  add_index "orders", ["address_id"], name: "index_orders_on_address_id"
  add_index "orders", ["user_id"], name: "index_orders_on_user_id"

  create_table "pictures", force: :cascade do |t|
    t.string   "name"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "image"
  end

  add_index "pictures", ["imageable_type", "imageable_id"], name: "index_pictures_on_imageable_type_and_imageable_id"

  create_table "product_categories", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "product_categories", ["category_id"], name: "index_product_categories_on_category_id"
  add_index "product_categories", ["product_id"], name: "index_product_categories_on_product_id"

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.string   "short_description"
    t.text     "long_description"
    t.boolean  "status"
    t.decimal  "price"
    t.integer  "quantity"
    t.integer  "brand_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "products", ["brand_id"], name: "index_products_on_brand_id"

  create_table "recommended_products", id: false, force: :cascade do |t|
    t.integer  "product_id",             null: false
    t.integer  "recommended_product_id", null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "trackorders", force: :cascade do |t|
    t.string   "status"
    t.integer  "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "trackorders", ["order_id"], name: "index_trackorders_on_order_id"

  create_table "transactions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "order_id"
    t.integer  "orderitem_id"
    t.string   "token"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "charge_id"
    t.decimal  "amount"
    t.boolean  "paid",         default: false
    t.boolean  "refunded",     default: false
    t.string   "status"
  end

  add_index "transactions", ["order_id"], name: "index_transactions_on_order_id"
  add_index "transactions", ["orderitem_id"], name: "index_transactions_on_orderitem_id"
  add_index "transactions", ["user_id"], name: "index_transactions_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "firstname"
    t.string   "lastname"
    t.boolean  "admin",                  default: false
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "wishlists", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "wishlists", ["product_id"], name: "index_wishlists_on_product_id"
  add_index "wishlists", ["user_id"], name: "index_wishlists_on_user_id"

end
