class Form < ActiveRecord::Base

  belongs_to :user
  has_many :questions, dependent: :destroy
  has_many :fillings, dependent: :destroy
  accepts_nested_attributes_for :questions, :reject_if => :all_blank, :allow_destroy => true
  validates_presence_of :title
  validates_presence_of :user_id
  validate :presence_of_questions
  
  def presence_of_questions
    errors.add(:questions, "There must be at least one question") if self.questions.size < 1
  end

end
