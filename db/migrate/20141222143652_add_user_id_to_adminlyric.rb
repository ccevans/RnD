class AddUserIdToAdminlyric < ActiveRecord::Migration
  def change
    add_column :adminlyrics, :user_id, :integer
  end
end
