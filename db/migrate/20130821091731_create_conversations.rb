class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.integer :sender_id
      t.integer :reciepient_id

      t.timestamps
    end

    add_index :conversations, [:sender_id, :reciepient_id], unique: true
  end
end
