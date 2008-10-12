class CreateCharacters < ActiveRecord::Migration
  def self.up
    create_table :character_classes do |t|
      t.string :name, :null => false
      t.integer :fortitude_def_bonus, :null => false, :default => 0
      t.integer :reflex_def_bonus, :null => false, :default => 0
      t.integer :will_def_bonus, :null => false, :default => 0
    end
    
    create_table :races do |t|
      t.string :name, :null => false
      t.integer :speed, :null => false
      t.string :size, :null => false, :default => 'medium'
      t.string :vision, :null => false, :default => 'normal'
    end
    
    create_table :characters do |t|
      t.integer :user_id, :null => false
      t.integer :campaign_id, :null => false
      t.string :name, :null => false
      t.string :sex
      t.integer :character_class_id, :null => false
      t.integer :race_id, :null => false
      t.integer :experience_points, :null => false, :default => 0
      t.integer :level, :null => false, :default => 1
      t.integer :max_hit_points, :null => false
      t.integer :current_hit_points, :null => false
      t.integer :healing_surge_value, :null => false
      t.integer :surges_per_day, :null => false
      t.integer :current_surges_remaining, :null => false
      t.integer :current_action_points, :null => false
      t.integer :misc_initiative_bonus, :null => false, :default => 0
      t.integer :misc_armor_class_bonus, :null => false, :default => 0
      t.integer :misc_fortitude_bonus, :null => false, :default => 0
      t.integer :misc_reflex_bonus, :null => false, :default => 0
      t.integer :misc_will_bonus, :null => false, :default => 0
      t.string :height
      t.string :weight
      t.string :alignment, :null => false, :default => 'unaligned'
      t.integer :strength, :null => false
      t.integer :constitution, :null => false
      t.integer :dexterity, :null => false
      t.integer :intelligence, :null => false
      t.integer :wisdom, :null => false
      t.integer :charisma, :null => false
      
      t.timestamps
    end
    
    # populate classe´s and races tables
    classes = []
    classes << CharacterClass.new(:name => 'Cleric', :will_def_bonus => 2 )
    classes << CharacterClass.new(:name => 'Fighter', :fortitude_def_bonus => 2)
    classes << CharacterClass.new(:name => 'Paladin', :fortitude_def_bonus => 1, :reflex_def_bonus => 1, :will_def_bonus => 1)
    classes << CharacterClass.new(:name => 'Ranger', :fortitude_def_bonus => 1, :reflex_def_bonus => 1)
    classes << CharacterClass.new(:name => 'Rogue', :reflex_def_bonus => 2)
    classes << CharacterClass.new(:name => 'Warlock', :reflex_def_bonus => 1, :will_def_bonus => 1)
    classes << CharacterClass.new(:name => 'Warlord', :fortitude_def_bonus => 1, :will_def_bonus => 1)
    classes << CharacterClass.new(:name => 'Wizard', :will_def_bonus => 2)
    classes.each {|c| c.save!}
    
    races = []
    races << Race.new(:name => 'Dragonborn', :speed => 6, :size => 'medium', :vision => 'normal')
    races << Race.new(:name => 'Dwarf', :speed => 5, :size => 'medium', :vision => 'low-light')
    races << Race.new(:name => 'Eladrin', :speed => 6, :size => 'medium', :vision => 'low-light')
    races << Race.new(:name => 'Elf', :speed => 7, :size => 'medium', :vision => 'low-light')
    races << Race.new(:name => 'Half-elf', :speed => 6, :size => 'medium', :vision => 'low-light')
    races << Race.new(:name => 'Halfling', :speed => 6, :size => 'small', :vision => 'normal')
    races << Race.new(:name => 'Human', :speed => 6, :size => 'medium', :vision => 'normal')
    races << Race.new(:name => 'Tiefling', :speed => 6, :size => 'medium', :vision => 'low-light')
    races.each {|r| r.save!}    
  end

  def self.down
    drop_table :characters
    drop_table :classes
    drop_table :races
  end
end
