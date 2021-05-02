package model;

public class Asiakas {
	private int asiakas_id;
	private String etunimi, sukunimi, puhelin, email;
	public Asiakas() {
		super();		
	}
	public Asiakas(int asiakas_id, String etunimi, String sukunimi, String puhelin, String email) {
		super();
		this.asiakas_id = asiakas_id;
		this.etunimi = etunimi;
		this.sukunimi = sukunimi;
		this.puhelin = puhelin;
		this.email = email;
	}
	public int getId() {
		return asiakas_id;
	}
	public void setId(int asiakas_id) {
		this.asiakas_id = asiakas_id;
	}
	public String getEtunimi() {
		return etunimi;
	}
	public void setEtunimi(String etunimi) {
		this.etunimi = etunimi;
	}
	public String getSukunimi() {
		return sukunimi;
	}
	public void setSukunimi(String sukunimi) {
		this.sukunimi = sukunimi;
	}
	public String getPuhelin() {
		return puhelin;
	}
	public void setPuhelin(String puhelin) {
		this.puhelin = puhelin;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	@Override
	public String toString() {
		return "Asiakas [etunimi=" + etunimi + ", sukunimi=" + sukunimi + ", puhelin=" + puhelin + ", Sposti=" + email + "]";
	}
	
	
}
