# == Schema Information
#
# Table name: backers
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  challenge_id :integer
#  email        :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Backer < ApplicationRecord
  belongs_to :challenge, optional: true
  has_many :payments

  validates :name, :email, :challenge_id, presence: true
end
