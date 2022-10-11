class AddRiffToSolos < ActiveRecord::Migration[7.0]
  def change
    add_column :solos, :riff, :text
  end
end
