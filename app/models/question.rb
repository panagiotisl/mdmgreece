class Question < ActiveRecord::Base
  belongs_to :form
  validates_presence_of :description
  validates_presence_of :category
  validate :validate_choices

  has_many :choices, dependent: :destroy
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :choices, :reject_if => :all_blank, :allow_destroy => true



  def validate_choices
    errors.add(:choices, "There must be more than one choices") if self.category == "multiple" and choices.size < 2
  end

end
