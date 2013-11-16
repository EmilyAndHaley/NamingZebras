class CreateSymptoms < ActiveRecord::Migration
  def change
    create_table :symptoms do |t|
      t.string :name
      t.string :description
      t.integer :signId
      t.timestamps
    end
  end
end
