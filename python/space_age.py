EARTH_YEAR_SECONDS = 31557600

CYCLES = {'earth'     : 1,
          'mercury'   : 0.2408467,
          'venus'     : 0.61519726,
          'mars'      : 1.8808158,
          'jupiter'   : 11.862615,
          'saturn'    : 29.447498,
          'uranus'    : 84.016846,
          'neptune'   : 164.79132,
          }

class SpaceAge(object):
  
  def __init__(self, seconds):
    self.seconds = seconds

  def age_on_planet(self, period):
    return round(self.seconds/(period*EARTH_YEAR_SECONDS),2)

def _addfn(fname, period):
  def f(self):
    return self.age_on_planet(period=period)
  import copy
  fn = copy.copy(f)
  fn.__name__ = fname # otherwise this defaults to 'f'
  return f

for planet, period in CYCLES.items():
  fname = 'on_{0}'.format(planet)
  setattr(SpaceAge, fname, _addfn(fname, period))
