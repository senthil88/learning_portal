class AddTutorialsCountToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :tutorials_count, :integer
  end
end
