class Licenceplate < ApplicationRecord
  acts_as_votable
  validates :plate, presence: true,
                    uniqueness: true,
                    length: { in: 6..7 },
                    format: { with: /\A[\d\a-z]{3} ?[\d\a-z]{3,4}\Z/i,
                    message: "entered is not a valid licence plate"}
end
