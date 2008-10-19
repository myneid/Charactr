class AddArmorCheckPenalty < ActiveRecord::Migration
  def self.up
  
    add_column :characters, :armor_check_penalty, :integer, :null => false, :default => 0
    add_column :skills, :subject_to_armor_check_penalty, :boolean, :null => false, :default => false
    
    AddArmorCheckPenalty.apply_armor_check_penalty Skill.find_by_name('Acrobatics')
    AddArmorCheckPenalty.apply_armor_check_penalty Skill.find_by_name('Athletics')
    AddArmorCheckPenalty.apply_armor_check_penalty Skill.find_by_name('Endurance')
    AddArmorCheckPenalty.apply_armor_check_penalty Skill.find_by_name('Stealth')
    AddArmorCheckPenalty.apply_armor_check_penalty Skill.find_by_name('Thievery')
  
  end

  def self.apply_armor_check_penalty(skill)
    say "Adding armor check penalty to #{skill.name}"
    skill.subject_to_armor_check_penalty = true
    skill.save!
  end

  def self.down
    remove_column :skills, :subject_to_armor_check_penalty
    remove_column :characters, :armor_check_penalty
  end
end
