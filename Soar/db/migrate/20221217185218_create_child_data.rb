class CreateChildData < ActiveRecord::Migration[7.0]
  def change
    create_table :child_data do |t|
      t.string :Name
      t.integer :IdNumber
      t.string :Gender
      t.date :DOB
      t.string :Address
      t.string :Religion
      t.string :HIV
      t.string :Disability
      t.date :DateReg
      t.string :Email

      t.timestamps
    end
  end
end
