class CreateSellers < ActiveRecord::Migration[7.0]
  def change
    create_table :sellers do |t|
			t.string :seller_email
			t.string :password_digest
			t.string :seller_name
			t.string :store_name
			t.string :seller_address
			t.date :seller_creation_date

      t.timestamps
    end
  end
end
