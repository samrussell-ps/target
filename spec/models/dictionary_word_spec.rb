require 'rails_helper'

RSpec.describe DictionaryWord, type: :model do
  it 'accepts uppercase words of non-zero length' do
    expect(DictionaryWord.create(word: 'ABCD')).to be_valid
  end

  it 'does not accept lowercase words' do
    expect(DictionaryWord.create(word: 'abcd')).to_not be_valid
  end

  it 'does not accept mixed case words' do
    expect(DictionaryWord.create(word: 'Abcd')).to_not be_valid
  end

  it 'does not accept zero length or nil words' do
    expect(DictionaryWord.create(word: '')).to_not be_valid
    expect(DictionaryWord.create(word: nil)).to_not be_valid
  end

  it 'does not accept non-alpha words words' do
    expect(DictionaryWord.create(word: '234')).to_not be_valid
    expect(DictionaryWord.create(word: '%!')).to_not be_valid
  end

  describe '#seed_word' do
    it 'returns a randomly-chosen DictionaryWord' do
      sample_entries = 10.times.map { DictionaryWord.seed_word }

      expect(sample_entries.uniq.size).to be > 8
    end

    it 'returns a DictionaryWord with a 9 letter word' do
      sample_entries = 10.times.map { DictionaryWord.seed_word.word.length }

      expect(sample_entries).to eq( 10.times.map { 9 } )
    end
  end
end
