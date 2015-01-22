class AddCounterCacheToLyrics < ActiveRecord::Migration
  def change
    add_column :lyrics, :counter_cache, :integer, :default => 0
  end
end
