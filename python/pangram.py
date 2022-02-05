import string

def is_pangram(s):
  return all(letter in s.lower() for letter in string.lowercase)
  
