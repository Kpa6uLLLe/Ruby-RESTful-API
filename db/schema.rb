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

ActiveRecord::Schema[7.1].define(version: 2023_10_31_104355) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "adminpack"
  enable_extension "plpgsql"

  create_table "S_ДЕТИ_СОТРУДНИКОВ", id: false, force: :cascade do |t|
    t.string "СЛУЖАЩИЙ_ИД", limit: 20, null: false
    t.string "ФАМИЛИЯ", limit: 50, null: false
    t.string "ИМЯ", limit: 20, null: false
    t.string "ОТЧЕСТВО", limit: 50
    t.date "ДЕНЬ_РОЖДЕНИЯ"
  end

  create_table "S_ЛАБОРАТОРИИ", primary_key: "ИД", id: { type: :string, limit: 20 }, force: :cascade do |t|
    t.string "РУКОВОДИТЕЛЬ_ИД", limit: 20, null: false
    t.string "НАИМЕНОВАНИЕ", limit: 50, null: false
    t.date "ДАТА_ОТКРЫТИЯ"
    t.date "ДАТА_ЗАКРЫТИЯ"
  end

  create_table "S_ПРЕМИИ", id: false, force: :cascade do |t|
    t.string "СЛУЖАЩИЙ_ИД", limit: 20, null: false
    t.string "НОМЕР_ПРИКАЗА", limit: 20, null: false
    t.date "ДАТА_ПРИКАЗА"
    t.decimal "РАЗМЕР", precision: 10, scale: 2
  end

  create_table "S_СЛУЖАЩИЕ", primary_key: "ИД", id: { type: :string, limit: 20 }, force: :cascade do |t|
    t.string "ТАБЕЛЬНЫЙ_НОМЕР", limit: 20, null: false
    t.string "ЛАБОРАТОРИЯ_ИД", limit: 20, null: false
    t.string "СПЕЦИАЛЬНОСТЬ_ИД", limit: 20, null: false
    t.string "ФАМИЛИЯ", limit: 50, null: false
    t.string "ИМЯ", limit: 20, null: false
    t.string "ОТЧЕСТВО", limit: 50
    t.string "ПОЛ", limit: 1, null: false
    t.date "ДЕНЬ_РОЖДЕНИЯ", null: false
    t.string "СЕМ_ПОЛОЖЕНИЕ", limit: 1, default: "0", null: false
    t.string "ТЕЛЕФОН", limit: 20
    t.string "АДРЕС", limit: 100
    t.decimal "ОКЛАД", precision: 10, scale: 2, null: false

    t.unique_constraint ["ТАБЕЛЬНЫЙ_НОМЕР"], name: "S_СЛУЖАЩИЕ_ТАБЕЛЬНЫЙ_НОМЕР_key"
  end

  create_table "S_СПЕЦИАЛЬНОСТИ", primary_key: "ИД", id: { type: :string, limit: 20 }, force: :cascade do |t|
    t.string "НАИМЕНОВАНИЕ", limit: 50, null: false
    t.date "ДАТА_ОТКРЫТИЯ"
    t.date "ДАТА_ЗАКРЫТИЯ"
  end

  create_table "patients", force: :cascade do |t|
    t.string "initials"
    t.date "birthdate"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "phone"
  end

  create_table "recommendations", force: :cascade do |t|
    t.text "responseBody"
    t.bigint "request_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["request_id"], name: "index_recommendations_on_request_id"
  end

  create_table "requests", force: :cascade do |t|
    t.text "requestBody"
    t.date "creationDate"
    t.bigint "patient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_id"], name: "index_requests_on_patient_id"
  end

  add_foreign_key "S_ДЕТИ_СОТРУДНИКОВ", "S_СЛУЖАЩИЕ", column: "СЛУЖАЩИЙ_ИД", primary_key: "ИД", name: "FK_ДЕТИ_СОТРУДНИКОВ"
  add_foreign_key "S_ЛАБОРАТОРИИ", "S_СЛУЖАЩИЕ", column: "РУКОВОДИТЕЛЬ_ИД", primary_key: "ИД", name: "FK_РУКОВОДИТЕЛЬ_ИД"
  add_foreign_key "S_ПРЕМИИ", "S_СЛУЖАЩИЕ", column: "СЛУЖАЩИЙ_ИД", primary_key: "ИД", name: "FK_ПРЕМИИ"
  add_foreign_key "S_СЛУЖАЩИЕ", "S_ЛАБОРАТОРИИ", column: "ЛАБОРАТОРИЯ_ИД", primary_key: "ИД", name: "FK_ЛАБОРАТОРИЯ_ИД"
  add_foreign_key "S_СЛУЖАЩИЕ", "S_СПЕЦИАЛЬНОСТИ", column: "СПЕЦИАЛЬНОСТЬ_ИД", primary_key: "ИД", name: "FK_СПЕЦИАЛЬНОСТЬ_ИД"
end
