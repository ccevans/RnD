class AddCampaignIdToArts < ActiveRecord::Migration
  def change
    add_column :arts, :campaign_id, :integer, :default => "2"
  end
end
