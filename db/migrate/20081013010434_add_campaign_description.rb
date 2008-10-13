class AddCampaignDescription < ActiveRecord::Migration
  def self.up
    add_column :campaigns, :description, :string
  end

  def self.down
    remove_column :campaigns, :description
  end
end
