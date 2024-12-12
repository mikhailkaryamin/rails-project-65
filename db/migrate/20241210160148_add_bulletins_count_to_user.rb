class AddBulletinsCountToUser < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :bulletins_count, :integer, default: 0
  end
end
