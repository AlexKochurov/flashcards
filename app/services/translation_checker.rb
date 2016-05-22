class TranslationChecker
  CheckResult = Struct.new(:distance) do
    def success?
      distance <= 1
    end
  end

  attr_reader :card

  delegate :translated_text, :interval, :repeat,
           :efactor, :attempt, :distance, to: :card

  def initialize(card)
    @card = card
  end

  def check(user_translation)
    distance = Levenshtein.distance(full_downcase(translated_text),
                                    full_downcase(user_translation))

    sm_hash = SuperMemo.algorithm(interval, repeat, efactor, attempt, distance, 1)

    if distance <= 1
      sm_hash.merge!(review_date: Time.now + interval.to_i.days, attempt: 1)
    else
      sm_hash.merge!(attempt: [5, attempt + 1].min)
    end

    @card.update!(sm_hash)
    CheckResult.new(distance)
  end

  private

  def full_downcase(str)
    str.mb_chars.downcase.to_s.squeeze(' ').lstrip
  end
end
