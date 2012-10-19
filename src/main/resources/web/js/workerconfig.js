/*
 * @author GuoYukun (<a href="gyk001@gmail.com">Gyk001@gmail.com</a>)
 * @version 2012-5-27
 *
 */

//将状态信息填充到树
function fillWorkerConfigToTree (result) {
				$('#_wc_tree').children().remove();
				var workerList = [];
				$.each(result.data, function(di, worker) {
					if( worker){
						var nodeName = worker.name || "没有名字";
						if(worker.state){
							nodeName = nodeName+' '+worker.state;
						}
						var workerNode = {
								"data" : nodeName, 
								"metadata" : { name : worker.name },
								"children" : [ ]
						};
						$.each(worker,function(propName,propVal){
							workerNode.children.push(propName+" : "+propVal);
						});
						
						workerList.push(workerNode );
					}else{
						workerList.push({
							"data" : "未知"
						} );				
					}
				});
				
				var json_data ={ 
						"json_data" : {
							"data" : workerList
						},
						"themes" : {
							"theme" : "classic"
						},
						"plugins" : [ "themes", "json_data", "ui","search", "adv_search" ]
				};
				
				$("#_wc_tree").jstree(json_data);
				/*
				.bind("select_node.jstree", function (e, data) {
					alert(jQuery.data(data.rslt.obj[0], "id")); 
				});
				*/
				$('#tree_wc_msg').text('已刷新!'+getNowTime());
}

//刷新工作者配置树
function reloadTreeWorkerConfig(){
	"use strict";
	$('#tree_wc_msg').text('刷新中...'+getNowTime());
	getWorkerConfig( fillWorkerConfigToTree, function(msg){
		$('#tree_wc_msg').text('刷新失败['+msg+']!'+getNowTime());
	});
}
$(function() {
	"use strict";
	//刷新
	$("#_btn_tree_reload").click(function () {
		reloadTreeWorkerState();
	});
	//查找
	$("#_btn_tree_search").click(function () {
		$("#_worker_tree").jstree("search", $('#_txt_tree_search').val());
	});
	//清除查找结果
	$("#_btn_tree_search_clear").click(function () {
		$("#_worker_tree").jstree("clear_search");
	});
	// 初次进入页面，刷新一次
	reloadTreeWorkerConfig();
})