class AddLocationToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :location, :string
  end
end
