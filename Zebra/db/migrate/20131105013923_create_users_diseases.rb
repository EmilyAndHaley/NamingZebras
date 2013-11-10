class CreateUsersDiseases < ActiveRecord::Migration
  def change
    create_table :users_diseases do |t|
      t.references :users, index: true
      t.references :disease, index: true
      t.timestamps
    end
  end
end
