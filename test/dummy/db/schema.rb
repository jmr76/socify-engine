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

ActiveRecord::Schema.define(version: 20170613183247) do

  create_table "socify_activities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "trackable_type"
    t.bigint "trackable_id"
    t.string "owner_type"
    t.bigint "owner_id"
    t.string "key"
    t.text "parameters"
    t.string "recipient_type"
    t.bigint "recipient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id", "owner_type"], name: "index_socify_activities_on_owner_id_and_owner_type"
    t.index ["owner_type", "owner_id"], name: "index_socify_activities_on_owner_type_and_owner_id"
    t.index ["recipient_id", "recipient_type"], name: "index_socify_activities_on_recipient_id_and_recipient_type"
    t.index ["recipient_type", "recipient_id"], name: "index_socify_activities_on_recipient_type_and_recipient_id"
    t.index ["trackable_id", "trackable_type"], name: "index_socify_activities_on_trackable_id_and_trackable_type"
    t.index ["trackable_type", "trackable_id"], name: "index_socify_activities_on_trackable_type_and_trackable_id"
  end

  create_table "socify_badges_sashes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "badge_id"
    t.integer "sash_id"
    t.boolean "notified_user", default: false
    t.datetime "created_at"
    t.index ["badge_id", "sash_id"], name: "index_socify_badges_sashes_on_badge_id_and_sash_id"
    t.index ["badge_id"], name: "index_socify_badges_sashes_on_badge_id"
    t.index ["sash_id"], name: "index_socify_badges_sashes_on_sash_id"
  end

  create_table "socify_comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "title", limit: 50, default: ""
    t.text "comment"
    t.string "commentable_type"
    t.bigint "commentable_id"
    t.bigint "socify_user_id"
    t.string "role", default: "comments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "comment_html"
    t.index ["commentable_id"], name: "index_socify_comments_on_commentable_id"
    t.index ["commentable_type", "commentable_id"], name: "index_socify_comments_on_commentable_type_and_commentable_id"
    t.index ["commentable_type"], name: "index_socify_comments_on_commentable_type"
    t.index ["socify_user_id"], name: "index_socify_comments_on_socify_user_id"
  end

  create_table "socify_events", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.datetime "event_datetime"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "cached_votes_up", default: 0
    t.integer "comments_count", default: 0
    t.index ["cached_votes_up"], name: "index_socify_events_on_cached_votes_up"
    t.index ["comments_count"], name: "index_socify_events_on_comments_count"
    t.index ["user_id"], name: "index_socify_events_on_user_id"
  end

  create_table "socify_follows", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "followable_type", null: false
    t.bigint "followable_id", null: false
    t.string "follower_type", null: false
    t.bigint "follower_id", null: false
    t.boolean "blocked", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followable_id", "followable_type"], name: "fk_followables"
    t.index ["followable_type", "followable_id"], name: "index_socify_follows_on_followable_type_and_followable_id"
    t.index ["follower_id", "follower_type"], name: "fk_follows"
    t.index ["follower_type", "follower_id"], name: "index_socify_follows_on_follower_type_and_follower_id"
  end

  create_table "socify_friendly_id_slugs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type"], name: "index_socify_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_socify_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_socify_friendly_id_slugs_on_sluggable_type"
  end

  create_table "socify_merit_actions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id"
    t.string "action_method"
    t.integer "action_value"
    t.boolean "had_errors", default: false
    t.string "target_model"
    t.integer "target_id"
    t.text "target_data"
    t.boolean "processed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "socify_merit_activity_logs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "action_id"
    t.string "related_change_type"
    t.integer "related_change_id"
    t.string "description"
    t.datetime "created_at"
  end

  create_table "socify_merit_score_points", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "score_id"
    t.integer "num_points", default: 0
    t.string "log"
    t.datetime "created_at"
    t.index ["score_id"], name: "index_socify_merit_score_points_on_score_id"
  end

  create_table "socify_merit_scores", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "sash_id"
    t.string "category", default: "default"
    t.index ["sash_id"], name: "index_socify_merit_scores_on_sash_id"
  end

  create_table "socify_posts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text "content", null: false
    t.bigint "socify_user_id"
    t.string "attachment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "cached_votes_up", default: 0
    t.integer "comments_count", default: 0
    t.text "content_html"
    t.index ["cached_votes_up"], name: "index_socify_posts_on_cached_votes_up"
    t.index ["comments_count"], name: "index_socify_posts_on_comments_count"
    t.index ["socify_user_id"], name: "index_socify_posts_on_socify_user_id"
  end

  create_table "socify_sashes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "socify_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "about"
    t.string "avatar"
    t.string "cover"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "sex", default: "male", null: false
    t.string "location"
    t.date "dob"
    t.string "phone_number"
    t.integer "posts_count", default: 0, null: false
    t.string "slug"
    t.integer "sash_id"
    t.integer "level", default: 0
    t.index ["confirmation_token"], name: "index_socify_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_socify_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_socify_users_on_reset_password_token", unique: true
    t.index ["slug"], name: "index_socify_users_on_slug", unique: true
  end

  create_table "socify_votes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "votable_type"
    t.bigint "votable_id"
    t.string "voter_type"
    t.bigint "voter_id"
    t.boolean "vote_flag"
    t.string "vote_scope"
    t.integer "vote_weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_socify_votes_on_votable_id_and_votable_type_and_vote_scope"
    t.index ["votable_type", "votable_id"], name: "index_socify_votes_on_votable_type_and_votable_id"
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_socify_votes_on_voter_id_and_voter_type_and_vote_scope"
    t.index ["voter_type", "voter_id"], name: "index_socify_votes_on_voter_type_and_voter_id"
  end

end
