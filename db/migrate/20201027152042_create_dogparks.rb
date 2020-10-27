class CreateDogparks < ActiveRecord::Migration
  def change
    create_table :dogparks do |t|
      t.string :name
      t.text :location
      t.text :description
      t.integer :user_id
    end
  end
end
