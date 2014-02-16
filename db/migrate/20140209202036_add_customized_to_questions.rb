class AddCustomizedToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :customized, :boolean
    add_column :questions, :custom_values, :text
    add_column :questions, :custom_type, :integer
  end
end
