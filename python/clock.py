
class Clock(object):
  def __init__(self, hours, minutes):
    self.minutes = minutes % 60
    self.hours = (hours + minutes // 60) % 24

  def add(self, minutes):
    m = (self.minutes +  minutes) % 60
    h = (self.hours + (self.minutes + minutes) // 60) % 24
    return Clock(h,m)

  def __repr__(self):
    return '{hours:02}:{minutes:02}'.format(hours=self.hours, minutes=self.minutes)

  def __eq__(self, clock):
    return str(self) == str(clock)
