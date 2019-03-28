import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import com.mongodb.MongoClient;
import com.mongodb.MongoClientURI;

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.bson.Document;

public class insertMultiple {

	public static void main(String[] args) {
		// Turn off log messages
				Logger mongoLogger = Logger.getLogger( "org.mongodb.driver" );
				mongoLogger.setLevel(Level.SEVERE); 

				// Create string URI
				String dbURI = "mongodb://test:csis3300@35.247.121.99:27017/testDB";

				// Creating a Mongo client 
				MongoClient mongo = new MongoClient(new MongoClientURI(dbURI)); 

				// Accessing the database 
				MongoDatabase db = mongo.getDatabase("testDB");  

				// Creating a collection 
		/*		db.createCollection("inventory");  
				System.out.println("Collection created successfully"); */
				
				// Retrieving a collection
				MongoCollection<Document> collection = db.getCollection("inventory");
				
				// Delete one document
	//			collection.deleteOne(Filters.eq("item", "canvas"));
				
				// Insert multiple document to the collection
			    Document document2 = new Document("item", "journal") 
			    		 			 .append("qty", 25)
			    		 			 .append("size", new Document("h", 14).append("w", 21).append("uom", "cm") 
			    		 			 .append("status", "A")); 
			      
			    Document document3 = new Document("item", "mat") 
   		 			 .append("qty", 85)
   		 			 .append("size", new Document("h", 27.9).append("w", 35.5).append("uom", "cm") 
   		 			 .append("status", "A")); 
			    
			    List<Document> documents = new ArrayList<Document>();
			    
			    documents.add(document2);
			    documents.add(document3);
			    
			    collection.insertMany(documents);
			    
				// Find the documents
				
				MongoCursor<Document> cursor = collection.find().iterator();
				try {
				    while (cursor.hasNext()) {
				        System.out.println(cursor.next().toJson());
				    }
				} finally {
				    cursor.close();
				}
				
			mongo.close();
	}

}
