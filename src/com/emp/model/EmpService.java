package com.emp.model;

import java.util.List;

public class EmpService {

	private EmpDAO_interface dao;

	public EmpService() {
		dao = new EmpDAO();
	}

	public EmpVO addEmp(String empname, String empid, String emppw,
			String empemail, String empad, String emptravel,
			String empactivity, String empemp, String empforums, String emprec,
			String empmem, String empspot, String emptraffic) {

		EmpVO empVO = new EmpVO();

		empVO.setEmpname(empname);
		empVO.setEmpid(empid);
		empVO.setEmppw(emppw);
		empVO.setEmpemail(empemail);
		empVO.setEmpad(empad);
		empVO.setEmptravel(emptravel);
		empVO.setEmpactivity(empactivity);
		empVO.setEmpemp(empemp);
		empVO.setEmpforums(empforums);
		empVO.setEmprec(emprec);
		empVO.setEmpmem(empmem);
		empVO.setEmpspot(empspot);
		empVO.setEmptraffic(emptraffic);
		
		dao.insert(empVO);

		return empVO;
	}

	public EmpVO updateEmp(Integer empno,String empname, String empid, String emppw,
			String empemail, String empad, String emptravel,
			String empactivity, String empemp, String empforums, String emprec,
			String empmem, String empspot, String emptraffic) {

		EmpVO empVO = new EmpVO();
		empVO.setEmpno(empno);
		empVO.setEmpname(empname);
		empVO.setEmpid(empid);
		empVO.setEmppw(emppw);
		empVO.setEmpemail(empemail);
		empVO.setEmpad(empad);
		empVO.setEmptravel(emptravel);
		empVO.setEmpactivity(empactivity);
		empVO.setEmpemp(empemp);
		empVO.setEmpforums(empforums);
		empVO.setEmprec(emprec);
		empVO.setEmpmem(empmem);
		empVO.setEmpspot(empspot);
		empVO.setEmptraffic(emptraffic);
		dao.update(empVO);

		return empVO;
	}

	public void deleteEmp(Integer empno) {
		dao.delete(empno);
	}

	public EmpVO getOneEmp(Integer empno) {
		return dao.findByPrimaryKey(empno);
	}

	public List<EmpVO> getAll() {
		return dao.getAll();
	}
}
