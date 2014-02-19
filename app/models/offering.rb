class Offering < ActiveRecord::Base
  belongs_to :member
  attr_accessible :amount_cents, :given_on, :method

  scope :created_today, -> { where('date(created_at) = date(?)', Time.zone.today).order('created_at DESC') }

  delegate :membership_number, to: :member

  def amount
    (amount_cents / 100.0).round(2)
  end
end
