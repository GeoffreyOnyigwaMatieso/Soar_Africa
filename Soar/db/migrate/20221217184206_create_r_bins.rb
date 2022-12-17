class CreateRBins < ActiveRecord::Migration[7.0]
  def change
    create_table :r_bins do |t|
      t.string :Email
      t.integer :IdNumber
      t.string :Name
      t.string :Gender
      t.string :Address
      t.string :RemovedDate
      t.string :AcademicStatus
      t.string :Remarks

      t.timestamps
    end
  end
end
