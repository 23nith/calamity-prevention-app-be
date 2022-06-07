class AttributeStrategy
  def initialize
    @strategy = FactoryBot.strategy_by_name(:build).new
  end

  delegate :association, to: :@strategy

  def result(evaluation)
    evaluation.hash
  end
end