class DeleteCompletedFromAchievements < ActiveRecord::Migration[7.0]
  def change
    remove_column :achievements, :completed
  end
end
