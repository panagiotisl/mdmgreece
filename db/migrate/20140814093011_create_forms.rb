class CreateForms < ActiveRecord::Migration
  def change
    create_table :forms do |t|
      t.string :title
      t.boolean :published
      t.boolean :open
      t.references :user

      t.timestamps
    end
  end
end
