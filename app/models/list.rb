class List < ActiveRecord::Base
	validates_presence_of :name

	has_many :products, dependent: :destroy



	belongs_to :user


end
