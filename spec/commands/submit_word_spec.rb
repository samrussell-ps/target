require 'rails_helper'

RSpec.describe SubmitWord do
  let(:dictionary_word) { DictionaryWord.find_by_word!("DEVELOPER") }
  let(:params) { { dictionary_word: dictionary_word,
                   word_shuffle_seed: 234,
                   centre_letter_offset: 6} }
  let(:board) { Board.create!(params) }
  let(:word_to_submit) { nil }
  let(:submit_word) { SubmitWord.new(board, word_to_submit) }

  describe '#call' do
    subject(:call) { submit_word.call }

    context 'with word "peel"' do
      let(:word_to_submit) { 'peel' }

      it { is_expected.to be true }

      it 'creates a new SubmittedWord' do
        expect { submit_word.call }.to change { board.submitted_words.size }.by(1)
      end

      it 'does not set error' do
        expect { submit_word.call }.to_not change { submit_word.errors }
      end
    end

    context 'with word "peel", a second time' do
      let(:word_to_submit) { 'peel' }

      before do
        SubmitWord.new(board, word_to_submit).call
      end

      it { is_expected.to be false }

      it 'does not create a new SubmittedWord' do
        expect { submit_word.call }.to_not change { board.submitted_words.size }
      end

      it 'sets "word has been submitted error' do
        expect { submit_word.call }.to change { submit_word.errors }.by([SubmitWord::ERROR_MESSAGES[:word_has_been_submitted]])
      end
    end

    context 'word role (does not use centre letter)' do
      let(:word_to_submit) { 'role' }

      it { is_expected.to be false }

      it 'does not create a new SubmittedWord' do
        expect { submit_word.call }.to_not change { board.submitted_words.size }
      end

      it 'sets "word does not use centre letter" error' do
        expect { submit_word.call }.to change { submit_word.errors }.by([SubmitWord::ERROR_MESSAGES[:word_does_not_use_centre_letter]])
      end
    end

    context 'word "prlv"' do
      let(:word_to_submit) { 'prlv' }

      it { is_expected.to be false }

      it 'does not create a new SubmittedWord' do
        expect { submit_word.call }.to_not change { board.submitted_words.size }
      end

      it 'sets "word is not in dictionary" error' do
        expect { submit_word.call }.to change { submit_word.errors }.by([SubmitWord::ERROR_MESSAGES[:word_is_not_in_dictionary]])
      end
    end

    context 'word "bucket"' do
      let(:word_to_submit) { 'bucket' }

      it { is_expected.to be false }

      it 'does not create a new SubmittedWord' do
        expect { submit_word.call }.to_not change { board.submitted_words.size }
      end

      it 'sets "word is not in grid" error' do
        expect { submit_word.call }.to change { submit_word.errors }.by([SubmitWord::ERROR_MESSAGES[:word_is_not_in_grid]])
      end
    end
  end
end
