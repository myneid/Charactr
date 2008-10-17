class AddTempHp < ActiveRecord::Migration
  def self.up
    add_column :characters, :temp_hit_points, :integer, :null => false, :default => 0
  end
  
  def self.down
    remove_column :characters, :temp_hit_points
  end
end
