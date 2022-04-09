// This stub file contains items that aren't used yet; feel free to remove this module attribute
// to enable stricter warnings.
#![allow(unused)]

const CARS_PRODUCED_PER_HOUR: f64 = 221.;

pub fn production_rate_per_hour(speed: u8) -> f64 {
    let production_rate_per_hour = match speed {
      0 => 0.,
      1..=4 => 1.0,
      5..=8 => 0.9,
      9..=10 => 0.77,
      _ => panic!("Woops")
    };
    return (speed as f64) * CARS_PRODUCED_PER_HOUR * production_rate_per_hour;

}

pub fn working_items_per_minute(speed: u8) -> u32 {
  return (production_rate_per_hour(speed) /60.).floor() as u32;
}
