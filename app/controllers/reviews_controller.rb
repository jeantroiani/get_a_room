class ReviewsController < ApplicationController

	def index
		if params[:property_id]
			@property = Property.find(params[:property_id])
			@reviews = @property.reviews.all
		else
			@user = User.find(params[:user_id])
			@reviews = @user.reviews.all
		end
		@review = Review.new
	end

	def create
		if params[:property_id]
			property = Property.find(params[:property_id])
			property.reviews.create(params[:review].permit(:thoughts, :rating))

		else
			raise 'hell'
			user = User.find(params[:user_id])
			user.reviews.create(params[:review].permit(:thoughts))
		end
		redirect_to :back
	end
	
end