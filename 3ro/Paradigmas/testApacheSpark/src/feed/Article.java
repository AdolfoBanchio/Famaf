package feed;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.io.Serializable;

import namedEntity.*;
import namedEntity.heuristic.Heuristic;

/*Esta clase modela el contenido de un articulo (ie, un item en el caso del rss feed) */

public class Article implements Serializable{
	private String title;
	private String text;
	private Date publicationDate;
	private String link;
	
	private List<NamedEntity> namedEntityList = new ArrayList<NamedEntity>();
	
	
	public Article(String title, String text, Date publicationDate, String link) {
		super();
		this.title = title;
		this.text = text;
		this.publicationDate = publicationDate;
		this.link = link;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public Date getPublicationDate() {
		return publicationDate;
	}

	public void setPublicationDate(Date publicationDate) {
		this.publicationDate = publicationDate;
	}

	public String getLink() {
		return link;
	}

	public void setLink(String link) {
		this.link = link;
	}
	
	@Override
	public String toString() {
		return "Article [title=" + title + ", text=" + text + ", publicationDate=" + publicationDate + ", link=" + link
				+ "]";
	}
	
	public List<NamedEntity> getNamedEntityList() {
		return namedEntityList;
	}
	public void addEntity(NamedEntity ne){
		this.namedEntityList.add(ne);
	}
	
	public NamedEntity getNamedEntity(String namedEntity){
		for (NamedEntity n: namedEntityList){
			if (n.getName().compareTo(namedEntity) == 0){				
				return n;
			}
		}
		return null;
	}

	public void computeNamedEntitys(Heuristic heuristic){
		String text = this.getTitle() + " " +  this.getText();

		String charsToRemove = ".,;:()'!?\n";
		for (char c : charsToRemove.toCharArray()) {
			text = text.replace(String.valueOf(c), "");
		}

		String[] words = text.split(" ");

		for (String word : words) {
			// Check if the word is a named entity
			if (heuristic.isEntity(word)) {
				// If it is, add it to the named entity table
				List<NamedEntity> neList = this.getNamedEntityList();
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
	
	public void prettyPrint() {
		System.out.println("**********************************************************************************************");
		System.out.println("Title: " + this.getTitle());
		System.out.println("Publication Date: " + this.getPublicationDate());
		System.out.println("Link: " + this.getLink());
		System.out.println("Text: " + this.getText());
		System.out.println("**********************************************************************************************");
		
	}
	
	public static void main(String[] args) {
		  Article a = new Article("This Historically Black University Created Its Own Tech Intern Pipeline",
			  "A new program at Bowie State connects computing students directly with companies, bypassing an often harsh Silicon Valley vetting process",
			  new Date(),
			  "https://www.nytimes.com/2023/04/05/technology/bowie-hbcu-tech-intern-pipeline.html"
			  );
		 
		  a.prettyPrint();
	}
	
	
}



