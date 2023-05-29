package hierarchy.category;

import java.time.LocalDate;

import namedEntity.NamedEntity;

public class Date extends NamedEntity {
    private LocalDate date;
    private String canonicForm;
    
    public Date(String name, int frequency) {
        super(name, frequency);
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public LocalDate getDate() {
        return this.date;
    }

    public void setCanonicForm(String canonicForm) {
        this.canonicForm = canonicForm;
    }

    public String getCanonicForm() {
        return this.canonicForm;
    }
}
