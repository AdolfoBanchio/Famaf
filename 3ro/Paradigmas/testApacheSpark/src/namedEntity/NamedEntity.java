package namedEntity;
import java.io.Serializable;

/*Esta clase modela la nocion de entidad nombrada*/

public class NamedEntity implements Serializable{
	protected String name;
	protected int frequency;
	
	public NamedEntity(String name, int frequency) {
		super();
		this.name = name;
		this.frequency = frequency;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCategory() {
		return name;
	}

	public void setCategory(String name) {
		this.name = name;
	}

	public int getFrequency() {
		return frequency;
	}

	public void setFrequency(int frequency) {
		this.frequency = frequency;
	}

	public void incFrequency() {
		this.frequency++;
	}

	@Override
	public String toString() {
		return "NamedEntity [name=" + name + ", frequency=" + frequency + "]";
	}
	public void prettyPrint(){
		System.out.println(this.toString());
	}
}



