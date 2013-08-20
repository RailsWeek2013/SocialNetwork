class CreatePinboards < ActiveRecord::Migration
  def change
    create_table :pinboards do |t|
      t.integer :user_id
      t.text :entry

      t.timestamps
    end
  end
end
