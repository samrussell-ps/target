require 'rails_helper'

describe WordValidator do
  let(:dictionary_word) { DictionaryWord.find_by_word!("DEVELOPER") }
  let(:params) { { dictionary_word: dictionary_word,
                   word_shuffle_seed: 234,
                   centre_letter_offset: 6} }
  let(:board) { Board.create!(params) }
  let(:word_to_submit) { nil }
  let(:dictionary_word_to_submit) { DictionaryWord.find_by_word(word_to_submit) }
  let(:word_validator) { WordValidator.new(board, dictionary_word_to_submit) }
  subject(:call) { word_validator.call }

  context 'with word "PEEL"' do
    let(:word_to_submit) { 'PEEL' }

    it { is_expected.to be true }

    it 'does not set error' do
      expect { word_validator.call }.to_not change { word_validator.errors }
    end
  end

  context 'word ROLE (does not use centre letter)' do
    let(:word_to_submit) { 'ROLE' }

    it { is_expected.to be false }

    it 'sets "word does not use centre letter" error' do
      expect { word_validator.call }.to change { word_validator.errors }.by([:word_does_not_use_centre_letter])
    end
  end

  context 'word "PRLV"' do
    let(:word_to_submit) { 'PRLV' }

    it { is_expected.to be false }

    it 'sets "word is not in dictionary" error' do
      expect { word_validator.call }.to change { word_validator.errors }.by([:word_is_not_in_dictionary])
    end
  end

  context 'word "BUCKET"' do
    let(:word_to_submit) { 'BUCKET' }

    it { is_expected.to be false }

    it 'sets "word is not in grid" error' do
      expect { word_validator.call }.to change { word_validator.errors }.by([:word_is_not_in_grid])
    end
  end
end
