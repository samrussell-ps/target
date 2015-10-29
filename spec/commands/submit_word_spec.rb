require 'rails_helper'

RSpec.describe SubmitWord do
  let(:dictionary_entry) { DictionaryEntry.order("RANDOM()").first }
  let(:params) { { dictionary_entry: dictionary_entry, word_shuffle_seed: 234 } }
  let(:board) { Board.create!(params) }
  let(:word_to_submit) { nil }
  let(:submit_word) { SubmitWord.new(board, word_to_submit) }

  describe '#call' do
    subject(:call) { submit_word.call }

    context 'with word "bucket", no words submitted' do
      let(:word_to_submit) { 'bucket' }

      it { is_expected.to be true }

      it 'creates a new SubmittedWord' do
        expect { submit_word.call }.to change { board.submitted_words.size }.by(1)
      end

      it 'does not set error' do
        expect { submit_word.call }.to_not change { submit_word.errors }
      end
    end

    context 'word "zxcvbnnm"' do
      let(:word_to_submit) { 'zxcvbnnm' }

      it { is_expected.to be false }

      it 'does not create a new SubmittedWord' do
        expect { submit_word.call }.to_not change { board.submitted_words.size }
      end

      it 'sets "word is invalid" error' do
        expect { submit_word.call }.to change { submit_word.errors }.by([SubmitWord::ERROR_MESSAGES[:word_is_invalid]])
      end
    end
  end
end
