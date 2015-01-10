class AddVideolinkToPost < ActiveRecord::Migration
  def change
    add_column :posts, :videolink, :string
  end
end
