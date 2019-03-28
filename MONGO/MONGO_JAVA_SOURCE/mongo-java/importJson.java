import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;
import com.mongodb.MongoClient;
import com.mongodb.MongoClientURI;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.bson.Document;


public class importJson {

	public static void main(String[] args) {
		// Turn off log messages
		Logger mongoLogger = Logger.getLogger("org.mongodb.driver");
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
		
		// read file
		
		String content = null;
		
		try {
			content = new String(Files.readAllBytes(Paths.get("src/inventory.txt")));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	//	System.out.println(content);
		String[] lines = content.split(System.getProperty("line.separator"));
		List<Document> documents = new ArrayList<Document>();
		
		for (String line: lines) {
	       	    documents.add(Document.parse(line));
		}	    
	    
	    collection.insertMany(documents);
	    
		MongoCursor<Document> cursor = collection.find().iterator();
		try {
		    while (cursor.hasNext()) {
		        System.out.println(cursor.next().toJson());
		    }
		} finally {
		    cursor.close();
		}

	}

}
