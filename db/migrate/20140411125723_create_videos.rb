class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.belongs_to :tutorial, index: true, null: false

      t.string :title, null: false
      t.string :description
      t.string :video_url, null: false
      t.string :image_url
      t.string :file

      t.timestamps
    end
  end
end
