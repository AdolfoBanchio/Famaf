package hierarchy.category;

import namedEntity.NamedEntity;

public class Product extends NamedEntity {
    protected String commercial;
    protected String producer;

    public Product(String name, int frequency) {
        super(name, frequency);
    }

    public void setCommercial(String commercial) {
        this.commercial = commercial;
    }

    public String getCommercial() {
        return this.commercial;
    }

    public void setProducer(String producer) {
        this.producer = producer;
    }

    public String getProducer() {
        return this.producer;
    }
}
