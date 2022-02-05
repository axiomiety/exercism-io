NTHS = {1:    {'t':'X','u':'I','f':'V'},
        10:   {'t':'C','u':'X','f':'L'},
        100:  {'t':'M','u':'C','f':'D'},
        1000: {'t':'_','u':'M','f':'_'},
        }

PATTERNS = {
  1: 'u',
  2: 'uu',
  3: 'uuu',
  4: 'uf',
  5: 'f',
  6: 'fu',
  7: 'fuu',
  8: 'fuuu',
  9: 'ut'
}

def numeral(arabic):
  ''' return the roman equivalent of arabic '''
  ret = []
  for k,v in reversed(sorted(NTHS.items())):
    n = arabic // k
    if n:
      for pattern in PATTERNS[n]:
        ret.append(v[pattern])
      arabic -= n*k
  return ''.join(ret)
