class AddEnableToForms < ActiveRecord::Migration
  def change
    add_column :forms, :serial_enabled, :boolean
    add_column :forms, :area_enabled, :boolean
    add_column :forms, :date_enabled, :boolean
    add_column :forms, :content_enabled, :boolean
    add_column :forms, :doctor_enabled, :boolean
    add_column :forms, :program_enabled, :boolean
  end
end
