package com.mem.model;

public class MemVO implements java.io.Serializable {
	private Integer memno;
	private String memname;
	private String memid;
	private String mempw;
	private String mememail;
	private String memcode;
	private String memstatus;
	private byte[] mempic;


	
	public String getMemstatus() {
		return memstatus;
	}

	public void setMemstatus(String memstatus) {
		this.memstatus = memstatus;
	}

	public Integer getMemno() {
		return memno;
	}

	public void setMemno(Integer memno) {
		this.memno = memno;
	}

	public String getMemname() {
		return memname;
	}

	public void setMemname(String memname) {
		this.memname = memname;
	}

	public String getMemid() {
		return memid;
	}

	public void setMemid(String memid) {
		this.memid = memid;
	}

	public String getMempw() {
		return mempw;
	}

	public void setMempw(String mempw) {
		this.mempw = mempw;
	}

	public String getMememail() {
		return mememail;
	}

	public void setMememail(String mememail) {
		this.mememail = mememail;
	}

	public String getMemcode() {
		return memcode;
	}

	public void setMemcode(String memcode) {
		this.memcode = memcode;
	}

	public byte[] getMempic() {
		return mempic;
	}

	public void setMempic(byte[] mempic) {
		this.mempic = mempic;
	}

}
