class AddTimer2ToCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :timer2, :string
  end
end
