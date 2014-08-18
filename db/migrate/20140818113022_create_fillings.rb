class CreateFillings < ActiveRecord::Migration
  def change
    create_table :fillings do |t|
      t.belongs_to :form, index: true

      t.timestamps
    end
  end
end
