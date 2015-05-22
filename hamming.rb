
class Hamming
  def self.compute (seq1, seq2) # self to make it static o_O
    seq1.each_char.zip(seq2.each_char).inject(0) { |memo, s| s[0] == s[1] ? memo : memo+1 }
  end
end
