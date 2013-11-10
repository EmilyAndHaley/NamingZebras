class UsersDiseases < ActiveRecord::Base
  belongs_to :users
  belongs_to :disease
end
