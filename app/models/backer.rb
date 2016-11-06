# == Schema Information
#
# Table name: backers
#
#  id           :integer          not null, primary key
#  name         :integer
#  challenge_id :integer
#  email        :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Backer < ApplicationRecord
  belongs_to :challenge
end
