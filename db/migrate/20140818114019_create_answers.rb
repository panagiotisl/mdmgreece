class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.belongs_to :filling, index: true
      t.belongs_to :question, index: true
      t.string :content
      t.date :date
      t.string :category

      t.timestamps
    end
  end
end
