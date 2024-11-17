class DollarsToCentsConverter < ApplicationService
  def self.call!(dollars:, cents:)
    new(dollars:, cents:).result
  end

  attr_reader :result

  private

  def initialize(dollars:, cents:)
    @dollars = dollars.to_i
    @cents = cents.to_i
    convert!
  end

  def convert!
    @result = ((@dollars * 100) + @cents).to_i
  end
end
