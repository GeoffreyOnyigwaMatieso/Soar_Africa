class CreateAdmins < ActiveRecord::Migration[7.0]
  def change
    create_table :admins do |t|
      t.string :Name
      t.string :Email
      t.string :Gender
      t.string :Address
      t.date :DOB

      t.timestamps
    end
  end
end
