package hierarchy.category;

public class Title extends Person {
    private String canonicalForm;
    private String profession;

    public Title(String name, int frequency) {
        super(name, frequency);
    }

    public void setCanonicalForm(String canonicalForm) {
        this.canonicalForm = canonicalForm;
    }

    public String getCanonicalForm() {
        return this.canonicalForm;
    }

    public void setProfession(String profession) {
        this.profession = profession;
    }

    public String getProfession() {
        return this.profession;
    }
}
