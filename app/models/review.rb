class Review < ActiveRecord::Base


	validates :rating, inclusion: (1..5)
	
	belongs_to :imageable, polymorphic: true

	end

