require 'rails_helper'

describe WordValidator do
  let(:dictionary_entry) { DictionaryEntry.find_by_word!("DEVELOPER") }
  let(:params) { { dictionary_entry: dictionary_entry,
                   word_shuffle_seed: 234,
                   maximum_score: 1,
                   centre_letter_offset: 6} }
  let(:board) { Board.create!(params) }
  let(:word_to_submit) { nil }
  let(:word_validator) { WordValidator.new(board, word_to_submit) }
  subject(:call) { word_validator.call }

  context 'with word "peel"' do
    let(:word_to_submit) { 'peel' }

    it { is_expected.to be true }

    it 'does not set error' do
      expect { word_validator.call }.to_not change { word_validator.errors }
    end
  end

  context 'word role (does not use centre letter)' do
    let(:word_to_submit) { 'role' }

    it { is_expected.to be false }

    it 'sets "word does not use centre letter" error' do
      expect { word_validator.call }.to change { word_validator.errors }.by([:word_does_not_use_centre_letter])
    end
  end

  context 'word "prlv"' do
    let(:word_to_submit) { 'prlv' }

    it { is_expected.to be false }

    it 'sets "word is not in dictionary" error' do
      expect { word_validator.call }.to change { word_validator.errors }.by([:word_is_not_in_dictionary])
    end
  end

  context 'word "bucket"' do
    let(:word_to_submit) { 'bucket' }

    it { is_expected.to be false }

    it 'sets "word is not in grid" error' do
      expect { word_validator.call }.to change { word_validator.errors }.by([:word_is_not_in_grid])
    end
  end
end
