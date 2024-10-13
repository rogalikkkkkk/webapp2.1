class Job < ApplicationRecord
  belongs_to :company
  has_many :applies

  validates :name, :place, length: { maximum: 50 }
  validates :name, :place, :company_id, presence: true
  validates :company_id, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
end
