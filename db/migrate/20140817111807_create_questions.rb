class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :description
      t.string :category
      t.boolean :required
      t.belongs_to :form, index: true

      t.timestamps
    end
  end
end
