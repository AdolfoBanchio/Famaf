package namedEntity.heuristic;

import java.util.Map;
import java.io.Serializable;
public abstract class Heuristic implements Serializable{

	private static Map<String, String> categoryMap = Map.of(
			"Microsoft", "Organization",
			"Apple", "Organization",
			"Google", "Organization",
			"Musk", "Person",
			"Biden", "Person",
			"Trump", "Person",
			"Messi", "Person",
			"Federer", "Person",
			"US", "Location",
			"Russia", "Location"
	);

	private static Map<String, String> themeMap = Map.of(
			"Microsoft", "Other",
			"Apple", "Other",
			"Google", "Other",
			"Musk", "Other",
			"Biden", "International",
			"Trump", "International",
			"Messi", "Football",
			"Federer", "Tenis",
			"US", "Other",
			"Russia", "Other"
	);


	public String getCategory(String entity){
		return categoryMap.get(entity);
	}

	public String getTheme(String entity){
		return themeMap.get(entity);
	}

	public abstract boolean isEntity(String word);

}
