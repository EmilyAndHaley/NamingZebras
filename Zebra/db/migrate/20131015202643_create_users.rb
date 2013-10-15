class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :firstName, null:false
      t.string :lastName, null: false
      t.string :middleName
      t.timestamp :DOB
      t.string :sex, limit: 1
      t.string :cAddress
      t.string :telephone, limit: 25
      t.string :race
      t.string :ethnicity
      t.string :nationality
      t.string :occupation
      t.timestamp :YOD
      t.string :birthOrigin
      t.integer :houseSize
      t.string :groupHouse
      t.string :biologicalParent
      t.string :gestation
      t.integer :births
      t.string :eyeColor
      t.string :contact, limit: 1

      t.timestamps
    end
  end
end
