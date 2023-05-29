package namedEntity;

import hierarchy.category.Person;
import hierarchy.topic.Other;

public class NamedEntityPersonOther extends Person implements Other {
	
	public NamedEntityPersonOther(String name, int frequency) {
		super(name, frequency);
	}

	@Override
	public String toString() {
		return "NamedEntity [name=" + name + ", frequency=" + frequency + ", category=Person, Theme=Other]";
	}
}