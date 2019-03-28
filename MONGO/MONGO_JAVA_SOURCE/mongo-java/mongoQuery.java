 import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import static com.mongodb.client.model.Projections.*;
import com.mongodb.MongoClient;
import com.mongodb.MongoClientURI;

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.bson.Document;


public class mongoQuery {

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
		
		MongoCursor<Document> cursor = collection.find(Filters.gte("qty", 50)).iterator();
		
		
//		MongoCursor<Document> cursor = collection.find(Filters.gte("qty", 50)).projection(fields(include("item", "qty"), excludeId())).iterator();
		
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
