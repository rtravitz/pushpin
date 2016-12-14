class CreateRatings < ActiveRecord::Migration[5.0]
  def change
    create_table :ratings do |t|
      t.float :score
      t.text :comment
      t.references :user, index: true, foreign_key: true
      t.references :giver, index: true

      t.timestamps
    end

    add_foreign_key :ratings, :users, column: :giver_id
    add_index :ratings, [:user_id, :giver_id], unique: true
  end
end
