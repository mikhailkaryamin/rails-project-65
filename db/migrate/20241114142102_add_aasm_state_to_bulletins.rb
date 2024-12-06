class AddAasmStateToBulletins < ActiveRecord::Migration[7.2]
  def change
    add_column :bulletins, :state, :string, default: 'draft', null: false
  end
end
