class Geek < ApplicationRecord
  include ActionController::Serialization

  # TODO: связать таблицы и настроить удаление
  has_many :applies
end
