class CreateExaminations < ActiveRecord::Migration
  def change
    create_table :examinations do |t|
      t.date :date
      t.string :content
      t.references :filling, index: true

      t.timestamps
    end
  end
end