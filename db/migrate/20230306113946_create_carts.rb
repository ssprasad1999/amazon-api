class CreateCarts < ActiveRecord::Migration[7.0]
  def change
		# This was the last migration
    create_table :carts do |t|
      t.string :product_name
			t.text :description
      t.integer :price
      t.integer :quantity
			t.integer :total_price
			t.integer :product_id
			t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
