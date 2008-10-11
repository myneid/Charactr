class CreatePowers < ActiveRecord::Migration

  def self.up
    create_table :powers do |t|
      t.integer :character_id, :null => false
      t.string :name, :null => false
      t.text :description
      t.string :frequency, :null => false # 'at-will', 'encounter', 'daily'
      t.integer :level_gained_at, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :powers
  end
end
