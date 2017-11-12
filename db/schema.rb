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

ActiveRecord::Schema.define(version: 20171112021151) do

  create_table "posts_tags", force: :cascade do |t|
    t.integer "post_id"
    t.integer "tag_id"
  end

  create_table "wp_commentmeta", primary_key: "meta_id", force: :cascade do |t|
    t.integer "comment_id", default: 0, null: false
    t.string "meta_key", limit: 255
    t.text "meta_value"
    t.index ["comment_id"], name: "idx_wp_commentmeta_comment_id"
    t.index ["meta_key"], name: "idx_wp_commentmeta_meta_key"
  end

  create_table "wp_comments", primary_key: "comment_ID", force: :cascade do |t|
    t.integer "comment_post_ID", default: 0, null: false
    t.text "comment_author", null: false
    t.string "comment_author_email", limit: 100, default: "", null: false
    t.string "comment_author_url", limit: 200, default: "", null: false
    t.string "comment_author_IP", limit: 100, default: "", null: false
    t.datetime "comment_date", null: false
    t.datetime "comment_date_gmt", null: false
    t.text "comment_content", null: false
    t.integer "comment_karma", default: 0, null: false
    t.string "comment_approved", limit: 20, default: "1", null: false
    t.string "comment_agent", limit: 255, default: "", null: false
    t.string "comment_type", limit: 20, default: "", null: false
    t.integer "comment_parent", default: 0, null: false
    t.integer "user_id", default: 0, null: false
    t.index ["comment_approved", "comment_date_gmt"], name: "idx_wp_comments_comment_approved_date_gmt"
    t.index ["comment_author_email"], name: "idx_wp_comments_comment_author_email"
    t.index ["comment_date_gmt"], name: "idx_wp_comments_comment_date_gmt"
    t.index ["comment_parent"], name: "idx_wp_comments_comment_parent"
    t.index ["comment_post_ID"], name: "idx_wp_comments_comment_post_ID"
  end

  create_table "wp_links", primary_key: "link_id", force: :cascade do |t|
    t.string "link_url", limit: 255, default: "", null: false
    t.string "link_name", limit: 255, default: "", null: false
    t.string "link_image", limit: 255, default: "", null: false
    t.string "link_target", limit: 25, default: "", null: false
    t.string "link_description", limit: 255, default: "", null: false
    t.string "link_visible", limit: 20, default: "Y", null: false
    t.integer "link_owner", default: 1, null: false
    t.integer "link_rating", default: 0, null: false
    t.datetime "link_updated", null: false
    t.string "link_rel", limit: 255, default: "", null: false
    t.text "link_notes", null: false
    t.string "link_rss", limit: 255, default: "", null: false
    t.index ["link_visible"], name: "idx_wp_links_link_visible"
  end

  create_table "wp_options", primary_key: "option_id", force: :cascade do |t|
    t.string "option_name", limit: 191, default: "", null: false
    t.text "option_value", null: false
    t.string "autoload", limit: 20, default: "yes", null: false
    t.index ["option_name"], name: "sqlite_autoindex_wp_options_1", unique: true
  end

  create_table "wp_postmeta", primary_key: "meta_id", force: :cascade do |t|
    t.integer "post_id", default: 0, null: false
    t.string "meta_key", limit: 255
    t.text "meta_value"
    t.index ["meta_key"], name: "idx_wp_postmeta_meta_key"
    t.index ["post_id"], name: "idx_wp_postmeta_post_id"
  end

  create_table "wp_posts", primary_key: "ID", force: :cascade do |t|
    t.integer "post_author", default: 0, null: false
    t.datetime "post_date", null: false
    t.datetime "post_date_gmt", null: false
    t.text "post_content", null: false
    t.text "post_title", null: false
    t.text "post_excerpt", null: false
    t.string "post_status", limit: 20, default: "publish", null: false
    t.string "comment_status", limit: 20, default: "open", null: false
    t.string "ping_status", limit: 20, default: "open", null: false
    t.string "post_password", limit: 255, default: "", null: false
    t.string "post_name", limit: 200, default: "", null: false
    t.text "to_ping", null: false
    t.text "pinged", null: false
    t.datetime "post_modified", null: false
    t.datetime "post_modified_gmt", null: false
    t.text "post_content_filtered", null: false
    t.integer "post_parent", default: 0, null: false
    t.string "guid", limit: 255, default: "", null: false
    t.integer "menu_order", default: 0, null: false
    t.string "post_type", limit: 20, default: "post", null: false
    t.string "post_mime_type", limit: 100, default: "", null: false
    t.integer "comment_count", default: 0, null: false
    t.string "shopify_post_id"
    t.string "shopify_handle"
    t.index ["post_author"], name: "idx_wp_posts_post_author"
    t.index ["post_name"], name: "idx_wp_posts_post_name"
    t.index ["post_parent"], name: "idx_wp_posts_post_parent"
    t.index ["post_type", "post_status", "post_date", "ID"], name: "idx_wp_posts_type_status_date"
  end

  create_table "wp_term_relationships", primary_key: ["object_id", "term_taxonomy_id"], force: :cascade do |t|
    t.integer "object_id", default: 0, null: false
    t.integer "term_taxonomy_id", default: 0, null: false
    t.integer "term_order", default: 0, null: false
    t.index ["object_id", "term_taxonomy_id"], name: "sqlite_autoindex_wp_term_relationships_1", unique: true
    t.index ["term_taxonomy_id"], name: "idx_wp_term_relationships_term_taxonomy_id"
  end

  create_table "wp_term_taxonomy", primary_key: "term_taxonomy_id", force: :cascade do |t|
    t.integer "term_id", default: 0, null: false
    t.string "taxonomy", limit: 32, default: "", null: false
    t.text "description", null: false
    t.integer "parent", default: 0, null: false
    t.integer "count", default: 0, null: false
    t.index ["taxonomy"], name: "idx_wp_term_taxonomy_taxonomy"
    t.index ["term_id", "taxonomy"], name: "sqlite_autoindex_wp_term_taxonomy_1", unique: true
  end

  create_table "wp_termmeta", primary_key: "meta_id", force: :cascade do |t|
    t.integer "term_id", default: 0, null: false
    t.string "meta_key", limit: 255
    t.text "meta_value"
    t.index ["meta_key"], name: "idx_wp_termmeta_meta_key"
    t.index ["term_id"], name: "idx_wp_termmeta_term_id"
  end

  create_table "wp_terms", primary_key: "term_id", force: :cascade do |t|
    t.string "name", limit: 200, default: "", null: false
    t.string "slug", limit: 200, default: "", null: false
    t.integer "term_group", default: 0, null: false
    t.index ["name"], name: "idx_wp_terms_name"
    t.index ["slug"], name: "idx_wp_terms_slug"
  end

  create_table "wp_usermeta", primary_key: "umeta_id", force: :cascade do |t|
    t.integer "user_id", default: 0, null: false
    t.string "meta_key", limit: 255
    t.text "meta_value"
    t.index ["meta_key"], name: "idx_wp_usermeta_meta_key"
    t.index ["user_id"], name: "idx_wp_usermeta_user_id"
  end

  create_table "wp_users", primary_key: "ID", force: :cascade do |t|
    t.string "user_login", limit: 60, default: "", null: false
    t.string "user_pass", limit: 255, default: "", null: false
    t.string "user_nicename", limit: 50, default: "", null: false
    t.string "user_email", limit: 100, default: "", null: false
    t.string "user_url", limit: 100, default: "", null: false
    t.datetime "user_registered", null: false
    t.string "user_activation_key", limit: 255, default: "", null: false
    t.integer "user_status", default: 0, null: false
    t.string "display_name", limit: 250, default: "", null: false
    t.index ["user_email"], name: "idx_wp_users_user_email"
    t.index ["user_login"], name: "idx_wp_users_user_login_key"
    t.index ["user_nicename"], name: "idx_wp_users_user_nicename"
  end

end
