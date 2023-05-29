package hierarchy.category;

import java.util.ArrayList;

public class Name extends Person {
    private String canonicalName;
    private String origin;
    private ArrayList<String> variants;

    public Name(String name, int frequency) {
        super(name, frequency);
        this.variants = new ArrayList<String>();
    }

    public void setCanonicalName(String canonicalName) {
        this.canonicalName = canonicalName;
    }

    public String getCanonicalName() {
        return this.canonicalName;
    }

    public void setOrigin(String origin) {
        this.origin = origin;
    }

    public String getOrigin() {
        return this.origin;
    }

    public void setVariants(ArrayList<String> variants) {
        this.variants = variants;
    }

    public ArrayList<String> getVariants() {
        return this.variants;
    }

    public void addVariant(String variant) {
        this.variants.add(variant);
    }
}
