class UsersSymptoms < ActiveRecord::Base
  belongs_to :users
  belongs_to :symptoms
end