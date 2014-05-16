class AddSlugToTutorials < ActiveRecord::Migration
  def change
    add_column :tutorials, :slug, :string

    add_index :tutorials, :slug, unique: true
  end
end
