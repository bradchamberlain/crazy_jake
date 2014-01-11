class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :text
      t.integer :index
      t.references :survey, index: true
      t.boolean :yes_no
      t.boolean :rating
      t.boolean :free_form

      t.timestamps
    end
  end
end
