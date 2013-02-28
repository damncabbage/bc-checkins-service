class CreateCheckins < ActiveRecord::Migration
  def change
    create_table :checkins do |t|
      t.references :order
      t.references :product
      t.timestamps
    end
  end
end
