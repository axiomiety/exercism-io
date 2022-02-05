from functools import lru_cache

# we use the lru_cache decoractor to cache the return values of the calls

@lru_cache()
def on_square(sq):
  return 2**(sq-1) 

@lru_cache()
def total_after(sq):
  return sum(on_square(i) for i in range(1,sq+1))
