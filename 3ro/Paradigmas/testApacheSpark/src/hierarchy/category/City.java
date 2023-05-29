package hierarchy.category;

public class City extends Location{
    private Country country;
    private int population;

    public City(String name, int frequency) {
        super(name, frequency);
    }

    public void setCountry(Country country) {
        this.country = country;
    }

    public Country getCountry() {
        return this.country;
    }

    public void setPopulation(int population) {
        this.population = population;
    }

    public int getPopulation() {
        return this.population;
    }
}
