package com.ad.model;

import java.sql.Date;
import java.util.List;
import java.util.Set;
import com.mem.model.MemVO;

public class AdService {

	private AdDAO_interface dao;

	public AdService() {
		dao = new AdDAO();
	}

	public List<AdVO> getAll() {
		return dao.getAll();
	}

	public AdVO getOneAd(Integer adno) {
		return dao.findByPrimaryKey(adno);
	}
	public Date getEndDate(){
		return dao.getEndDate();
	}

	public void deleteAd(Integer adno) {
		dao.delete(adno);
	}
	
	public AdVO addAd(Integer memno, String adclass, String adsort,
			String adcon, String adtown, String adname, String adphone,
			String adaddress, String adcontent, byte[] adpic, String adsite,
			Double adlat, Double adlong, String adstatus, Date adbegin,
			Date adend,String admessage){
		
		AdVO adVO = new AdVO();
		adVO.setMemno(memno);
		adVO.setAdclass(adclass);
		adVO.setAdsort(adsort);
		adVO.setAdcon(adcon);
		adVO.setAdtown(adtown);
		adVO.setAdname(adname);
		adVO.setAdphone(adphone);
		adVO.setAdaddress(adaddress);
		adVO.setAdcontent(adcontent);
		adVO.setAdpic(adpic);
		adVO.setAdsite(adsite);
		adVO.setAdlat(adlat);
		adVO.setAdlong(adlong);
		adVO.setAdstatus(adstatus);
		adVO.setAdbegin(adbegin);
		adVO.setAdend(adend);	
		adVO.setAdmessage(admessage);
		dao.insert(adVO);
		return adVO;
	}
	
	public AdVO updateAd(Integer adno,Integer memno,String adclass, String adsort,
			String adcon, String adtown, String adname, String adphone,
			String adaddress, String adcontent, byte[] adpic, String adsite,
			Double adlat, Double adlong, String adstatus, Date adbegin,
			Date adend,String admessage){
		
		AdVO adVO = new AdVO();
		adVO.setAdno(adno);
		adVO.setMemno(memno);
		adVO.setAdclass(adclass);
		adVO.setAdsort(adsort);
		adVO.setAdcon(adcon);
		adVO.setAdtown(adtown);
		adVO.setAdname(adname);
		adVO.setAdphone(adphone);
		adVO.setAdaddress(adaddress);
		adVO.setAdcontent(adcontent);
		adVO.setAdpic(adpic);
		adVO.setAdsite(adsite);
		adVO.setAdlat(adlat);
		adVO.setAdlong(adlong);
		adVO.setAdstatus(adstatus);
		adVO.setAdbegin(adbegin);
		adVO.setAdend(adend);	
		adVO.setAdmessage(admessage);
		dao.update(adVO);
		return adVO;
		
	}
}
