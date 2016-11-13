class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.integer :backer_id
      t.decimal :amount, precision: 10, scale: 2
      t.integer :status, default: 0
      t.integer :challenge_id
      t.string :fail_reason

      t.timestamps
    end
  end
end
