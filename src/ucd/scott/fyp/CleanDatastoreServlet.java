package ucd.scott.fyp;

import java.io.IOException;
import java.util.Calendar;
import java.util.Date;
import java.util.logging.Logger;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.*;
import com.google.appengine.api.datastore.Query.Filter;
import com.google.appengine.api.datastore.Query.FilterPredicate;
import com.google.appengine.api.datastore.Query.FilterOperator;

@SuppressWarnings("serial")
public class CleanDatastoreServlet extends HttpServlet{
	private static final Logger log = Logger.getLogger(CronServlet.class.getName());

	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		log.info("Cleaning Datastore");
		while(!delteOldEntries());
	}

	private boolean delteOldEntries() {
		Date dateInstance = new Date();
		Calendar cal = Calendar.getInstance();
		cal.setTime(dateInstance);
		cal.add(Calendar.DATE, -5);
		Date date = cal.getTime();

		Filter olderThan =  new FilterPredicate("date", FilterOperator.LESS_THAN, date);


		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		Query query = new Query("Article").setFilter(olderThan);
		PreparedQuery result = datastore.prepare(query);

		int i = 0;
		for(Entity entity : result.asIterable()){
			if(1000 == i++) return false;
			log.info("Deleting Entity...");
			datastore.delete(entity.getKey());
		}
		return true;
	}
}
