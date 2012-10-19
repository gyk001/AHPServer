/*
 * @author GuoYukun (<a href="gyk001@gmail.com">Gyk001@gmail.com</a>)
 * @version 2012-5-27
 *
 */

//将状态信息填充到表格里
function fillWorkerConfigToTable(result) {
	"use strict";
	$('#_wc_tbl').children().remove();
	$.each(result.data, function(i, item) {
		if( item){
			var trDom = $('<tr/>').appendTo($('#_wc_tbl'));
			trDom.append('<th>' + item.name + '</th>')
				.append( '<td>' + item.mq + '</td>')
				.append( '<td>' + item.msgType + '</td>')
				.append( '<td>' + item.thread + '</td>')
				.append( '<td>' + item.clazz + '</td>')
				.append( '<td>' + item.flagLockSleep + '</td>')
				.append( '<td>' + item.noMoreDataSleep + '</td>')
				.append( '<td>' + item.dataLockSleep + '</td>');
			var opTd = $('<td/>');
			if(item.name == 'base'){ // 基础配置不允许操作
				trDom.css({'background-color':'#00FF00'});
			}else{
				var btnIncrease = $('<button>增多</button>').click(function(){
					createWorker(item.name);
				}); 
				opTd.append( btnIncrease );
			}
			trDom.append( opTd );
			
		}else{
			$('<tr><td colspan="7">null</td></tr>').appendTo($('#_worker_tbl'));					
		}
	});
	$('#tbl_wc_msg').text('已刷新!'+ getNowTime());
}

// 刷新表格
function reloadTableWorkerConfig() {
	"use strict";
	$('#tbl_wc_msg').text('刷新中...'+getNowTime());
	getWorkerConfig( fillWorkerConfigToTable ,function(msg){
		$('#tbl_wc_msg').text('刷新失败['+msg+']! '+getNowTime());
	});
}
$(function(){
	"use strict";
	
	// 初次进入页面，刷新一次
	reloadTableWorkerConfig();
});