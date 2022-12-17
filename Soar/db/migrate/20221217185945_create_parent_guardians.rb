class CreateParentGuardians < ActiveRecord::Migration[7.0]
  def change
    create_table :parent_guardians do |t|
      t.integer :IdNumber
      t.string :Name
      t.integer :Phone
      t.string :FinancialStatus
      t.string :Address
      t.string :Occupation

      t.timestamps
    end
  end
end
