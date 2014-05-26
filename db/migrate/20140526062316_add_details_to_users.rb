class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fullname, :string
    add_column :users, :location, :string
  end
end
