class AddAreaToFilling < ActiveRecord::Migration
  def change
    add_column :fillings, :area, :text
  end
end
