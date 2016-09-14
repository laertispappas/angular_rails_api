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

ActiveRecord::Schema.define(version: 20160914185152) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actors", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "cities", force: :cascade do |t|
    t.integer "state_id", null: false
    t.string  "name",     null: false
    t.index ["state_id"], name: "index_cities_on_state_id", using: :btree
  end

  create_table "conditions", force: :cascade do |t|
    t.integer "context_id", null: false
    t.string  "name",       null: false
    t.index ["context_id"], name: "index_conditions_on_context_id", using: :btree
  end

  create_table "contexts", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "countries", force: :cascade do |t|
    t.string "code", null: false
    t.string "name", null: false
    t.index ["code"], name: "index_countries_on_code", using: :btree
    t.index ["name"], name: "index_countries_on_name", using: :btree
  end

  create_table "genres", force: :cascade do |t|
    t.string "name", null: false
    t.index ["name"], name: "index_genres_on_name", using: :btree
  end

  create_table "movie_actors", force: :cascade do |t|
    t.integer "movie_id"
    t.integer "actor_id"
    t.index ["actor_id"], name: "index_movie_actors_on_actor_id", using: :btree
    t.index ["movie_id"], name: "index_movie_actors_on_movie_id", using: :btree
  end

  create_table "movie_genres", force: :cascade do |t|
    t.integer "movie_id"
    t.integer "genre_id"
    t.index ["genre_id"], name: "index_movie_genres_on_genre_id", using: :btree
    t.index ["movie_id"], name: "index_movie_genres_on_movie_id", using: :btree
  end

  create_table "movies", force: :cascade do |t|
    t.string "title",    null: false
    t.string "director"
    t.string "country"
    t.string "language"
    t.string "year"
    t.string "budget"
    t.index ["title"], name: "index_movies_on_title", using: :btree
  end

  create_table "rating_conditions", force: :cascade do |t|
    t.integer "condition_id"
    t.integer "rating_id"
    t.index ["condition_id"], name: "index_rating_conditions_on_condition_id", using: :btree
    t.index ["rating_id"], name: "index_rating_conditions_on_rating_id", using: :btree
  end

  create_table "ratings", force: :cascade do |t|
    t.integer  "movie_id",             null: false
    t.integer  "user_id",              null: false
    t.integer  "score",      limit: 2, null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["movie_id"], name: "index_ratings_on_movie_id", using: :btree
    t.index ["user_id"], name: "index_ratings_on_user_id", using: :btree
  end

  create_table "states", force: :cascade do |t|
    t.integer "country_id",             null: false
    t.string  "code",       limit: 4,   null: false
    t.string  "name",       limit: 100, null: false
    t.index ["code"], name: "index_states_on_code", using: :btree
    t.index ["country_id"], name: "index_states_on_country_id", using: :btree
    t.index ["name"], name: "index_states_on_name", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "gender"
    t.date     "birthday"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "city_id"
    t.index ["email"], name: "index_users_on_email", using: :btree
  end

  add_foreign_key "cities", "states"
  add_foreign_key "conditions", "contexts"
  add_foreign_key "movie_actors", "actors"
  add_foreign_key "movie_actors", "movies"
  add_foreign_key "movie_genres", "genres"
  add_foreign_key "movie_genres", "movies"
  add_foreign_key "ratings", "movies"
  add_foreign_key "ratings", "users"
  add_foreign_key "states", "countries"
  add_foreign_key "users", "cities"
end
