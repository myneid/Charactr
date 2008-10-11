class CreateWeapons < ActiveRecord::Migration

  def self.up
    create_table :weapons do |t|
      t.integer :character_id, :null => false
      t.string :name, :null => false
      t.text :description
      t.string :key_ability
      t.timestamps
    end
  end

  def self.down
    drop_table :weapons
  end
end
