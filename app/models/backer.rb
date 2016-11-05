# == Schema Information
#
# Table name: backers
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  challenge_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Backer < ApplicationRecord
  belongs_to :user
  belongs_to :challenge
end
