class AddCounterCacheToArts < ActiveRecord::Migration
  def change
    add_column :arts, :counter_cache, :integer, :default => 0
  end
end
