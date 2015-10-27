class CreateExaminations < ActiveRecord::Migration
  def change
    create_table :examinations do |t|
      t.date :date
      t.text :content
      t.text :doctor
      t.text :program

      t.references :filling, index: true

      t.timestamps
    end
  end
end
