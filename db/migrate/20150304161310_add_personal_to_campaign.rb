class AddPersonalToCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :personal, :boolean
  end
end
