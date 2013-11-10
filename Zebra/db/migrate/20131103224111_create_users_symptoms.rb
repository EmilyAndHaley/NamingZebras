class CreateUsersSymptoms < ActiveRecord::Migration
  def change
    create_table :users_symptoms do |t|
      t.references :users, index: true
      t.references :symptoms, index: true
      t.date :startDate
      t.integer :frequency
      t.timestamps
    end
  end
end
