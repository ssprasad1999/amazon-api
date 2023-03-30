class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :name
			t.integer :mobile_number
			t.string :password_digest
			t.string :email
			t.date :date_of_birth
			t.string :gender
			t.string :address
			
      t.timestamps
    end
  end
end
