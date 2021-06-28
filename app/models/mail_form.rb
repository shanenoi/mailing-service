class MailForm < ApplicationRecord
  validates :name,
            presence: true,
            uniqueness: true
end
