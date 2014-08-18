class Answer < ActiveRecord::Base
  belongs_to :filling
  belongs_to :question
  validates_presence_of :category
  validate :correctly_filled

  has_many :picks, dependent: :destroy
  accepts_nested_attributes_for :picks, :reject_if => :all_blank, :allow_destroy => true

  def correctly_filled
    puts "PAOK"
    puts self.content
    errors.add(:answers, "You must fill in the answers of text questions") if self.category == "text" and self.content.empty?
  end

end
