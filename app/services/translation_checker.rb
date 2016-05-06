class TranslationChecker
  class CheckResult
    attr_reader :distance

    def initialize(distance)
      @distance = distance
    end

    def success?
      distance <= 1
    end
  end


  def initialize(card)
    @card = card
  end

  def check(user_translation)
    distance = Levenshtein.distance(full_downcase(@card.translated_text),
                                    full_downcase(user_translation))

    # Не смог найти и вспомнить, как заставить код выполняться, как если бы
    # self-ом был бы объект @card
    sm_hash = SuperMemo.algorithm(@card.interval, @card.repeat, @card.efactor,
                                  @card.attempt, distance, 1)

    if distance <= 1
      sm_hash.merge!(review_date: Time.now + @card.interval.to_i.days, attempt: 1)
    else
      sm_hash.merge!(attempt: [5, @card.attempt + 1].min)
    end

    @card.update!(sm_hash)
    CheckResult.new(distance)
  end

  private

  def full_downcase(str)
    str.mb_chars.downcase.to_s.squeeze(' ').lstrip
  end
end
