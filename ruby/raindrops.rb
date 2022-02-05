
class Raindrops
  @@rainspeak = { 3 => 'Pling',
                  5 => 'Plang',
                  7 => 'Plong',
                }

  def self.convert rd
    say = []
    @@rainspeak.each_pair { |fac,out| say.push(out) if rd % fac == 0 }
    return rd.to_s if say.empty?
    return say.join
  end
end
