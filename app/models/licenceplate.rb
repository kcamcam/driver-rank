class Licenceplate < ApplicationRecord
  acts_as_votable
  validates :plate, presence: true,
                    uniqueness: true,
                    length: { in: 6..7 },
                    format: { with: /\A[a-z]{1}[\d\a-z]{2} {1}[a-z]{3}\Z/i,
                    message: "is not a valid Quebec licence plate."}
end
