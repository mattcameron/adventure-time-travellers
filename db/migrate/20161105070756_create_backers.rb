class CreateBackers < ActiveRecord::Migration[5.0]
  def change
    create_table :backers do |t|
      t.integer :name
      t.integer :challenge_id
      t.string :email

      t.timestamps
    end
  end
end
