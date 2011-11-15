class CreateProvinces < ActiveRecord::Migration
  def change
    create_table :provinces do |t|
      t.string :name
      t.string :abbreviation
      t.integer :country_id

      t.timestamps
    end
  end
end
