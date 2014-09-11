class Property < ActiveRecord::Base

	geocoded_by :full_address
	
	after_validation :geocode, :if => :address_changed?

	belongs_to :user

	has_many :rooms 

	has_many :reviews, as: :imageable

	has_many :pictures, as: :imageable, :dependent => :destroy
	
	accepts_nested_attributes_for :pictures

	validates_each :pictures do |property, attr, value|
  	property.errors.add attr, "too much pictures for property" if property.pictures.size > 3
  end

 	validates_each :rooms do |property, attr, value|
  	property.errors.add attr, "Property cannot have more than 5 or less than 0 rooms" if property.rooms.size > 5
  end

	def total_rooms
	end

	def total_rooms=(number)
		return if number.to_i == self.rooms.count
		self.rooms.none? ? create_rooms_for_roomless_property(number) : updates_room_quantity_in_property(number)
	end

	def create_rooms_for_roomless_property(number)
		1.upto(number.to_i) { |n| self.rooms << Room.create(number: n) }
	end

	def updates_room_quantity_in_property(number)
		self.rooms.count.upto(number.to_i - 1) { |n| self.rooms << Room.create(number: (n + 1)) }
	end

	def full_address
		"#{self.address},#{self.city},#{self.postcode}"
	end

	def display_full_address
		"#{self.address} #{self.city}, #{self.postcode}"
	end

	def average_rating
		self.reviews.empty? ? "No reviews have been added." : reviews.average(:rating)
	end

	def pluralized_review
		self.reviews.count < 2 ? "review" : "reviews"
	end

end