class AddAdminToUsers < ActiveRecord::Migration
  class AddAdminToUsers < ActiveRecord::Migration
    def self.up

    end

    def self.down
      remove_column :users, :admin
    end
  end
end
