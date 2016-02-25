package com.travel.model;

import java.util.List;

public interface TravelDAO_interface {
	/** 新增 */
	public void insert(TravelVO travelVO);
	/** 修改 */
	public void update(TravelVO travelVO);
	/** 刪除 */
	public void delete(Integer travelno);
	/** 依照主鍵搜尋 */
    public TravelVO findByPrimaryKey(Integer travelno);
	/** 取得全部*/
	public List<TravelVO> getAll();
}
