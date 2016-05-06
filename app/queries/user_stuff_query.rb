class UserStuffQuery
  def initialize(user)
    @user = user
  end

  def current_block
    @current_block ||= @user.current_block
  end

  def cards
    current_block ? current_block.cards : @user.cards
  end

  def find_card(card_id = nil)
    return @user.cards.find(card_id) if card_id
    cards.pending.first || cards.repeating.first
  end
end