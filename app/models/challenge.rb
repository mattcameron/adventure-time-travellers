# == Schema Information
#
# Table name: challenges
#
#  id          :integer          not null, primary key
#  description :text(65535)
#  amount      :decimal(10, 2)
#  status      :integer          default(0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Challenge < ApplicationRecord
  has_many :backers
  has_many :payments
end
