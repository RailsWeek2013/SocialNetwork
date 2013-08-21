class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :sender
      t.references :reciepient
      t.text :msg

      t.timestamps
    end
  end
end
