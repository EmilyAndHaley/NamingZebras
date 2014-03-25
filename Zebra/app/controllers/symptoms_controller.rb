class SymptomsController < ApplicationController
  	def current
  	  	def suggestions
    		@symplist = Symptom.find(:all, :select=> 'name').map {|u| u.name}
    		render json: @symplist
  	  	end

  	  	user = User.all.count
  	  	puts user.to_yaml
  	end
end
