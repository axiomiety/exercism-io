
class Complement
  @@complement = {'G' => 'C',
                  'C' => 'G',
                  'T' => 'A',
                  'A' => 'U',
                 }

  def self.of_dna (strand) # static
    c = []
    strand.each_char { |s| c.push(@@complement.fetch(s) {raise ArgumentError}) }
    return c.join
  end

  def self.of_rna (strand)
    c = []
    strand.each_char { |s| c.push(@@complement.invert.fetch(s) {raise ArgumentError}) }
    return c.join
  end

end
