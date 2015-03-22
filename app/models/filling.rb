class Filling < ActiveRecord::Base
  belongs_to :form
  has_many :answers, dependent: :destroy
  has_many :examinations, dependent: :destroy
  accepts_nested_attributes_for :answers, :reject_if => :all_blank, :allow_destroy => true
  validates_presence_of :form_id
  validates :serial, :numericality => { :greater_than_or_equal_to => 0 }


end
