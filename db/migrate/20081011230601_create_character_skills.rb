class CreateCharacterSkills < ActiveRecord::Migration
  def self.up

    create_table :character_skills do |t|
      t.integer :character_id, :null => false
      t.integer :skill_id, :null => false
      t.boolean :trained, :null => false
      t.integer :misc_bonus, :null => false, :default => 0
      t.string :misc_bonus_description
      t.timestamps
    end
  end

  def self.down
    drop_table :character_skills
  end
end
