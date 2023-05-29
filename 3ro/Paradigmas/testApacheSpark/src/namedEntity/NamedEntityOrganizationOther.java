package namedEntity;

import hierarchy.category.Organization;
import hierarchy.topic.Other;

public class NamedEntityOrganizationOther extends Organization implements Other {

	public NamedEntityOrganizationOther(String name, int frequency) {
        super(name, frequency);
	}

	@Override
	public String toString() {
		return "NamedEntity [name=" + name + ", frequency=" + frequency + ", category=Organization, Theme=Other]";
	}
}