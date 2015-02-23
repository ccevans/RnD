class AddRewardToCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :reward, :text
  end
end
