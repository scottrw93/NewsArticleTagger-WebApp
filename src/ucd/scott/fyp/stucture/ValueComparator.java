package ucd.scott.fyp.stucture;

import java.util.Comparator;
import java.util.HashMap;
import java.util.Map;


public class ValueComparator implements Comparator<String> {

	Map<String, LowHighTagCounter> base;

	public ValueComparator(HashMap<String, LowHighTagCounter> entities) {
		this.base = entities;
	}

	public int compare(String a, String b) {
		return (float) base.get(a).getHighCount() + (float)base.get(a).getLowCount()/3.
				>= (float) base.get(b).getHighCount()+ (float)base.get(b).getLowCount()/3. ? -1 : 1;
	}
}