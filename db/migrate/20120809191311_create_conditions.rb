class CreateConditions < ActiveRecord::Migration
  def up
    create_table :conditions do |t|
      t.boolean :state, :default => false

      t.references :user

      t.timestamps
    end
  end

  def down
    drop_table :conditions
  end
end
