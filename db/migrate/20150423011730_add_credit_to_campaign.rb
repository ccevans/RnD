class AddCreditToCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :credit, :string
  end
end
