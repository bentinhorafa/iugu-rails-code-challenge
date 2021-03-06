class TransferCreateService
  attr_reader :source_id, :destiny_id, :amount

  def initialize(source_id:, destiny_id:, amount:)
    @source_id = source_id
    @destiny_id = destiny_id
    @amount = amount
  end

  def self.create(...)
    new(...).create
  end

  def create
    return false unless amount.positive?
    return false if missing_account?
    return false unless enough_balance?

    create_transfers
  end

  private

  def source_account
    @source_account ||= Account.find_by(account_number: source_id)
  end

  def destiny_account
    @destiny_account ||= Account.find_by(account_number: destiny_id)
  end

  def create_transfers
    ActiveRecord::Base.transaction do
      source_account.transfers.create(amount: -amount)

      destiny_account.transfers.create(amount: amount)
    end
  end

  def missing_account?
    source_account.blank? || destiny_account.blank?
  end

  def enough_balance?
    source_account.balance >= amount
  end
end
