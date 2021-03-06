# wordlist obtained from http://www-01.sil.org/linguistics/wordlists/english/wordlist/wordsEn.txt
wordlist_path = File.join(Rails.root, 'db', 'resources', 'wordlist.txt')

wordlist = File.read(wordlist_path)

words = wordlist.split("\r\n")

words_to_load = words.shuffle

valid_words_to_load = words_to_load.select { |word| word.match(/\A[A-Za-z]+\z/).present? && word.size <= 9 }

word_arguments = valid_words_to_load.map { |word| { word: word.upcase, sorted_letters: word.upcase.chars.sort.join } }

ActiveRecord::Base.transaction do
  DictionaryWord.destroy_all

  DictionaryWord.create!(word_arguments)
end


