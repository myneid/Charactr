class CreateNotes < ActiveRecord::Migration
  def self.up
    create_table :notes do |t|
      t.integer :character_id, :null => false
      t.text :details, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :notes
  end
end
