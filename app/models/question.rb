class Question < ActiveRecord::Base
  belongs_to :form
  validates_presence_of :description
  validates_presence_of :category
  validate :validate_choices
  validate :denture

  has_many :choices, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :picks, through: :answers
  accepts_nested_attributes_for :choices, :reject_if => :all_blank, :allow_destroy => true



  def validate_choices
    errors.add(:choices, " must be more than one") if self.category == "multiple" and choices.size < 2
  end

  def denture
    if self.category == 'denture'
      18.step(11,-1) { |i| self.choices.build(content: i) }
      21.step(28,1) { |i| self.choices.build(content: i) }
      48.step(41,-1) { |i| self.choices.build(content: i) }
      31.step(38,1) { |i| self.choices.build(content: i) }
      55.step(51,-1) { |i| self.choices.build(content: i) }
      61.step(65,1) { |i| self.choices.build(content: i) }
      85.step(81,-1) { |i| self.choices.build(content: i) }
      71.step(75,1) { |i| self.choices.build(content: i) }
    end
  end

end
