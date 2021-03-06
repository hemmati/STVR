package cn.com.test;

import java.util.List;

import cn.com.factory.DAOFactory;
import cn.com.model.beans.StepResultProductBean;
import cn.com.service.InstructionService;
import cn.com.sql.dao.SqlConnection;
import cn.com.sql.dao.StepResultProductDAO;
import cn.com.type.asistant.DataMapping;
import cn.com.type.asistant.Page;

public class SqlTest {
	public static void main(String[] args){
		Page page = new Page(1,10);
		SqlConnection myConnection = DAOFactory.getConnection();
		myConnection.connect();
		/*StepResultProductDAO stepResultDAO = DAOFactory.getStepResultProductDAO();
		stepResultDAO.setConnection(myConnection.conn);
		List<StepResultProductBean> results = stepResultDAO.selectByPage(page);*/
		InstructionService in = new InstructionService();
		in.setConnection(myConnection.conn);
		in.saveTestToFileByPage(DataMapping.TOP_INSTRUCTION_DIR,page);
		myConnection.close();
	}
}
