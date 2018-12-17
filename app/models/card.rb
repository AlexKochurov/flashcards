require 'super_memo'

class Card < ActiveRecord::Base
  belongs_to :block
  belongs_to :user

  validates :block_id,
            presence: { message: 'Выберите колоду из выпадающего списка.' }
  validates :interval, :repeat, :efactor, :quality, :attempt, presence: true
  validates :original_text, :translated_text, :review_date,
            presence: { message: 'Необходимо заполнить поле.' }
  validates :user_id, presence: true
  validates :user_id, presence: { message: 'Ошибка ассоциации.' }
  validate  :texts_are_not_equal

  before_validation :set_review_date_as_now, on: :create

  mount_uploader :image, CardImageUploader

  scope :pending, -> { where('review_date <= ?', Time.now).order('RANDOM()') }
  scope :repeating, -> { where('quality < ?', 4).order('RANDOM()') }


  def self.pending_cards_notification
    users = User.where.not(email: nil)
    users.each do |user|
      if user.cards.pending.any?
        CardsMailer.pending_cards_notification(user.email).deliver
      end
    end
  end

  protected

  def set_review_date_as_now
    self.review_date = Time.now
  end

  def texts_are_not_equal
    if full_downcase(original_text) == full_downcase(translated_text)
      errors.add(:original_text, 'Вводимые значения должны отличаться.')
    end
  end

  def full_downcase(str)
    str.mb_chars.downcase.to_s.squeeze(' ').lstrip
  end
end
