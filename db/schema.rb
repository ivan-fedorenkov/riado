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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121124183620) do

  create_table "acols", :force => true do |t|
    t.string   "name",       :null => false
    t.integer  "region_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "acols", ["name"], :name => "index_acols_on_name", :unique => true

  create_table "advocates", :force => true do |t|
    t.string   "second_name"
    t.string   "first_name"
    t.string   "patronomic"
    t.string   "reg_num",                 :null => false
    t.string   "status",                  :null => false
    t.string   "sex"
    t.integer  "acol_id",                 :null => false
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.integer  "advocatory_formation_id"
  end

  add_index "advocates", ["advocatory_formation_id"], :name => "index_advocates_on_advocatory_formation_id"
  add_index "advocates", ["reg_num"], :name => "index_advocates_on_reg_num", :unique => true
  add_index "advocates", ["second_name"], :name => "index_advocates_on_second_name"
  add_index "advocates", ["status"], :name => "index_advocates_on_status"

  create_table "advocatory_formations", :force => true do |t|
    t.string   "name",               :null => false
    t.string   "form",               :null => false
    t.integer  "acol_id",            :null => false
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "head_department_id"
  end

  add_index "advocatory_formations", ["acol_id"], :name => "index_advocatory_formations_on_acol_id"
  add_index "advocatory_formations", ["form"], :name => "index_advocatory_formations_on_form"
  add_index "advocatory_formations", ["head_department_id"], :name => "index_advocatory_formations_on_head_department_id"
  add_index "advocatory_formations", ["name"], :name => "index_advocatory_formations_on_name"

  create_table "regions", :force => true do |t|
    t.string  "name",                       :null => false
    t.boolean "default", :default => false
  end

  add_index "regions", ["name"], :name => "index_regions_on_name"

end
