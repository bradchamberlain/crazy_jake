class AddColorsToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :menu_text_color, :string
    add_column :customers, :menu_bg_color, :string
    add_column :customers, :body_text_color, :string
    add_column :customers, :body_bg_color, :string
  end
end
