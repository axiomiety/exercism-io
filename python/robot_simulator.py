
NORTH = 'N'
EAST  = 'E'
SOUTH = 'S'
WEST  = 'W'

_TURNS = ['N','E','S','W']
_ADV = {
  'N':  (0,1),
  'S':  (0,-1),
  'W':  (-1,0),
  'E':  (1,0)
}
_ACTIONS = {
  'R':  'turn_right',
  'L':  'turn_left',
  'A':  'advance'
}

def turn(bearing, direction):
  offset = 1 if direction == 'right' else -1
  idx = _TURNS.index(bearing)
  return _TURNS[(idx+offset)%len(_TURNS)]

def advance(bearing, coordinates):
  offsets = _ADV[bearing]
  return tuple(map(sum, zip(coordinates, offsets)))

class Robot(object):
  
  def __init__(self, bearing=NORTH, x=0, y=0):
    self.bearing = bearing
    self.coordinates = (x,y)

  def advance(self):
    self.coordinates = advance(self.bearing, self.coordinates)

  def turn_left(self):
    self.bearing = turn(self.bearing, 'left')

  def turn_right(self):
    self.bearing = turn(self.bearing, 'right')
  
  def simulate(self, path):
    for p in path:
      getattr(self, _ACTIONS[p])()
