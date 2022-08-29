class CreatePodia < ActiveRecord::Migration[7.0]
  def change
    create_table :podia do |t|
      t.references :user, null: false, foreign_key: true
      t.references :achievement, null: false, foreign_key: true

      t.timestamps
    end
  end
end
