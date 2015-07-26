package ucd.scott.fyp.stucture;

public class LowHighTagCounter {
	private int lowCount;
	private int highCount;
	
	public LowHighTagCounter(){
		this.setLowCount(0);
		this.setHighCount(0);
	}
	
	public void incrLow(){
		setLowCount(getLowCount() + 1);
	}
	
	public void incrHigh(){
		setHighCount(getHighCount() + 1);
	}

	public int getHighCount() {
		return highCount;
	}

	public void setHighCount(int highCount) {
		this.highCount = highCount;
	}

	public int getLowCount() {
		return lowCount;
	}

	public void setLowCount(int lowCount) {
		this.lowCount = lowCount;
	}
	
	public String toString() {
		return "L: "+lowCount+" H: "+highCount;
	}
}
