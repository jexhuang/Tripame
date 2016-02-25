package com.rec.model;

import java.sql.Date;
import java.util.List;
import java.util.Set;

import com.emp.model.EmpVO;
import com.mem.model.MemVO;

public class RecService {

	private RecDAO_interface dao;

	public RecService() {
		dao = new RecDAO();
	}

	public List<RecVO> getAll() {
		return dao.getAll();
	}

	public RecVO getOneRec(Integer recno) {
		return dao.findByPrimaryKey(recno);
	}


	public void deleteRec(Integer recno) {
		dao.delete(recno);
	}
	
	public RecVO addRec(Integer memno, String recclass, String recsort,
			String reccon, String rectown, String recname, String recphone,
			String recaddress, String reccontent, byte[] recpic, String recsite,
			Double reclat, Double reclong, String recstatus,String recmessage){
		
		RecVO recVO = new RecVO();
		recVO.setMemno(memno);
		recVO.setRecclass(recclass);
		recVO.setRecsort(recsort);
		recVO.setReccon(reccon);
		recVO.setRectown(rectown);
		recVO.setRecname(recname);
		recVO.setRecphone(recphone);
		recVO.setRecaddress(recaddress);
		recVO.setReccontent(reccontent);
		recVO.setRecpic(recpic);
		recVO.setRecsite(recsite);
		recVO.setReclat(reclat);
		recVO.setReclong(reclong);
		recVO.setRecstatus(recstatus);
		recVO.setRecmessage(recmessage);
		dao.insert(recVO);
		return recVO;
	}
	
	public RecVO updateRec(Integer recno,Integer memno,String recclass, String recsort,
			String reccon, String rectown, String recname, String recphone,
			String recaddress, String reccontent, byte[] recpic, String recsite,
			Double reclat, Double reclong, String recstatus,String recmessage){
		
		RecVO recVO = new RecVO();
		recVO.setRecno(recno);
		recVO.setMemno(memno);
		recVO.setRecclass(recclass);
		recVO.setRecsort(recsort);
		recVO.setReccon(reccon);
		recVO.setRectown(rectown);
		recVO.setRecname(recname);
		recVO.setRecphone(recphone);
		recVO.setRecaddress(recaddress);
		recVO.setReccontent(reccontent);
		recVO.setRecpic(recpic);
		recVO.setRecsite(recsite);
		recVO.setReclat(reclat);
		recVO.setReclong(reclong);
		recVO.setRecstatus(recstatus);
		recVO.setRecmessage(recmessage);
		dao.update(recVO);
		return recVO;
		
	}
}
