-module(space_age).
-export([ageOn/2]).

calc_age(Seconds, EarthYears) ->
  SecondsPerYearOnEarth = 31557600,
  Seconds/(SecondsPerYearOnEarth*EarthYears).

ageOn(earth,    Seconds) -> calc_age(Seconds, 1);
ageOn(mercury,  Seconds) -> calc_age(Seconds, 0.2408467);
ageOn(venus,    Seconds) -> calc_age(Seconds, 0.61519726);
ageOn(mars,     Seconds) -> calc_age(Seconds, 1.8808158);
ageOn(jupiter,  Seconds) -> calc_age(Seconds, 11.862615);
ageOn(saturn,   Seconds) -> calc_age(Seconds, 29.447498);
ageOn(uranus,   Seconds) -> calc_age(Seconds, 84.016846);
ageOn(neptune,  Seconds) -> calc_age(Seconds, 164.79132).
