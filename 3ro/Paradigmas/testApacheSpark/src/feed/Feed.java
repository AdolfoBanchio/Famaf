package feed;

import java.util.List;

import parser.RssParser;

/*Esta clase modela la lista de articulos de un determinado feed*/
public class Feed {
	String siteName;
	List<Article> articleList;
	
	public Feed(RssParser parser) {
		super();
		this.siteName = parser.getSiteName();
	    this.articleList = parser.getArticleList();
	}

	public String getSiteName(){
		return siteName;
	}
	
	public void setSiteName(String siteName){
		this.siteName = siteName;
	}
	
	public List<Article> getArticleList(){
		return articleList;
	}
	
	public void setArticleList(List<Article> articleList){
		this.articleList = articleList;
	}
	
	public void addArticle(Article a){
		this.getArticleList().add(a);
	}
	
	public Article getArticle(int i){
		return this.getArticleList().get(i);
	}
	
	public int getNumberOfArticles(){
		return this.getArticleList().size();
	}
	
	@Override
	public String toString(){
		return "Feed [siteName=" + getSiteName() + ", articleList=" + getArticleList() + "]";
	}
	

	public void prettyPrint(){
		System.out.println("\n----------------------------------------------------------------------------------------------\n");
		System.out.println("			" + this.getSiteName().toUpperCase() + " feed			");
		System.out.println("\n----------------------------------------------------------------------------------------------\n");
		for (Article a: this.getArticleList()){
			a.prettyPrint();
		}
		
	}
	
	// public static void main(String[] args) {
	// 	  Article a1 = new Article("This Historically Black University Created Its Own Tech Intern Pipeline",
	// 		  "A new program at Bowie State connects computing students directly with companies, bypassing an often harsh Silicon Valley vetting process",
	// 		  new Date(),
	// 		  "https://www.nytimes.com/2023/04/05/technology/bowie-hbcu-tech-intern-pipeline.html"
	// 		  );
		 
	// 	  Article a2 = new Article("This Historically Black University Created Its Own Tech Intern Pipeline",
	// 			  "A new program at Bowie State connects computing students directly with companies, bypassing an often harsh Silicon Valley vetting process",
	// 			  new Date(),
	// 			  "https://www.nytimes.com/2023/04/05/technology/bowie-hbcu-tech-intern-pipeline.html"
	// 			  );
		  
	// 	  Article a3 = new Article("This Historically Black University Created Its Own Tech Intern Pipeline",
	// 			  "A new program at Bowie State connects computing students directly with companies, bypassing an often harsh Silicon Valley vetting process",
	// 			  new Date(),
	// 			  "https://www.nytimes.com/2023/04/05/technology/bowie-hbcu-tech-intern-pipeline.html"
	// 			  );
		  
	// 	  Feed f = new Feed("nytimes");
	// 	  f.addArticle(a1);
	// 	  f.addArticle(a2);
	// 	  f.addArticle(a3);

	// 	  f.prettyPrint();
		  
	// }
	
}
