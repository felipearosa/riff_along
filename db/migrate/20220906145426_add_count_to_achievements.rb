class AddCountToAchievements < ActiveRecord::Migration[7.0]
  def change
    add_column :achievements, :count, :integer, default: 0
  end
end
