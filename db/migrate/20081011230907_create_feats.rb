class CreateFeats < ActiveRecord::Migration

  def self.up
    create_table :feats do |t|
      t.integer :character_id, :null => false
      t.string :name, :null => false
      t.text :description
      t.integer :level_gained_at, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :feats
  end
end
