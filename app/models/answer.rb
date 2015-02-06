class Answer < ActiveRecord::Base
  belongs_to :filling
  belongs_to :question
  validates_presence_of :category
  validate :correctly_filled
  validates :content, :numericality => { :greater_than_or_equal_to => 0 }, :if => :number_question?
  
  has_many :picks, dependent: :destroy
  accepts_nested_attributes_for :picks, :reject_if => :all_blank, :allow_destroy => true

  def number_question?
    self.category == "number"
  end

  def correctly_filled
    self.errors.add(:answer, "You must fill in text questions") if self.category == "text" and self.content.empty?
    self.errors.add(:answer, "You must fill in number questions") if self.category == "number" and self.content.empty?
    self.errors.add(:answer, "You must select a choice in multiple choice questions") if self.category == "multiple" and self.picks.size<1
    self.errors.add(:answer, "You must select a choice in dropdown questions") if self.category == "dropdown" and self.picks.size<1
  end

end