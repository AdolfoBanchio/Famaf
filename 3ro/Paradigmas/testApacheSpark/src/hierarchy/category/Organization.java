package hierarchy.category;

import namedEntity.NamedEntity;

public class Organization extends NamedEntity {
    protected int memberCount;
    protected String type;

    public Organization(String name, int frequency) {
        super(name, frequency);
    }

    public void setMemberCount(int memberCount) {
        this.memberCount = memberCount;
    }

    public int getMemberCount() {
        return this.memberCount;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getType() {
        return this.type;
    }
}
