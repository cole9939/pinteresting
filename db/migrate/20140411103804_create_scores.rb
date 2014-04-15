class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.string :type
      t.references :pin, index: true
      t.references :user, index: true
      t.timestamps
    end
  end
end
