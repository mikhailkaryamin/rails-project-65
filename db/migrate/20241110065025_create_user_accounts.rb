class CreateUserAccounts < ActiveRecord::Migration[7.2]
  def change
    create_table :user_accounts do |t|
      t.string :provider
      t.string :uid
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
