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

ActiveRecord::Schema.define(version: 2019_09_04_093242) do

  create_table "bank_accounts", force: :cascade do |t|
    t.string "bank_name"
    t.string "account_number"
    t.string "ifsc_code"
    t.string "account_holder_name"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_bank_accounts_on_user_id"
  end

  create_table "bookings", force: :cascade do |t|
    t.string "package"
    t.integer "user_id"
    t.integer "library_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "payment_method"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string "subscription_length"
    t.string "token"
    t.string "razorpay_payment_id"
    t.string "plan_id"
    t.integer "payment_status"
    t.index ["user_id", "library_id"], name: "index_bookings_on_user_id_and_library_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "library_id"
    t.index ["library_id"], name: "index_cities_on_library_id"
  end

  create_table "images", force: :cascade do |t|
    t.string "avatar"
    t.integer "imageable_id"
    t.string "imageable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["imageable_type", "imageable_id"], name: "index_images_on_imageable_type_and_imageable_id"
  end

  create_table "libraries", force: :cascade do |t|
    t.string "name"
    t.string "open"
    t.integer "seats"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "contact_number"
    t.boolean "published", default: false
    t.datetime "deleted_at"
    t.string "address1"
    t.string "address2"
    t.string "state"
    t.string "city"
    t.string "landmark"
    t.string "zip_code"
    t.integer "monthly"
    t.integer "quaterly"
    t.integer "halfyearly"
    t.integer "yearly"
    t.integer "booked_seats"
    t.string "monthly_plan_id"
    t.string "quaterly_plan_id"
    t.string "halfyearly_plan_id"
    t.string "yearly_plan_id"
    t.index ["deleted_at"], name: "index_libraries_on_deleted_at"
    t.index ["user_id"], name: "index_libraries_on_user_id"
  end

  create_table "qrcodes", force: :cascade do |t|
    t.string "code"
    t.integer "booking_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 2
    t.string "first_name"
    t.string "last_name"
    t.string "provider"
    t.string "uid"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
