package namedEntity;

import hierarchy.category.Location;
import hierarchy.topic.Other;

public class NamedEntityLocationOther extends Location implements Other {
    
    public NamedEntityLocationOther(String name, int frequency) {
        super(name, frequency);
	}

	@Override
	public String toString() {
		return "NamedEntity [name=" + name + ", frequency=" + frequency + ", category=Location, Theme=Other]";
	}
}
