class Company < ApplicationRecord
  include ActionController::Serialization

  # TODO: связать таблицы и настроить удаление
  has_many :jobs

  validates_associated :jobs
  validates :name, :location, length: { maximum: 50 }
  validates :name, :location, presence: true, on: [:create, :update]
end
