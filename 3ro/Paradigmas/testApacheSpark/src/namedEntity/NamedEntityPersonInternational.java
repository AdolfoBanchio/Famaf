package namedEntity;

import hierarchy.category.Person;
import hierarchy.topic.InternationalPolitics;

public class NamedEntityPersonInternational extends Person implements InternationalPolitics {
	
	public NamedEntityPersonInternational(String name, int frequency) {
		super(name, frequency);
	}

	@Override
	public String toString() {
		return "NamedEntity [name=" + name + ", frequency=" + frequency + ", category=Person, Theme=InternationalPolitics]";
	}
}