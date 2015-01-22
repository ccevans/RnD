class AddCounterCacheToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :counter_cache, :integer, :default => 0
  end
end
