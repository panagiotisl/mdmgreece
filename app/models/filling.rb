class Filling < ActiveRecord::Base
  belongs_to :form
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers, :reject_if => :all_blank, :allow_destroy => true
  validates_presence_of :form_id

end
