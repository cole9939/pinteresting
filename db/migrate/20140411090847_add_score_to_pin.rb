class AddScoreToPin < ActiveRecord::Migration
  def change
    add_column :pins, :score, :integer
  end
end
