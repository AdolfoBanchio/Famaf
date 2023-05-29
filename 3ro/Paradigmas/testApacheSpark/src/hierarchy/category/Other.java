package hierarchy.category;

import java.util.ArrayList;
import namedEntity.NamedEntity;

public class Other extends NamedEntity {
    protected ArrayList<String> comments;

    public Other(String name, int frequency) {
        super(name, frequency);
        this.comments = new ArrayList<String>();
    }

    public void setComments(ArrayList<String> comments) {
        this.comments = comments;
    }

    public ArrayList<String> getComments() {
        return this.comments;
    }

    public void addComment(String comment) {
        this.comments.add(comment);
    }
}
