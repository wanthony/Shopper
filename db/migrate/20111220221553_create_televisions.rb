class CreateTelevisions < ActiveRecord::Migration
  def self.up
    create_table :televisions do |t|
      t.string :model
      t.string :manufacturer
      t.string :rating
      t.float :price

      t.timestamps
    end
  end

  def self.down
    drop_table :televisions
  end
end
