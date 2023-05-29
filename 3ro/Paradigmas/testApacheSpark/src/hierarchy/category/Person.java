package hierarchy.category;

import namedEntity.NamedEntity;

public class Person extends NamedEntity {
    protected int id;

    public Person(String name, int frequency) {
        super(name, frequency);
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId() {
        return this.id;
    }
}
