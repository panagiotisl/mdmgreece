class Pick < ActiveRecord::Base
  belongs_to :answer
  belongs_to :choice
  
  validates_presence_of :choice_id
  
end
