class Ticket < ActiveRecord::Base
  belongs_to :project
  belongs_to :author, class_name: "User"
  
  has_many :assets, dependent: :destroy
  accepts_nested_attributes_for :assets, reject_if: :all_blank
  
  has_many :comments, dependent: :destroy
  
  validates :title, presence: true
  validates :description, presence: true
  validates :description, presence: true, length: { minimum: 10 }
end
