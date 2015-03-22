class AddSerialToFillings < ActiveRecord::Migration
  def change
    add_column :fillings, :serial, :int
  end
end
