class AddUserIdToLyric < ActiveRecord::Migration
  def change
    add_column :lyrics, :user_id, :integer
  end
end
