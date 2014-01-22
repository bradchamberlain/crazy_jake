class AddAttachmentLogoToCustomers < ActiveRecord::Migration
  def self.up
    change_table :customers do |t|
      t.attachment :logo
    end
  end

  def self.down
    drop_attached_file :customers, :logo
  end
end
