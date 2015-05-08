
def transform(old):
  return {w.lower(): k for k,v in old.items() for w in v}
      
