package com.jboard.DAO;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.board.DTO.termsDTO;
import com.board.util.DBHelper;
import com.board.util.SQL;


public class termsDAO extends DBHelper{
	private static termsDAO instance = new termsDAO();
	
	public static termsDAO getInstance() {
		return instance;
	}
	
	private termsDAO() {};
	
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	// CRUD메서드
	public termsDTO selectTerms() {
		termsDTO dto = new termsDTO();
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(SQL.SELECT_TERMS);
			
			if(rs.next()) {
				dto = new termsDTO();
				dto.setTerms(rs.getString(1));
				dto.setPrivacy(rs.getString(2));
			}
			closeAll();
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		return dto;
	}
}