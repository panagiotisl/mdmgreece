class CreatePicks < ActiveRecord::Migration
  def change
    create_table :picks do |t|
      t.belongs_to :answer, index: true
      t.belongs_to :choice, index: true

      t.timestamps
    end
  end
end
