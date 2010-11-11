class CreateTransactions < ActiveRecord::Migration
  def self.up
    create_table :transactions do |t|
      t.column :from_id, :integer, :null => false
      t.column :to_id, :integer, :null => false
      t.column :sum, :integer, :null => false
      t.column :status, :string, :null => false
      t.column :updated_at, :timestamp, :null => false
    end
  end
 
  def self.down
    drop_table :users
  end
end
