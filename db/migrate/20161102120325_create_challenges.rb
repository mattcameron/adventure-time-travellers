class CreateChallenges < ActiveRecord::Migration[5.0]
  def change
    create_table :challenges do |t|
      t.text :description
      t.decimal :amount, precision: 10, scale: 2
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
