package com.mem.model;

import java.util.List;
import java.util.Set;


import com.mem.model.MemVO;

public class MemService {

	private MemDAO_interface dao;

	public MemService() {
		dao = new MemDAO();
	}

	public void addMem(String memname, String memid, String mempw,
			String mememail, String memcode,String memstatus, byte[] mempic) {

		MemVO memVO = new MemVO();
		memVO.setMemname(memname);
		memVO.setMemid(memid);
		memVO.setMempw(mempw);
		memVO.setMememail(mememail);
		memVO.setMemcode(memcode);
		memVO.setMemstatus(memstatus);
		memVO.setMempic(mempic);
		dao.insert(memVO);
	}

	public MemVO updateMem(Integer memno,String memname, String memid, String mempw,
			String mememail, String memcode,String memstatus, byte[] mempic) {

		MemVO memVO = new MemVO();
		memVO.setMemno(memno);
		memVO.setMemname(memname);
		memVO.setMemid(memid);
		memVO.setMempw(mempw);
		memVO.setMememail(mememail);
		memVO.setMemcode(memcode);
		memVO.setMempic(mempic);
		memVO.setMemstatus(memstatus);
		return dao.update(memVO);

	}

	public List<MemVO> getAll() {
		return dao.getAll();
	}

	public MemVO getOneMem(Integer memno) {
		return dao.findByPrimaryKey(memno);
	}

	public void deleteMem(Integer memno) {
		dao.delete(memno);
	}
}
