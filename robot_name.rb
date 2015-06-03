require 'set'

class Robot
  attr_reader :name
  
  @@names = Set.new
  @@alpha_uppercase = ('A'..'Z').to_a
  @@digits = (0..9).map{|i| i.to_s}

  def self.generate_unique_name
    # [A-Z]*2 + [0-9]*3
    uid = ''
    loop do
      2.times { uid << @@alpha_uppercase.sample }
      3.times { uid << @@digits.sample }
      break unless @@names.member? uid 
      uid = ''
    end
    @@names.add uid
    uid
  end

  def initialize
    @name = Robot.generate_unique_name
  end

  def reset
    @name = Robot.generate_unique_name
  end

end
