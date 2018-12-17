class Block < ActiveRecord::Base
  belongs_to :user
  has_many :cards, dependent: :destroy

  validates :title, presence: { message: 'Необходимо заполнить поле.' }

  def current?
    id == user.current_block_id
  end
end
