# == Schema Information
#
# Table name: payments
#
#  id           :integer          not null, primary key
#  backer_id    :integer
#  amount       :decimal(10, 2)
#  status       :integer          default("new")
#  challenge_id :integer
#  fail_reason  :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Payment < ApplicationRecord
  belongs_to :backer
  belongs_to :challenge

  enum status: [:untouched, :paid, :failed]
end
