class CreateDogs < ActiveRecord::Migration
  def change
    create_table :dogs do |t|
      t.string :name
      t.integer :age
      t.string :breed
      t.integer :owner_id
    end
  end
end
