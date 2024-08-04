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

ActiveRecord::Schema[7.1].define(version: 2024_07_29_132337) do
  create_table "boxes", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "epc"
    t.string "kkr"
    t.bigint "category_id", null: false
    t.datetime "deadline"
    t.float "weight"
    t.float "hhv"
    t.float "lhv"
    t.float "box_cal_hi"
    t.float "box_cal_low"
    t.integer "marks"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "burned_at"
    t.index ["category_id"], name: "index_boxes_on_category_id"
  end

  create_table "cal_marks", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title"
    t.integer "low"
    t.integer "middle"
    t.boolean "use"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "elements", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.float "w", default: 0.0, null: false
    t.float "f", default: 0.0, null: false
    t.float "a", default: 0.0, null: false
    t.float "c", default: 0.0, null: false
    t.float "h", default: 0.0, null: false
    t.float "o", default: 0.0, null: false
    t.float "n", default: 0.0, null: false
    t.float "s", default: 0.0, null: false
    t.float "cl", default: 0.0, null: false
    t.string "season"
    t.float "hhv_temp", default: 0.0, null: false
    t.float "lhv_temp", default: 0.0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "category_id", null: false
    t.index ["category_id"], name: "index_elements_on_category_id"
  end

  create_table "formulas", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "hhv_formula"
    t.string "lhv_formula"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "heat_value_predictions", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.float "total_predicted_heat"
    t.float "total_combustion_air_heat"
    t.float "total_aux_fuel_heat"
    t.float "total_exhaust_gas_heat"
    t.float "total_heat_loss"
    t.float "total_residual_ash_heat"
    t.float "total_unburned_carbon_heat"
    t.float "actual_heat_value"
    t.float "heat_value_pred_accuracy"
    t.float "prev_heat_value_pred_accuracy"
    t.float "avg_heat_value_pred_accuracy"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "start_date"
    t.datetime "end_date"
  end

  create_table "temp_elements", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.float "w"
    t.float "f"
    t.float "a"
    t.float "c"
    t.float "h"
    t.float "o"
    t.float "n"
    t.float "s"
    t.float "cl"
    t.boolean "use"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
  end

  create_table "temperatures", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.float "temp_0"
    t.float "temp_1"
    t.float "temp_2"
    t.float "temp_3"
    t.float "temp_4"
    t.float "temp_5"
    t.float "temp_6"
    t.float "temp_7"
    t.float "temp_8"
    t.float "temp_9"
    t.float "temp_10"
    t.float "temp_11"
    t.float "temp_12"
    t.float "temp_13"
    t.float "temp_14"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "boxes", "categories"
  add_foreign_key "elements", "categories"
end
