class AddStatusColumnToProposal < ActiveRecord::Migration[5.0]
  def change
    add_column :proposals, :status, :string, default: "unassigned"
  end
end
