class CreateHealths < ActiveRecord::Migration[7.0]
  def change
    create_table :healths do |t|
      t.integer :IdNumber
      t.date :Date
      t.string :Complication
      t.string :Status
      t.string :Hospital
      t.string :FinalStatus

      t.timestamps
    end
  end
end
