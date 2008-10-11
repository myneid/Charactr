class CreateCampaigns < ActiveRecord::Migration
  def self.up
    create_table :campaigns do |t|
      t.string :name, :null => false
      t.integer :created_by_user_id, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :campaigns
  end
end
