class OfferingForm
  include ActiveModel::Model

  attr_accessor :membership_number, :amount, :given_on, :method

  validates_presence_of :membership_number, :amount, :method, :given_on
  validate :member_exists?

  def member_exists?
    errors.add(:membership_number, "doesn't exist") unless member
    member
  end

  def member
    @member ||= Member.find_by_membership_number(membership_number)
  end

  def amount
    @amount.to_i
  end

  def amount_cents
    amount * 100
  end

  def save
    return false unless valid?
    member.offerings.create amount_cents: amount_cents,
                            method: method,
                            given_on: given_on.to_date
  end
end
