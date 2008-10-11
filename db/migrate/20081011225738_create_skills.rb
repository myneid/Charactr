class CreateSkills < ActiveRecord::Migration
  def self.up
    create_table :skills do |t|
      t.string :name, :null => false
      t.string :key_ability, :null => false
      t.timestamps
    end
    
    # set up the default skill list
    skills = []
    skills << Skill.new(:name => 'Acrobatics', :key_ability => 'Dexterity')
    skills << Skill.new(:name => 'Arcana', :key_ability => 'Intelligence')
    skills << Skill.new(:name => 'Athletics', :key_ability => 'Strength')
    skills << Skill.new(:name => 'Bluff', :key_ability => 'Charisma')
    skills << Skill.new(:name => 'Diplomacy', :key_ability => 'Charisma')
    skills << Skill.new(:name => 'Dungeoneering', :key_ability => 'Wisdom')
    skills << Skill.new(:name => 'Endurance', :key_ability => 'Constitution')
    skills << Skill.new(:name => 'Heal', :key_ability => 'Wisdom')
    skills << Skill.new(:name => 'History', :key_ability => 'Intelligence')
    skills << Skill.new(:name => 'Insight', :key_ability => 'Wisdom')
    skills << Skill.new(:name => 'Intimidate', :key_ability => 'Charisma')
    skills << Skill.new(:name => 'Nature', :key_ability => 'Wisdom')
    skills << Skill.new(:name => 'Perception', :key_ability => 'Wisdom')
    skills << Skill.new(:name => 'Religion', :key_ability => 'Intelligence')
    skills << Skill.new(:name => 'Stealth', :key_ability => 'Dexterity')
    skills << Skill.new(:name => 'Streetwise', :key_ability => 'Charisma')
    skills << Skill.new(:name => 'Thievery', :key_ability => 'Dexterity')
    skills.each {|s| s.save!}
    
  end

  def self.down
    drop_table :skills
  end
end
