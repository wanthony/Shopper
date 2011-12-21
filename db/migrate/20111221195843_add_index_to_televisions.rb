class AddIndexToTelevisions < ActiveRecord::Migration
  def self.up
    add_index :televisions, :model, :unique => true
  end

  def self.down
    remove_index :televisions, :column => :model
  end
end
