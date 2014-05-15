class AddVideosCountToTutorials < ActiveRecord::Migration
  def change
    add_column :tutorials, :videos_count, :integer
  end
end
