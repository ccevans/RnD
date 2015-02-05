class AddLinkToCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :link, :string
  end
end
