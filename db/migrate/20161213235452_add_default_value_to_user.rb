class AddDefaultValueToUser < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :status, :string, default: "active"
  end
end
