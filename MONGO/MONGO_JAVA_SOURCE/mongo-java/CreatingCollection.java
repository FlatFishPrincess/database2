import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase; 
import com.mongodb.MongoClient;
import com.mongodb.MongoClientURI;

import java.util.logging.Level;
import java.util.logging.Logger;

import org.bson.Document;


public class CreatingCollection { 

	public static void main( String args[] ) {  
		
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
		
		// Insert one document to the collection
	    Document document = new Document("item", "canvas") 
	    		 			 .append("qty", 100)
	    		 			 .append("size", new Document("h", 28).append("w", 35.5).append("uom", "cm"))  
	    		 			 .append("status", "A"); 
	      
		collection.insertOne(document);
	    
		// Find the documents
		
		MongoCursor<Document> cursor = collection.find().iterator();
		try {
		    while (cursor.hasNext()) {
		        System.out.println(cursor.next().toJson());
		    }
		} finally {
		    cursor.close();
		}
		
		// Close
		mongo.close();
	} 
} 