class AddCampaignIdToArts < ActiveRecord::Migration
  def change
    add_column :arts, :campaign_id, :integer
  end
end
