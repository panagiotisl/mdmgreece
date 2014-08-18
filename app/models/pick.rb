class Pick < ActiveRecord::Base
  belongs_to :answer
  belongs_to :choice
end
