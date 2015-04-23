class AddCreditlinkToCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :creditlink, :string
  end
end
