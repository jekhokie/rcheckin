class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.string :uid,      :null => false, :default => ""
      t.string :provider, :null => false, :default => ""
      t.string :email,    :null => false, :default => ""

      t.references :user

      t.timestamps
    end
  end
end
