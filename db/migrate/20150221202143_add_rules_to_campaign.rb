class AddRulesToCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :rules, :text
  end
end
