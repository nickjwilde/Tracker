class User < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :uid
      t.string :provider
      t.string :name
      t.string :email
      t.string :oauth_token
      t.timestamps :oauth_expires_at
    end
  end
end
