class CreateConditions < ActiveRecord::Migration
  def change
    create_table :conditions do |t|
      t.boolean :state, :default => true

      t.references :user

      t.timestamps
    end
  end
end
