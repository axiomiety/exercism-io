#if !defined(SPACE_AGE_H)
#define SPACE_AGE_H
#include <map>
namespace space_age
{

    struct space_age
    {
        const std::map<std::string, double> orbital_periods = {
            {"Mercury", 0.2408467},
            {"Venus", 0.61519726},
            {"Mars", 1.8808158},
            {"Jupiter", 11.862615},
            {"Saturn", 29.447498},
            {"Uranus", 84.016846},
            {"Neptune", 164.79132},
        };
        const double seconds_per_earth_year = 31557600.0;
        const unsigned long long age_in_seconds;
        space_age(const unsigned long long a) : age_in_seconds(a) {}
        unsigned int seconds() const { return age_in_seconds; }
        double on_earth() const { return age_in_seconds / seconds_per_earth_year; }
        double on_mercury() const { return on_earth() / orbital_periods.at("Mercury"); }
        double on_venus() const { return on_earth() / orbital_periods.at("Venus"); }
        double on_mars() const { return on_earth() / orbital_periods.at("Mars"); }
        double on_jupiter() const { return on_earth() / orbital_periods.at("Jupiter"); }
        double on_saturn() const { return on_earth() / orbital_periods.at("Saturn"); }
        double on_uranus() const { return on_earth() / orbital_periods.at("Uranus"); }
        double on_neptune() const { return on_earth() / orbital_periods.at("Neptune"); }
    };
} // namespace space_age

#endif // SPACE_AGE_H