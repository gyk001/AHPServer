/*
 * @author GuoYukun (<a href="gyk001@gmail.com">Gyk001@gmail.com</a>)
 * @version 2012-5-27
 *
 */

//当前时间
function getNowTime(){
    var now = new Date();
	return now.getHours()+':'+now.getMinutes()+':'+now.getSeconds();
}
//获取工作者线程状态
function getWorkerState(successCallback,errorCallback){
	$.ajax({
		url : 'ac/workerState',
		type : 'GET',
		dataType : 'JSON',
		success : function(data){
			if(data && data.success){
				successCallback(data);
			}else{
				errorCallback(data.msg);
			}
		},
		error: errorCallback
	});
}

//获取工作者线程状态
function getWorkerConfig(successCallback,errorCallback){
	$.ajax({
		url : 'ac/workerConfig',
		type : 'GET',
		dataType : 'JSON',
		success : function(data){
			if(data && data.success){
				successCallback(data);
			}else{
				errorCallback(data.msg);
			}
		},
		error: errorCallback
	});
}
//增加一个工作者
function createWorker(configName){
	var answer = confirm("确定增加使用【"+configName+"】的工作者?");
	if(answer){
		$.ajax({
			url:'ac/createWorker',
			data:{
				'configName':configName
			},
			dataType:'json',
			success:function(data){
				alert(1);
			},
			error:function(){
				alert(0);
			}
		});
	}
}
//终止一个工作者
function stopWorker(workerName){
	var answer = confirm("确定停止【"+workerName+"】?");
	if(answer){
		$.ajax({
			url:'ac/stopWorker',
			data:{
				'workerName':workerName
			},
			dataType:'json',
			success:function(data){
				alert(1);
			},
			error:function(){
				alert(0);
			}
		});
	}
}