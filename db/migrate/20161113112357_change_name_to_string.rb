class ChangeNameToString < ActiveRecord::Migration[5.0]
  def up
    change_column :backers, :name, :string
  end

  def down
    change_column :backers, :name, :integer
  end
end
