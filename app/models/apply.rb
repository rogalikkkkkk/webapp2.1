class Apply < ApplicationRecord
  include ActionController::Serialization

  belongs_to :geek
  belongs_to :job
end
