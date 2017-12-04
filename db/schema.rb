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

  create_table "posts_tags", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "post_id"
    t.integer "tag_id"
  end

  create_table "wp_blc_filters", id: :integer, unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string "name", limit: 100, null: false
    t.text "params", null: false
  end

  create_table "wp_blc_instances", primary_key: "instance_id", id: :integer, unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.integer "link_id", null: false, unsigned: true
    t.integer "container_id", null: false, unsigned: true
    t.string "container_type", limit: 40, default: "post", null: false
    t.text "link_text", null: false
    t.string "parser_type", limit: 40, default: "link", null: false
    t.string "container_field", limit: 250, default: "", null: false
    t.string "link_context", limit: 250, default: "", null: false
    t.text "raw_url", null: false
    t.index ["container_type", "container_id"], name: "source_id"
    t.index ["link_id"], name: "link_id"
    t.index ["parser_type"], name: "parser_type"
  end

  create_table "wp_blc_links", primary_key: "link_id", id: :integer, unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.text "url", null: false, collation: "utf8_bin"
    t.datetime "first_failure", null: false
    t.datetime "last_check", null: false
    t.datetime "last_success", null: false
    t.datetime "last_check_attempt", null: false
    t.integer "check_count", default: 0, null: false, unsigned: true
    t.text "final_url", null: false, collation: "latin1_general_cs"
    t.integer "redirect_count", limit: 2, default: 0, null: false, unsigned: true
    t.text "log", null: false
    t.integer "http_code", limit: 2, default: 0, null: false
    t.string "status_code", limit: 100, default: ""
    t.string "status_text", limit: 250, default: ""
    t.float "request_duration", limit: 24, default: 0.0, null: false
    t.boolean "timeout", default: false, null: false, unsigned: true
    t.boolean "broken", default: false, null: false, unsigned: true
    t.boolean "may_recheck", default: true, null: false
    t.boolean "being_checked", default: false, null: false
    t.string "result_hash", limit: 200, default: "", null: false
    t.boolean "false_positive", default: false, null: false
    t.boolean "dismissed", default: false, null: false
    t.boolean "warning", default: false, null: false, unsigned: true
    t.index ["broken"], name: "broken"
    t.index ["final_url"], name: "final_url", length: { final_url: 150 }
    t.index ["http_code"], name: "http_code"
    t.index ["url"], name: "url", length: { url: 150 }
  end

  create_table "wp_blc_synch", primary_key: ["container_type", "container_id"], force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.integer "container_id", null: false, unsigned: true
    t.string "container_type", limit: 40, null: false
    t.integer "synched", limit: 1, null: false, unsigned: true
    t.datetime "last_synch", null: false
    t.index ["synched"], name: "synched"
  end

  create_table "wp_cn_social_icon", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "title"
    t.string "url", null: false
    t.string "image_url", null: false
    t.integer "sortorder", default: 0, null: false
    t.string "date_upload", limit: 100
    t.boolean "target", default: true, null: false
  end

  create_table "wp_commentmeta", primary_key: "meta_id", id: :bigint, unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.bigint "comment_id", default: 0, null: false, unsigned: true
    t.string "meta_key"
    t.text "meta_value", limit: 4294967295
    t.index ["comment_id"], name: "comment_id"
    t.index ["meta_key"], name: "meta_key", length: { meta_key: 191 }
  end

  create_table "wp_comments", primary_key: "comment_ID", id: :bigint, unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.bigint "comment_post_ID", default: 0, null: false, unsigned: true
    t.text "comment_author", limit: 255, null: false
    t.string "comment_author_email", limit: 100, default: "", null: false
    t.string "comment_author_url", limit: 200, default: "", null: false
    t.string "comment_author_IP", limit: 100, default: "", null: false
    t.datetime "comment_date", null: false
    t.datetime "comment_date_gmt", null: false
    t.text "comment_content", null: false
    t.integer "comment_karma", default: 0, null: false
    t.string "comment_approved", limit: 20, default: "1", null: false
    t.string "comment_agent", default: "", null: false
    t.string "comment_type", limit: 20, default: "", null: false
    t.bigint "comment_parent", default: 0, null: false, unsigned: true
    t.bigint "user_id", default: 0, null: false, unsigned: true
    t.index ["comment_approved", "comment_date_gmt"], name: "comment_approved_date_gmt"
    t.index ["comment_author_email"], name: "comment_author_email", length: { comment_author_email: 10 }
    t.index ["comment_date_gmt"], name: "comment_date_gmt"
    t.index ["comment_parent"], name: "comment_parent"
    t.index ["comment_post_ID"], name: "comment_post_ID"
  end

  create_table "wp_cp_contact_form_paypal_discount_codes", id: false, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.integer "id", limit: 3, null: false
    t.integer "form_id", limit: 3, default: 1, null: false
    t.string "code", limit: 250, default: "", null: false
    t.string "discount", limit: 250, default: "", null: false
    t.datetime "expires", null: false
    t.integer "availability", default: 0, null: false, unsigned: true
    t.integer "used", default: 0, null: false, unsigned: true
    t.index ["id"], name: "id", unique: true
  end

  create_table "wp_cp_contact_form_paypal_posts", id: false, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.integer "id", limit: 3, null: false
    t.integer "formid", null: false
    t.datetime "time", null: false
    t.string "ipaddr", limit: 32, default: "", null: false
    t.string "notifyto", limit: 250, default: "", null: false
    t.text "data"
    t.text "paypal_post"
    t.text "posted_data"
    t.integer "paid", default: 0, null: false
    t.index ["id"], name: "id", unique: true
  end

  create_table "wp_cp_contact_form_paypal_settings", id: false, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.integer "id", limit: 3, null: false
    t.string "form_name", limit: 250, default: "", null: false
    t.text "form_structure"
    t.string "fp_from_email", limit: 250, default: "", null: false
    t.text "fp_destination_emails"
    t.string "fp_subject", limit: 250, default: "", null: false
    t.string "fp_inc_additional_info", limit: 10, default: "", null: false
    t.string "fp_return_page", limit: 250, default: "", null: false
    t.text "fp_message"
    t.string "fp_emailformat", limit: 10, default: "", null: false
    t.string "cu_enable_copy_to_user", limit: 10, default: "", null: false
    t.string "cu_user_email_field", limit: 250, default: "", null: false
    t.string "cu_subject", limit: 250, default: "", null: false
    t.text "cu_message"
    t.string "cp_emailformat", limit: 10, default: "", null: false
    t.string "vs_use_validation", limit: 10, default: "", null: false
    t.string "vs_text_is_required", limit: 250, default: "", null: false
    t.string "vs_text_is_email", limit: 250, default: "", null: false
    t.string "vs_text_datemmddyyyy", limit: 250, default: "", null: false
    t.string "vs_text_dateddmmyyyy", limit: 250, default: "", null: false
    t.string "vs_text_number", limit: 250, default: "", null: false
    t.string "vs_text_digits", limit: 250, default: "", null: false
    t.string "vs_text_max", limit: 250, default: "", null: false
    t.string "vs_text_min", limit: 250, default: "", null: false
    t.string "vs_text_submitbtn", limit: 250, default: "", null: false
    t.string "enable_paypal", limit: 10, default: "", null: false
    t.string "paypal_notiemails", limit: 10, default: "", null: false
    t.string "paypal_email", default: "", null: false
    t.string "request_cost", default: "", null: false
    t.string "paypal_price_field", default: "", null: false
    t.string "request_taxes", limit: 20, default: "", null: false
    t.string "request_address", limit: 20, default: "", null: false
    t.string "paypal_product_name", default: "", null: false
    t.string "currency", limit: 10, default: "", null: false
    t.string "paypal_language", limit: 10, default: "", null: false
    t.string "paypal_mode", limit: 20, default: "", null: false
    t.string "paypal_recurrent", limit: 20, default: "", null: false
    t.string "paypal_identify_prices", limit: 20, default: "", null: false
    t.string "paypal_zero_payment", limit: 10, default: "", null: false
    t.string "script_load_method", limit: 10, default: "", null: false
    t.string "cv_enable_captcha", limit: 20, default: "", null: false
    t.string "cv_width", limit: 20, default: "", null: false
    t.string "cv_height", limit: 20, default: "", null: false
    t.string "cv_chars", limit: 20, default: "", null: false
    t.string "cv_font", limit: 20, default: "", null: false
    t.string "cv_min_font_size", limit: 20, default: "", null: false
    t.string "cv_max_font_size", limit: 20, default: "", null: false
    t.string "cv_noise", limit: 20, default: "", null: false
    t.string "cv_noise_length", limit: 20, default: "", null: false
    t.string "cv_background", limit: 20, default: "", null: false
    t.string "cv_border", limit: 20, default: "", null: false
    t.string "cv_text_enter_valid_captcha", limit: 200, default: "", null: false
    t.string "cu_emailformat", limit: 10, default: "", null: false
    t.index ["id"], name: "id", unique: true
  end

  create_table "wp_links", primary_key: "link_id", id: :bigint, unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string "link_url", default: "", null: false
    t.string "link_name", default: "", null: false
    t.string "link_image", default: "", null: false
    t.string "link_target", limit: 25, default: "", null: false
    t.string "link_description", default: "", null: false
    t.string "link_visible", limit: 20, default: "Y", null: false
    t.bigint "link_owner", default: 1, null: false, unsigned: true
    t.integer "link_rating", default: 0, null: false
    t.datetime "link_updated", null: false
    t.string "link_rel", default: "", null: false
    t.text "link_notes", limit: 16777215, null: false
    t.string "link_rss", default: "", null: false
    t.index ["link_visible"], name: "link_visible"
  end

  create_table "wp_ngg_album", force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.bigint "previewpic", default: 0, null: false
    t.text "albumdesc", limit: 16777215
    t.text "sortorder", limit: 4294967295, null: false
    t.bigint "pageid", default: 0, null: false
    t.bigint "extras_post_id", default: 0, null: false
    t.index ["extras_post_id"], name: "extras_post_id_key"
  end

  create_table "wp_ngg_gallery", primary_key: "gid", force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.text "path", limit: 16777215
    t.text "title", limit: 16777215
    t.text "galdesc", limit: 16777215
    t.bigint "pageid", default: 0, null: false
    t.bigint "previewpic", default: 0, null: false
    t.bigint "author", default: 0, null: false
    t.bigint "extras_post_id", default: 0, null: false
    t.index ["extras_post_id"], name: "extras_post_id_key"
  end

  create_table "wp_ngg_pictures", primary_key: "pid", force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string "image_slug", null: false
    t.bigint "post_id", default: 0, null: false
    t.bigint "galleryid", default: 0, null: false
    t.string "filename", null: false
    t.text "description", limit: 16777215
    t.text "alttext", limit: 16777215
    t.datetime "imagedate", null: false
    t.integer "exclude", limit: 1, default: 0
    t.bigint "sortorder", default: 0, null: false
    t.text "meta_data", limit: 4294967295
    t.bigint "extras_post_id", default: 0, null: false
    t.bigint "updated_at"
    t.index ["extras_post_id"], name: "extras_post_id_key"
    t.index ["post_id"], name: "post_id"
  end

  create_table "wp_ninja_forms", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text "data", limit: 4294967295, null: false
    t.timestamp "date_updated", default: -> { "CURRENT_TIMESTAMP" }, null: false
  end

  create_table "wp_ninja_forms_fav_fields", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "row_type", null: false
    t.string "type", null: false
    t.integer "order", null: false
    t.text "data", limit: 4294967295, null: false
    t.string "name", null: false
  end

  create_table "wp_ninja_forms_fields", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "form_id", null: false
    t.string "type", null: false
    t.integer "order", null: false
    t.text "data", limit: 4294967295, null: false
    t.integer "fav_id"
    t.integer "def_id"
  end

  create_table "wp_ninja_forms_subs", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id"
    t.integer "form_id", null: false
    t.integer "status", null: false
    t.string "action", null: false
    t.text "data", limit: 4294967295, null: false
    t.timestamp "date_updated", default: -> { "CURRENT_TIMESTAMP" }, null: false
  end

  create_table "wp_nl_subscriptions", id: :integer, unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string "name", limit: 200, null: false
    t.string "email", limit: 250, null: false
    t.datetime "subscribed_on", null: false
    t.boolean "is_subscribed", default: true, null: false
    t.string "unsubs_key", limit: 100, null: false
  end

  create_table "wp_options", primary_key: "option_id", id: :bigint, unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string "option_name", limit: 191
    t.text "option_value", limit: 4294967295, null: false
    t.string "autoload", limit: 20, default: "yes", null: false
    t.index ["option_name"], name: "option_name", unique: true
  end

  create_table "wp_popover", id: :bigint, unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string "popover_title", limit: 250
    t.text "popover_content"
    t.text "popover_settings"
    t.bigint "popover_order", default: 0
    t.integer "popover_active", default: 0
  end

  create_table "wp_popover_ip_cache", primary_key: "IP", id: :string, limit: 12, default: "", force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string "country", limit: 2
    t.bigint "cached"
    t.index ["cached"], name: "cached"
  end

  create_table "wp_postmeta", primary_key: "meta_id", id: :bigint, unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.bigint "post_id", default: 0, null: false, unsigned: true
    t.string "meta_key"
    t.text "meta_value", limit: 4294967295
    t.index ["meta_key"], name: "meta_key", length: { meta_key: 191 }
    t.index ["post_id"], name: "post_id"
  end

  create_table "wp_posts", primary_key: "ID", id: :bigint, unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.bigint "post_author", default: 0, null: false, unsigned: true
    t.datetime "post_date", null: false
    t.datetime "post_date_gmt", null: false
    t.text "post_content", limit: 4294967295, null: false
    t.text "post_title", null: false
    t.text "post_excerpt", null: false
    t.string "post_status", limit: 20, default: "publish", null: false
    t.string "comment_status", limit: 20, default: "open", null: false
    t.string "ping_status", limit: 20, default: "open", null: false
    t.string "post_password", default: "", null: false
    t.string "post_name", limit: 200, default: "", null: false
    t.text "to_ping", null: false
    t.text "pinged", null: false
    t.datetime "post_modified", null: false
    t.datetime "post_modified_gmt", null: false
    t.text "post_content_filtered", limit: 4294967295, null: false
    t.bigint "post_parent", default: 0, null: false, unsigned: true
    t.string "guid", default: "", null: false
    t.integer "menu_order", default: 0, null: false
    t.string "post_type", limit: 20, default: "post", null: false
    t.string "post_mime_type", limit: 100, default: "", null: false
    t.bigint "comment_count", default: 0, null: false
    t.string "shopify_post_id"
    t.string "shopify_handle"
    t.index ["post_author"], name: "post_author"
    t.index ["post_name"], name: "post_name", length: { post_name: 191 }
    t.index ["post_parent"], name: "post_parent"
    t.index ["post_type", "post_status", "post_date", "ID"], name: "type_status_date"
  end

  create_table "wp_redirection_404", id: :integer, unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.datetime "created", null: false
    t.string "url", default: "", null: false
    t.string "agent"
    t.string "referrer"
    t.integer "ip", null: false, unsigned: true
    t.index ["created"], name: "created"
    t.index ["ip"], name: "ip"
    t.index ["referrer"], name: "referrer", length: { referrer: 250 }
    t.index ["url"], name: "url", length: { url: 250 }
  end

  create_table "wp_redirection_groups", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string "name", limit: 50, null: false
    t.integer "tracking", default: 1, null: false
    t.integer "module_id", default: 0, null: false, unsigned: true
    t.string "status", limit: 8, default: "enabled", null: false
    t.integer "position", default: 0, null: false, unsigned: true
    t.index ["module_id"], name: "module_id"
    t.index ["status"], name: "status"
  end

  create_table "wp_redirection_items", id: :integer, unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.text "url", limit: 16777215, null: false
    t.integer "regex", default: 0, null: false, unsigned: true
    t.integer "position", default: 0, null: false, unsigned: true
    t.integer "last_count", default: 0, null: false, unsigned: true
    t.datetime "last_access", null: false
    t.integer "group_id", default: 0, null: false
    t.string "status", limit: 8, default: "enabled", null: false
    t.string "action_type", limit: 20, null: false
    t.integer "action_code", null: false, unsigned: true
    t.text "action_data", limit: 16777215
    t.string "match_type", limit: 20, null: false
    t.string "title", limit: 50
    t.index ["group_id", "position"], name: "group_idpos"
    t.index ["group_id"], name: "group"
    t.index ["regex"], name: "regex"
    t.index ["status"], name: "status"
    t.index ["url"], name: "url", length: { url: 200 }
  end

  create_table "wp_redirection_logs", id: :integer, unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.datetime "created", null: false
    t.text "url", limit: 16777215, null: false
    t.text "sent_to", limit: 16777215
    t.text "agent", limit: 16777215, null: false
    t.text "referrer", limit: 16777215
    t.integer "redirection_id", unsigned: true
    t.string "ip", limit: 17, default: "", null: false
    t.integer "module_id", null: false, unsigned: true
    t.integer "group_id", unsigned: true
    t.index ["created"], name: "created"
    t.index ["group_id"], name: "group_id"
    t.index ["ip"], name: "ip"
    t.index ["module_id"], name: "module_id"
    t.index ["redirection_id"], name: "redirection_id"
  end

  create_table "wp_sml", id: false, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.integer "id", null: false
    t.string "sml_name", limit: 200, null: false
    t.string "sml_email", limit: 200, null: false
    t.index ["id"], name: "id", unique: true
  end

  create_table "wp_smush_dir_images", id: false, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.integer "id", limit: 3, null: false
    t.text "path", null: false
    t.string "resize", limit: 55
    t.string "error", limit: 55
    t.integer "image_size", unsigned: true
    t.integer "orig_size", unsigned: true
    t.integer "file_time", unsigned: true
    t.timestamp "last_scan", null: false
    t.text "meta"
    t.string "lossy", limit: 55
    t.index ["id"], name: "id", unique: true
    t.index ["image_size"], name: "image_size"
    t.index ["path"], name: "path", unique: true, length: { path: 191 }
  end

  create_table "wp_term_relationships", primary_key: ["object_id", "term_taxonomy_id"], force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.bigint "object_id", default: 0, null: false, unsigned: true
    t.bigint "term_taxonomy_id", default: 0, null: false, unsigned: true
    t.integer "term_order", default: 0, null: false
    t.index ["term_taxonomy_id"], name: "term_taxonomy_id"
  end

  create_table "wp_term_taxonomy", primary_key: "term_taxonomy_id", id: :bigint, unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.bigint "term_id", default: 0, null: false, unsigned: true
    t.string "taxonomy", limit: 32, default: "", null: false
    t.text "description", limit: 4294967295, null: false
    t.bigint "parent", default: 0, null: false, unsigned: true
    t.bigint "count", default: 0, null: false
    t.index ["taxonomy"], name: "taxonomy"
    t.index ["term_id", "taxonomy"], name: "term_id_taxonomy", unique: true
  end

  create_table "wp_termmeta", primary_key: "meta_id", id: :bigint, unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.bigint "term_id", default: 0, null: false, unsigned: true
    t.string "meta_key"
    t.text "meta_value", limit: 4294967295
    t.index ["meta_key"], name: "meta_key", length: { meta_key: 191 }
    t.index ["term_id"], name: "term_id"
  end

  create_table "wp_terms", primary_key: "term_id", id: :bigint, unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string "name", limit: 200, default: "", null: false
    t.string "slug", limit: 200, default: "", null: false
    t.bigint "term_group", default: 0, null: false
    t.index ["name"], name: "name", length: { name: 191 }
    t.index ["slug"], name: "slug", length: { slug: 191 }
  end

  create_table "wp_usermeta", primary_key: "umeta_id", id: :bigint, unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.bigint "user_id", default: 0, null: false, unsigned: true
    t.string "meta_key"
    t.text "meta_value", limit: 4294967295
    t.index ["meta_key"], name: "meta_key", length: { meta_key: 191 }
    t.index ["user_id"], name: "user_id"
  end

  create_table "wp_users", primary_key: "ID", id: :bigint, unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string "user_login", limit: 60, default: "", null: false
    t.string "user_pass", default: "", null: false
    t.string "user_nicename", limit: 50, default: "", null: false
    t.string "user_email", limit: 100, default: "", null: false
    t.string "user_url", limit: 100, default: "", null: false
    t.datetime "user_registered", null: false
    t.string "user_activation_key", default: "", null: false
    t.integer "user_status", default: 0, null: false
    t.string "display_name", limit: 250, default: "", null: false
    t.index ["user_email"], name: "user_email"
    t.index ["user_login"], name: "user_login_key"
    t.index ["user_nicename"], name: "user_nicename"
  end

  create_table "wp_woocommerce_attribute_taxonomies", primary_key: "attribute_id", force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string "attribute_name", limit: 200, null: false
    t.text "attribute_label", limit: 4294967295
    t.string "attribute_type", limit: 200, null: false
    t.string "attribute_orderby", limit: 200, null: false
    t.integer "attribute_public", default: 1, null: false
    t.index ["attribute_name"], name: "attribute_name"
  end

  create_table "wp_woocommerce_downloadable_product_permissions", primary_key: "permission_id", force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string "download_id", limit: 32, null: false
    t.bigint "product_id", null: false
    t.bigint "order_id", default: 0, null: false
    t.string "order_key", limit: 200, null: false
    t.string "user_email", limit: 200, null: false
    t.bigint "user_id"
    t.string "downloads_remaining", limit: 9
    t.datetime "access_granted", null: false
    t.datetime "access_expires"
    t.bigint "download_count", default: 0, null: false
    t.index ["download_id", "order_id", "product_id"], name: "download_order_product"
    t.index ["product_id", "order_id", "order_key", "download_id"], name: "download_order_key_product"
  end

  create_table "wp_woocommerce_order_itemmeta", primary_key: "meta_id", force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.bigint "order_item_id", null: false
    t.string "meta_key"
    t.text "meta_value", limit: 4294967295
    t.index ["meta_key"], name: "meta_key"
    t.index ["order_item_id"], name: "order_item_id"
  end

  create_table "wp_woocommerce_order_items", primary_key: "order_item_id", force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.text "order_item_name", limit: 4294967295, null: false
    t.string "order_item_type", limit: 200, default: "", null: false
    t.bigint "order_id", null: false
    t.index ["order_id"], name: "order_id"
  end

  create_table "wp_woocommerce_tax_rate_locations", primary_key: "location_id", force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string "location_code", null: false
    t.bigint "tax_rate_id", null: false
    t.string "location_type", limit: 40, null: false
    t.index ["location_type", "location_code"], name: "location_type_code"
    t.index ["location_type"], name: "location_type"
    t.index ["tax_rate_id"], name: "tax_rate_id"
  end

  create_table "wp_woocommerce_tax_rates", primary_key: "tax_rate_id", force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string "tax_rate_country", limit: 200, default: "", null: false
    t.string "tax_rate_state", limit: 200, default: "", null: false
    t.string "tax_rate", limit: 200, default: "", null: false
    t.string "tax_rate_name", limit: 200, default: "", null: false
    t.bigint "tax_rate_priority", null: false
    t.integer "tax_rate_compound", default: 0, null: false
    t.integer "tax_rate_shipping", default: 1, null: false
    t.bigint "tax_rate_order", null: false
    t.string "tax_rate_class", limit: 200, default: "", null: false
    t.index ["tax_rate_class"], name: "tax_rate_class"
    t.index ["tax_rate_country"], name: "tax_rate_country"
    t.index ["tax_rate_priority"], name: "tax_rate_priority"
    t.index ["tax_rate_state"], name: "tax_rate_state"
  end

  create_table "wp_woocommerce_termmeta", primary_key: "meta_id", force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.bigint "woocommerce_term_id", null: false
    t.string "meta_key"
    t.text "meta_value", limit: 4294967295
    t.index ["meta_key"], name: "meta_key"
    t.index ["woocommerce_term_id"], name: "woocommerce_term_id"
  end

  create_table "wp_yoast_seo_links", id: :bigint, unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string "url", null: false
    t.bigint "post_id", null: false, unsigned: true
    t.bigint "target_post_id", null: false, unsigned: true
    t.string "type", limit: 8, null: false
    t.index ["post_id", "type"], name: "link_direction"
  end

  create_table "wp_yoast_seo_meta", id: false, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.bigint "object_id", null: false, unsigned: true
    t.integer "internal_link_count", unsigned: true
    t.integer "incoming_link_count", unsigned: true
    t.index ["object_id"], name: "object_id", unique: true
  end

end
