package namedEntity;

import feed.Feed;
import feed.Article;
import namedEntity.heuristic.Heuristic;
import java.util.ArrayList;


/**
 * Esta clase modela la tabla de entidades nombradas
 */
public class NamedEntityTable {
    private ArrayList<NamedEntity> namedEntityList;

    public NamedEntityTable() {
        this.namedEntityList = new ArrayList<NamedEntity>();
    }

    public void addEntity(NamedEntity namedEntity) {
        this.namedEntityList.add(namedEntity);
    }

    public NamedEntity getEntity(int i) {
        return this.namedEntityList.get(i);
    }

    public ArrayList<NamedEntity> getNamedEntityList() {
        return namedEntityList;
    }

    public void computeNamedEntities(Feed feed, Heuristic heuristic) {
        for (Article a : feed.getArticleList()) {
            // Loop over every word in the title string
            String text = a.getTitle() + " " +  a.getText();  
			
		    String charsToRemove = ".,;:()'!?\n";
		    for (char c : charsToRemove.toCharArray()) {
                text = text.replace(String.valueOf(c), "");
		    }
            
            String[] words = text.split(" ");
            
            for (String word : words) {
                // Check if the word is a named entity
                if (heuristic.isEntity(word)) {
                    // If it is, add it to the named entity table
                    ArrayList<NamedEntity> neList = this.getNamedEntityList();
                    boolean isPresent = false;
                    for (NamedEntity ne2 : neList) {
                        if (word.equals(ne2.getName())) {
                            isPresent = true;
                            ne2.incFrequency();
                        }
                    }
                    if (!isPresent) {
                        String cat = heuristic.getCategory(word);
                        String theme = heuristic.getTheme(word);
                        if (cat != null && theme != null) {
                            switch (cat) {
                                case "Company":
                                    switch (theme) {
                                        case "Other":
                                            NamedEntityOrganizationOther neCT = 
                                                new NamedEntityOrganizationOther(word, 1);
                                            this.addEntity(neCT);
                                            break;
                                        default:
                                            NamedEntity neDef = 
                                                new NamedEntity(word, 1);
                                            this.addEntity(neDef);
                                            break;
                                    }
                                    break;
                                case "Person":
                                    switch (theme) {
                                        case "Other":
                                            NamedEntityPersonOther neCT = 
                                                new NamedEntityPersonOther(word, 1);
                                            this.addEntity(neCT);
                                            break;
                                        case "International":
                                            NamedEntityPersonInternational nePP = 
                                                new NamedEntityPersonInternational(word, 1);
                                            this.addEntity(nePP);
                                            break;
                                        default:
                                            NamedEntity neDef = new NamedEntity(word, 1);
                                            this.addEntity(neDef);
                                            break;
                                        }
                                        break;
                                case "Location":
                                    switch (theme) {
                                        case "Other":
                                            NamedEntityLocationOther neLO = 
                                                new NamedEntityLocationOther(word, 1);
                                            this.addEntity(neLO);
                                            break;
                                        default:
                                            NamedEntity neDef = new NamedEntity(word, 1);
                                            this.addEntity(neDef);
                                            break;
                                    }
                                    break;
                                default:
                                    NamedEntity neDef = new NamedEntity(word, 1);
                                    this.addEntity(neDef);
                                    break;
                            }
                        } else {
                            NamedEntity neDef = new NamedEntity(word, 1);
                            this.addEntity(neDef);
                        }
                    }
                }
            }
        }
    }

    public void prettyPrint(String siteName) {
        System.out.println("----------------------------------------------------------------------------------------------");
        System.out.println("TABLA DE ENTIDADES NOMBRADAS " + siteName.toUpperCase());
        for (NamedEntity ne : this.namedEntityList) {
            ne.prettyPrint();
        }
        System.out.println("----------------------------------------------------------------------------------------------");
    }
}
