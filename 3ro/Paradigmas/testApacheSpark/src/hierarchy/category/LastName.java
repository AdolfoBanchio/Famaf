package hierarchy.category;

public class LastName extends Person {
    private String canonicalForm;
    private String origin;

    public LastName(String name, int frequency) {
        super(name, frequency);
    }

    public void setCanonicalForm(String canonicalForm) {
        this.canonicalForm = canonicalForm;
    }

    public String getCanonicalForm() {
        return this.canonicalForm;
    }

    public void setOrigin(String origin) {
        this.origin = origin;
    }

    public String getOrigin() {
        return this.origin;
    }
}
