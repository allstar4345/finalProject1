class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.integer :follower_id
      t.integer :leader_id

      t.timestamps
    end
    
    add_index :groups, :follower_id
    add_index :groups, :leader_id
  end
  
  def self.down
    drop_table :groups
  end
end
