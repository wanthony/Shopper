class AddNameToTelevisions < ActiveRecord::Migration
  def self.up
    add_column :televisions, :name, :string
  end

  def self.down
    remove_column :televisions, :name
  end
end
