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

ActiveRecord::Schema.define(version: 2020_03_21_033922) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "establishments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "contact_person"
    t.string "address"
    t.string "region"
    t.string "province"
    t.string "city"
    t.string "village"
    t.string "category"
    t.string "contact_number"
    t.integer "number_of_people_in_need"
    t.decimal "lat"
    t.decimal "lng"
    t.text "description"
    t.string "severity"
    t.string "needs"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "user_id"
    t.index ["user_id"], name: "index_establishments_on_user_id"
  end

  create_table "patients", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.date "date_of_birth"
    t.string "gender"
    t.string "status"
    t.string "city"
    t.string "address"
    t.uuid "user_id"
    t.string "symptoms"
    t.decimal "temperature"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "middle_name"
    t.boolean "is_positive"
    t.string "needs"
    t.string "needs_status"
    t.string "classification"
    t.string "region"
    t.string "village"
    t.string "province"
    t.string "action_taken"
    t.string "other_action_taken"
    t.boolean "access_taccess_to_income"
    t.boolean "access_to_transportation"
    t.boolean "access_to_food"
    t.boolean "receives_government_aid"
    t.boolean "is_primary"
    t.uuid "patient_id"
    t.boolean "is_deceased"
    t.string "contact_number"
    t.date "date_last_exposed"
    t.string "latest_exposure"
    t.string "latest_exposure_specify"
    t.index ["patient_id"], name: "index_patients_on_patient_id"
    t.index ["user_id"], name: "index_patients_on_user_id"
  end

  create_table "question_options", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "question_id"
    t.string "label"
    t.string "option_type"
    t.string "val"
    t.integer "priority"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_question_options_on_question_id"
  end

  create_table "questions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "survey_id"
    t.string "content"
    t.string "question_type"
    t.integer "priority"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["survey_id"], name: "index_questions_on_survey_id"
  end

  create_table "survey_answers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "survey_id"
    t.uuid "user_id"
    t.boolean "is_final"
    t.date "date_answered"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date_submitted"
    t.index ["survey_id"], name: "index_survey_answers_on_survey_id"
    t.index ["user_id"], name: "index_survey_answers_on_user_id"
  end

  create_table "survey_question_answers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "survey_answer_id"
    t.uuid "question_id"
    t.string "answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_survey_question_answers_on_question_id"
    t.index ["survey_answer_id"], name: "index_survey_question_answers_on_survey_answer_id"
  end

  create_table "surveys", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "username"
    t.string "role"
    t.string "group_name"
    t.string "company"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "establishments", "users"
  add_foreign_key "patients", "patients"
  add_foreign_key "patients", "users"
  add_foreign_key "question_options", "questions"
  add_foreign_key "questions", "surveys"
  add_foreign_key "survey_answers", "surveys"
  add_foreign_key "survey_answers", "users"
  add_foreign_key "survey_question_answers", "questions"
  add_foreign_key "survey_question_answers", "survey_answers"
end
