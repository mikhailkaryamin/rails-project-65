class CreateBulletins < ActiveRecord::Migration[7.2]
  def change
    create_table :bulletins do |t|
      t.string :title, limit: 50, null: false
      t.text :description, limit: 1000, null: false
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
