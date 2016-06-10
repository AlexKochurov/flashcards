require 'rails_helper'

describe TranslationChecker do
  def card(orig, trans)
    create(:card, original_text: orig, translated_text: trans, user_id: 1, block_id: 1)
  end

  def check_result(test_card, translation)
    TranslationChecker.new(test_card).check(translation)
  end

  it 'succeeds with correct translation' do
    expect(check_result(card('дом', 'house'), 'house')).to be_success
  end

  it 'fails with incorrect translation' do
    expect(check_result(card('дом', 'house'), 'RoR')).not_to be_success
  end

  it 'succeeds with correct Rus translation' do
    expect(check_result(card('house', 'дом'), 'дом')).to be_success
  end

  it 'fails with wrong Rus translation' do
    expect(check_result(card('house', 'дом'), 'RoR')).not_to be_success
  end

  context 'full_downcase' do
    it 'makes its job' do
      expect(check_result(card('ДоМ', 'hOuSe'), 'HousE')).to be_success
    end

    it 'makes its job (rus)' do
      expect(check_result(card('hOuSe', 'ДоМ'), 'дОм')).to be_success
    end
  end

  context "Levenstain distance" do
    it 'it is OK when equals to 1' do
      expect(check_result(card('дом', 'house'), 'hous')).to be_success
    end

    it 'it is OK when equals to 1 (rus)' do
      expect(check_result(card('house', 'дом'), 'дым')).to be_success
    end

    it 'fails when greater than 1' do
      expect(check_result(card('дом', 'house'), 'hauze')).not_to be_success
    end

    it 'fails when greater than 1 (rus)' do
      expect(check_result(card('house', 'дом'), 'дымы')).not_to be_success
    end
  end
end
