
class Hamming
  def self.compute (seq1, seq2) # self to make it static o_O
    dist = 0
    seq1.each_char.zip(seq2.each_char) do |s1,s2| # strings aren't lists in Ruby!
      dist += s1 != s2 ? 1 : 0
    end
    return dist
  end
end
