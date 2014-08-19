class Answer < ActiveRecord::Base
  belongs_to :filling
  belongs_to :question
  validates_presence_of :category
  validate :correctly_filled
  
  has_many :picks, dependent: :destroy
  accepts_nested_attributes_for :picks, :reject_if => :all_blank, :allow_destroy => true

  def correctly_filled
    self.errors.add(:answer, "You must fill in text questions") if self.category == "text" and self.content.empty?
    self.errors.add(:answer, "You must select a choice in multiple choice questions") if self.category == "multiple" and self.picks.size<1
  end

end
