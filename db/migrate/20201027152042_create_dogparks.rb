class CreateParks < ActiveRecord::Migration
  def change
    create_table :parks do |t|
      t.string :name
      t.text :location
      t.text :description
      t.integer :owner_id
    end
  end
end
