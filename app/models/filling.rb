require 'csv'

class Filling < ActiveRecord::Base
  belongs_to :form
  has_many :answers, dependent: :destroy
  has_many :examinations, dependent: :destroy
  accepts_nested_attributes_for :answers, :reject_if => :all_blank, :allow_destroy => true
  accepts_nested_attributes_for :examinations, :reject_if => :all_blank, :allow_destroy => true
  validates_presence_of :form_id
  validates :serial, :numericality => { :greater_than_or_equal_to => 0 }
  validates :serial, uniqueness: { scope: :form_id,
                                 message: 'serial should be unique in the scope of every form' }


  def self.to_csv
    CSV.generate do |csv|
      @questions = ['Αύξων Αριθμός', 'Περιοχή', 'Ημερομηνία', 'Εξέταση', 'Ιατρός', 'Πρόγραμμα']
      unless all.first.nil?
        all.first.form.questions.reverse.each do |question|
          @questions << question.description
        end
        csv << @questions
        all.each do |filling|
          filling.examinations.each do |examination|
            @filling = []
            @filling << filling.serial
            @filling << filling.area
            @filling << examination.date
            @filling << examination.content
            @filling << examination.doctor
            @filling << examination.program
            filling.answers.order(question_id: :asc).each do |answer|
              @content = answer.content
              if @content.nil? or @content.empty?
                @choices = []
                answer.picks.each do |pick|
                  @choices << pick.choice.content.to_s.strip
                end
                @filling << @choices.join(', ')
              else
                @filling << answer.content.to_s.strip
              end
            end
            csv << @filling
          end
        end
      end
    end
  end


end