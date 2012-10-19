/*
 * @author GuoYukun (<a href="gyk001@gmail.com">Gyk001@gmail.com</a>)
 * @version 2012-5-27
 *
 */

// 超时句柄
var _tblReloadHandle = undefined;

//将状态信息填充到表格里
function fillStateTable(result) {
	$('#_worker_tbl').children().remove();
	$.each(result.data, function(i, item) {
		if( item){
			var trDom = $('<tr/>').appendTo($('#_worker_tbl'));
			trDom.append('<td>' + item.name + '</td>')
				.append( '<td>' + item.state + '</td>')
				.append( '<td>' + item.workerConfig + '</td>')
				.append( '<td>' + item.total + '</td>')
				.append( '<td>' + item.success + '</td>')
				.append( '<td>' + item.error + '</td>')
				.append( '<td>' + item.sending + '</td>');
			var btnStop = $('<button>停止</button>').click(function(){
				stopWorker(item.name);
			})	
			trDom.append( $('<td/>').append(btnStop) );
			
		}else{
			$('<tr><td colspan="7">null</td></tr>').appendTo($('#_worker_tbl'));					
		}
	});
	$('#tbl_state_msg').text('已刷新!'+ getNowTime());
}

// 刷新状态表格
function reloadTableWorkerState() {
	"use strict";
	$('#tbl_state_msg').text('刷新中...'+getNowTime());
	getWorkerState( fillStateTable ,function(msg){
		$('#tbl_state_msg').text('刷新失败['+msg+']! '+getNowTime());
	});
}
$(function(){
	"use strict";
	// 绑定自动刷新功能
	$('#tbl_autoreload').change(function() {
		if ($('#tbl_autoreload').attr('checked') == 'checked') {
			_tblReloadHandle = setInterval("reloadTableWorkerState()", 3000);
		} else {
			clearInterval(_tblReloadHandle);
			_tblReloadHandle = undefined;
		}
	});
	// 初次进入页面，刷新一次
	reloadTableWorkerState();
});