class AddAudiolinkToPost < ActiveRecord::Migration
  def change
    add_column :posts, :audiolink, :string
  end
end
