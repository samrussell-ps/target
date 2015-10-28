require 'rails_helper'

RSpec.describe DictionaryEntry, type: :model do
  it 'accepts uppercase words of non-zero length' do
    expect(DictionaryEntry.create(word: 'ABCD')).to be_valid
  end

  it 'does not accept lowercase words' do
    expect(DictionaryEntry.create(word: 'abcd')).to_not be_valid
  end

  it 'does not accept mixed case words' do
    expect(DictionaryEntry.create(word: 'Abcd')).to_not be_valid
  end

  it 'does not accept zero length or nil words' do
    expect(DictionaryEntry.create(word: '')).to_not be_valid
    expect(DictionaryEntry.create(word: nil)).to_not be_valid
  end

  it 'does not accept non-alpha words words' do
    expect(DictionaryEntry.create(word: '234')).to_not be_valid
    expect(DictionaryEntry.create(word: '%!')).to_not be_valid
  end
end
