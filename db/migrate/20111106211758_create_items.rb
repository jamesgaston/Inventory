class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.integer :user_id
      t.integer :number
      t.string :tags
      t.string :location
      t.integer :category_id
      t.integer :status_id

      t.timestamps
    end
  end
end
