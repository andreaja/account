class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.column :name, :string, :null => false
      t.column :balance, :integer, :null => false
    end
  end
 
  def self.down
    drop_table :users
  end
end
