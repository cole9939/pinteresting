class AddOwnerIdToScore < ActiveRecord::Migration
  def change
    add_column :scores, :owner_id, :integer
  end
end
