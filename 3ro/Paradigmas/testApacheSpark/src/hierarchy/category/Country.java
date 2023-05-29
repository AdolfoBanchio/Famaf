package hierarchy.category;

public abstract class Country extends Location {
    protected int population;
    protected String capital;
    protected String language;

    public Country(String name, int frequency) {
        super(name, frequency);
    }

    public void setPopulation(int population) {
        this.population = population;
    }

    public int getPopulation() {
        return this.population;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    public String getLanguage() {
        return this.language;
    }
}
