class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :nickname
      t.string :provider
      t.string :uid
      t.string :email
      t.string :image_url
      t.string :token

      t.timestamps null: false
    end
  end
end
