class AddTitleAndImageToVideos < ActiveRecord::Migration[7.0]
  def change
    add_column :videos, :title, :string
    add_column :videos, :image_url, :string
  end
end
