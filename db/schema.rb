# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20081011231258) do

  create_table "campaigns", :force => true do |t|
    t.string   "name",               :null => false
    t.integer  "created_by_user_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "character_classes", :force => true do |t|
    t.string  "name",                               :null => false
    t.integer "fortitude_def_bonus", :default => 0, :null => false
    t.integer "reflex_def_bonus",    :default => 0, :null => false
    t.integer "will_def_bonus",      :default => 0, :null => false
  end

  create_table "character_skills", :force => true do |t|
    t.integer  "character_id",                          :null => false
    t.integer  "skill_id",                              :null => false
    t.boolean  "trained",                               :null => false
    t.integer  "misc_bonus",             :default => 0, :null => false
    t.string   "misc_bonus_description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "characters", :force => true do |t|
    t.integer  "user_id",                                           :null => false
    t.integer  "campaign_id",                                       :null => false
    t.string   "name",                                              :null => false
    t.string   "sex"
    t.integer  "character_class_id",                                :null => false
    t.integer  "race_id",                                           :null => false
    t.integer  "experience_points",        :default => 0,           :null => false
    t.integer  "level",                    :default => 1,           :null => false
    t.integer  "max_hit_points",                                    :null => false
    t.integer  "current_hit_points",                                :null => false
    t.integer  "healing_surge_value",                               :null => false
    t.integer  "surges_per_day",                                    :null => false
    t.integer  "current_surges_remaining",                          :null => false
    t.integer  "current_action_points",                             :null => false
    t.integer  "misc_initiative_bonus",    :default => 0,           :null => false
    t.integer  "misc_armor_class_bonus",   :default => 0,           :null => false
    t.integer  "misc_fortitude_bonus",     :default => 0,           :null => false
    t.integer  "misc_reflex_bonus",        :default => 0,           :null => false
    t.integer  "misc_will_bonus",          :default => 0,           :null => false
    t.string   "height"
    t.string   "weight"
    t.string   "alignment",                :default => "unaligned", :null => false
    t.integer  "strength",                                          :null => false
    t.integer  "constitution",                                      :null => false
    t.integer  "dexterity",                                         :null => false
    t.integer  "intellegence",                                      :null => false
    t.integer  "wisdom",                                            :null => false
    t.integer  "charisma",                                          :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feats", :force => true do |t|
    t.integer  "character_id",    :null => false
    t.string   "name",            :null => false
    t.text     "description"
    t.integer  "level_gained_at", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "powers", :force => true do |t|
    t.integer  "character_id",    :null => false
    t.string   "name",            :null => false
    t.text     "description"
    t.string   "frequency",       :null => false
    t.integer  "level_gained_at", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "races", :force => true do |t|
    t.string  "name",                         :null => false
    t.integer "speed",                        :null => false
    t.string  "size",   :default => "medium", :null => false
    t.string  "vision", :default => "normal", :null => false
  end

  create_table "skills", :force => true do |t|
    t.string   "name",        :null => false
    t.string   "key_ability", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "weapons", :force => true do |t|
    t.integer  "character_id", :null => false
    t.string   "name",         :null => false
    t.text     "description"
    t.string   "key_ability"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
