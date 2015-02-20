class User < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :github_handle
      t.string :uid
      t.string :token

      t.timestamps null: false
    end
  end
end
