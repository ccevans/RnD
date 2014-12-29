class AddAttachmentProfileimgToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.attachment :profileimg
    end
  end

  def self.down
    remove_attachment :users, :profileimg
  end
end
