class CreateSolos < ActiveRecord::Migration[7.0]
  def change
    create_table :solos do |t|
      t.float :starting_time
      t.float :ending_time
      t.boolean :done
      t.references :video, null: false, foreign_key: true

      t.timestamps
    end
  end
end
