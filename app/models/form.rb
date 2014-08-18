class Form < ActiveRecord::Base

  belongs_to :user
  has_many :questions, dependent: :destroy
  has_many :fillings, dependent: :destroy
  accepts_nested_attributes_for :questions, :reject_if => :all_blank, :allow_destroy => true
  validates_presence_of :title
  validates_presence_of :user_id

end
