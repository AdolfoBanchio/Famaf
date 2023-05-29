package hierarchy.category;

import java.time.LocalDate;

import namedEntity.NamedEntity;

public class Event extends NamedEntity {
    private String name;
    private LocalDate date;
    private Boolean recurrent;

    public Event(String name, int frequency) {
        super(name, frequency);
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public void setRecurrent(Boolean recurrent) {
        this.recurrent = recurrent;
    }

    public String getName() {
        return this.name;
    }

    public LocalDate getDate() {
        return this.date;
    }

    public Boolean getRecurrent() {
        return this.recurrent;
    }
}
