class CreateAcademics < ActiveRecord::Migration[7.0]
  def change
    create_table :academics do |t|
      t.integer :IdNumber
      t.string :SchoolName
      t.string :Class
      t.date :Date
      t.integer :Term
      t.string :Grade
      t.string :Remarks

      t.timestamps
    end
  end
end
