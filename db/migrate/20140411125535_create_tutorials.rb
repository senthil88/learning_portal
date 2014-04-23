class CreateTutorials < ActiveRecord::Migration
  def change
    create_table :tutorials do |t|
      t.belongs_to :course, index: true, null: false

      t.string :title, null: false
      t.string :image_url

      t.text :description

      t.timestamps
    end
  end
end
