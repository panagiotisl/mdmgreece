class Database < ActiveRecord::Base

  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :records, dependent: :destroy

end
