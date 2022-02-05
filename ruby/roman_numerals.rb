
class Fixnum

  @@dec_rom_map = { 1000 => 'M', 900 => 'CM', 500 => 'D', 400 => 'CD',
                     100 => 'C',  90 => 'XC',  50 => 'L',  40 => 'XL',
                      10 => 'X',   9 => 'IX',   5 => 'V',   4 => 'IV',
                       1 => 'I'}

  def to_roman
    tr = self
    ro = ''
    @@dec_rom_map.each_pair do |dec, r|
      while tr >= dec do
        ro << r # append in-place
        tr -= dec
      end
    end
    ro
  end

end
