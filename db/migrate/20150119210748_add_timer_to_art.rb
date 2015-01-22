class AddTimerToArt < ActiveRecord::Migration
  def change
    add_column :arts, :timer, :string
  end
end
