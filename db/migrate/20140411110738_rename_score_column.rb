class RenameScoreColumn < ActiveRecord::Migration
  def self.up
    rename_column :scores, :type, :click_on
  end

  def self.down
    # rename back if you need or do something else or do nothing
  end
end
