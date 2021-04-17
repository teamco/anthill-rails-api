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

ActiveRecord::Schema.define(version: 2021_04_16_124207) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "secured_user_logs", force: :cascade do |t|
    t.integer "user_id"
    t.string "remote_addr"
    t.string "session_id"
    t.integer "status"
    t.string "method"
    t.string "controller"
    t.string "action"
    t.string "domain"
    t.string "request_uri"
    t.string "url"
    t.string "format"
    t.string "protocol"
    t.string "host"
    t.string "port"
    t.text "user_params"
    t.text "user_session"
    t.string "query_string"
    t.string "http_accept"
    t.boolean "ssl"
    t.boolean "xhr"
    t.string "referer"
    t.string "http_user_agent"
    t.string "server_software"
    t.string "content_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_secured_user_logs_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "provider"
    t.boolean "superadmin_role", default: false
    t.boolean "supervisor_role", default: false
    t.boolean "user_role", default: true
    t.integer "sign_in_count"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "name"
    t.string "profile_image"
    t.string "gravatar_url"
    t.string "key"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "websites", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "picture"
    t.integer "user_id"
    t.integer "version_id"
    t.string "key"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "tags"
    t.index ["key"], name: "index_websites_on_key"
    t.index ["user_id"], name: "index_websites_on_user_id"
  end

  create_table "websites_widgets", force: :cascade do |t|
    t.integer "website_id"
    t.integer "widget_id"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_websites_widgets_on_user_id"
    t.index ["website_id"], name: "index_websites_widgets_on_website_id"
    t.index ["widget_id"], name: "index_websites_widgets_on_widget_id"
  end

  create_table "widgets", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.text "key"
    t.integer "width", default: 300
    t.integer "height", default: 300
    t.string "resource"
    t.string "picture"
    t.boolean "is_external", default: false
    t.string "external_resource"
    t.boolean "visible", default: true
    t.boolean "public", default: false
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "tags"
    t.index ["key"], name: "index_widgets_on_key"
    t.index ["user_id"], name: "index_widgets_on_user_id"
  end

end
