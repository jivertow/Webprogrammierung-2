class Product < ActiveRecord::Base
default_scope :order => 'title' 
	validates :title, :description, :image_ur, :presence => true
	validates :price, :numericality => {:greater_than_of_equal_to => 0.01}
	validates :title, :uniqueness => true
	validates :image_ur, :format => { :with => %r{\.(gif|jpg|png)$}i, :message => 'must be a url for GIF, JPG or PNG image.'}
	has_many :line_items
	
	before_destroy :ensure_not_referenced_by_any_line_item
	
	def ensure_not_referenced_by_any_line_item
		if line_items.count.zero?
			return true
		else
			errors[:base] << "Line Items present"
			return false
		end
	end
end
