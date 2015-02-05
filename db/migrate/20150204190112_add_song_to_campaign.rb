class AddSongToCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :song, :string
  end
end
