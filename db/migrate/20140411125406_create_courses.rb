class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name, null: false
      t.string :image_url

      t.text :description

      t.timestamps
    end
  end
end
