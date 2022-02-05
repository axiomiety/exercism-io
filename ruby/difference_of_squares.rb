
class Squares
  def initialize(n)
    @n = n
  end

  def difference
    return square_of_sums - sum_of_squares
  end

  def square_of_sums
    return ((@n**2+@n)/2)**2
  end

  def sum_of_squares
    return (2*@n**3 + 3*@n**2 + @n) / 6
  end
end
