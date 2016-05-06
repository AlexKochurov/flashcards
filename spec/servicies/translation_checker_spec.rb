require 'rails_helper'

describe TranslationChecker do

  it 'succeeds with correct translation' do
    card = Card.create(original_text: 'дом', translated_text: 'house',
                       user_id: 1, block_id: 1)
    check_result = TranslationChecker.new(card).check('house')
    expect(check_result.success?).to be true
  end

  it 'fails with incorrect translation' do
    card = Card.create(original_text: 'дом', translated_text: 'house',
                       user_id: 1, block_id: 1)
    check_result = TranslationChecker.new(card).check('RoR')
    expect(check_result.success?).to be false
  end

  it 'succeeds with correct Rus translation' do
    card = Card.create(original_text: 'house', translated_text: 'дом',
                       user_id: 1, block_id: 1)
    check_result = TranslationChecker.new(card).check('дом')
    expect(check_result.success?).to be true
  end

  it 'fails with wrong Rus translation' do
    card = Card.create(original_text: 'house', translated_text: 'дом',
                       user_id: 1, block_id: 1)
    check_result = TranslationChecker.new(card).check('RoR')
    expect(check_result.success?).to be false
  end

  it 'full_downcase makes its job' do
    card = Card.create(original_text: 'ДоМ', translated_text: 'hOuSe',
                       user_id: 1, block_id: 1)
    check_result = TranslationChecker.new(card).check('HousE')
    expect(check_result.success?).to be true
  end

  it 'full_downcase makes its job even in Rus case' do
    card = Card.create(original_text: 'hOuSe', translated_text: 'ДоМ',
                       user_id: 1, block_id: 1)
    check_result = TranslationChecker.new(card).check('дОм')
    expect(check_result.success?).to be true
  end

  it 'feels OK with levenshtein_distance = 1' do
    card = Card.create(original_text: 'дом', translated_text: 'house',
                       user_id: 1, block_id: 1)
    check_result = TranslationChecker.new(card).check('hous')
    expect(check_result.success?).to be true
  end

  it 'feels OK with levenshtein_distance = 1 (Rus)' do
    card = Card.create(original_text: 'house', translated_text: 'дом',
                       user_id: 1, block_id: 1)
    check_result = TranslationChecker.new(card).check('дым')
    expect(check_result.success?).to be true
  end

  it 'fails with levenshtein_distance = 2' do
    card = Card.create(original_text: 'дом', translated_text: 'house',
                       user_id: 1, block_id: 1)
    check_result = TranslationChecker.new(card).check('hauze')
    expect(check_result.success?).to be false
  end

  it 'fails with levenshtein_distance = 2 (Rus)' do
    card = Card.create(original_text: 'house', translated_text: 'дом',
                       user_id: 1, block_id: 1)
    check_result = TranslationChecker.new(card).check('дымы')
    expect(check_result.success?).to be false
  end
end
