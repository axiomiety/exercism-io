class Luhn(object):

  def __init__(self, num):
    self.num = num

  def addends(self):
    s = 0
    for i, d in enumerate(Luhn.digits(self.num), 1):
      x = (2*d if 2*d < 10 else 2*d-9) if i%2 == 0 else d
      s += x*10**(i-1)
    return Luhn.digits(s)

  def checksum(self):
    return sum(self.addends()) % 10

  def is_valid(self):
    return self.checksum() == 0

  @staticmethod
  def create(n):
    ''' adds a check digit such that n becomes a valid Luhn number '''
    nn = n*10 # make 'space' for the check digit
    # we brute-force it
    for i in range(10):
      candidate = nn + i
      if Luhn(candidate).is_valid():
        return candidate

  @staticmethod
  def digits(n):
    ''' yields the digits from right to left '''
    while n:
      r = n % 10
      n //= 10 # integer div
      yield r
