class Licenceplate < ApplicationRecord
  acts_as_votable
  validates :plate, presence: true,
                    uniqueness: true,
                    length: { in: 6..7 },
                    format: { with: /\A[a-z]{1}[\d\a-z]{2} {1}[a-z]{3}\Z/i,
                    message: "entered is not a valid Quebec licence plate 🤦 <br/> A valid licence plate is: <br/>from [B00 AAA] <br/>to [ZZZ ZZZ] or [Z99 ZZZ]"}
end
