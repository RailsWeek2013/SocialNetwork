class CreateAvatarsForRailsUser < ActiveRecord::Migration
  def up    
    add_attachment :users, :logo
  end
  
  def self.down
    remove_attachment :users, :logo
  end
end
