class Apply < ApplicationRecord
  include ActionController::Serialization
  # TODO: связать таблицы и настроить удаление
  belongs_to :geek
  belongs_to :job
end
