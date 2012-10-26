package cn.com.sinosoft.ie.ahp.server.monitor;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.ObjectMapper;

/**
 * @author 郭玉昆(<a href="mailto:gyk001@gmail.com">gyk001@gmail.com</a>)
 * @version 2012-7-6
 * 
 */
public class WorkerStateServlet extends HttpServlet {
	private static final long serialVersionUID = 8351341713686390590L;
	//TODO:监控路径
	private static final String uriPrefix = "/";//+ServerConfig.getMonitorConfig().getContextPath()+"/ac/";
	private static final ObjectMapper jsonMapper = new ObjectMapper();
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		process(req, resp);
	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		process(req, resp);
	}
	//根据请求地址分发到相应处理方法
	private void process(HttpServletRequest req,
			HttpServletResponse resp) throws ServletException, IOException {
		String uri = req.getRequestURI();
		if(uri.equals(uriPrefix+"workerState")){
			getWorkerState(req, resp);
		}else if(uri.equals(uriPrefix+"workerConfig")){
			getWorkerConfig(req,resp);
		}else if(uri.equals(uriPrefix+"stopWorker")){
			stopWorker(req,resp);
		}else if(uri.equals(uriPrefix+"createWorker")){
			createWorker(req,resp);
		}else{
			unknownRequest(req,resp);
		}
	}
	//返回工作者线程状态
	private void getWorkerState(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		Map<String,Object> result = new HashMap<String,Object>();
		result.put("success", true);
		//result.put("data", ServerStatus.getWorkerStatus());
		response.setContentType("application/json");
		response.setStatus(HttpServletResponse.SC_OK);
		jsonMapper.writeValue(response.getOutputStream(),result);
		response.flushBuffer();
	}
	//返回所有激活的工作者线程配置
	private void getWorkerConfig(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		/*
		Map<String,WorkerConfig> configs = ClientStatus.clientConfig.getWorkersConfigMap(); 
		Map<String,Object> simpleMaps = new HashMap<String,Object>();
		for(String configName: configs.keySet()){
			WorkerConfig config = configs.get(configName);
			simpleMaps.put(configName, config.getSimpleMap());
		}
		*/
		Map<String,Object> result = new HashMap<String,Object>();
		result.put("success", true);
	//	result.put("data", simpleMaps);
		response.setContentType("application/json");
		response.setStatus(HttpServletResponse.SC_OK);
		jsonMapper.writeValue(response.getOutputStream(),result);
		response.flushBuffer();
	}	
	//停止一个工作者线程
	private void stopWorker(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
    	String workerName = request.getParameter("workerName");
    //	boolean res = ClientStatus.stopWorker(workerName);
		boolean res = true;
    	Map<String,Object> resMap = new HashMap<String, Object>();
    	resMap.put("success", res);
    	if(res){
    		resMap.put("msg", "停止"+workerName+"已成功调用，但不一定立即生效，请注意刷新状态查看!");
    	}else{
    		resMap.put("msg", "停止"+workerName+"调用失败!");
    	}
        response.setContentType("application/json");
        response.setStatus(HttpServletResponse.SC_OK);
        jsonMapper.writeValue(response.getOutputStream(), resMap);
        response.flushBuffer();
    }
	//增加一个工作者线程
	private void createWorker(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
		Map<String,Object> resMap = new HashMap<String, Object>();
    
		
    	String configName = request.getParameter("configName");
    /*
    	Map<String,WorkerConfig> configs =  ClientStatus.clientConfig.getWorkersConfigMap();
    	try{
	    	if(configs==null){
				resMap.put("msg", "worker configs is null!");
				throw new NullPointerException();
	    	}
	    	WorkerConfig config = configs.get(configName);
	    	if(config==null){
	    		resMap.put("msg", "worker config ["+configName+"] not exist!");
				throw new NullPointerException();
	    	}
	    	String clazz = config.getClazz();
			if(clazz==null || clazz.isEmpty()){
				resMap.put("msg", "worker config ["+configName+"] clazz is null!");
				throw new NullPointerException();
			}
			IWorker worker = null;
			try {
				worker = (IWorker)Class.forName(clazz).newInstance();
			} catch (Exception e) {
				resMap.put("msg", "create ["+clazz+"] with cfg ["+configName+"] error!"+e.getLocalizedMessage());
				throw e;
			}
			try {
				worker.init(config);
				worker.work();
			} catch (WorkerException e) {
				resMap.put("msg", "init ["+clazz+"] with cfg ["+configName+"] error!"+e.getLocalizedMessage());
				throw e;
			}
			ClientStatus.workers.add(worker);
			
			resMap.put("success", true);
			resMap.put("msg", "worker ["+clazz+"] with cfg ["+configName+"] created!");
    	}catch(Exception ingore){
    		resMap.put("success", false);
    	}
    	*/
        response.setContentType("application/json");
        response.setStatus(HttpServletResponse.SC_OK);
        jsonMapper.writeValue(response.getOutputStream(), resMap);
        response.flushBuffer();
    }	
	//未知请求,返回错误信息
	private void unknownRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		Map<String,Object> result = new HashMap<String,Object>();
		result.put("success", false);
		result.put("msg", "未知请求");
		
		resp.setContentType("application/json");
		resp.setStatus(HttpServletResponse.SC_OK);
		jsonMapper.writeValue(resp.getOutputStream(),result);
		resp.flushBuffer();
	}	
}