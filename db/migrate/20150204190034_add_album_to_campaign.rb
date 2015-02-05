class AddAlbumToCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :album, :string
  end
end
