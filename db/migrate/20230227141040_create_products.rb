class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
			t.string :product_name
      t.string :brand
      t.integer :actual_price
      t.integer :offer
      t.integer :offer_price
      t.text :description
      t.string :category
      t.string :consumer_type

      t.timestamps
    end
  end
end
