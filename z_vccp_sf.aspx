﻿<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
		
			var intervalupdate;
            $(document).ready(function() {
                q_getId();
                q_gf('', 'z_vccp_sf');
				
				//106/12/06 預設BOSS中一刀 印表機
				intervalupdate=setInterval("selectprint()",1000);
				
            });
            
            function selectprint() {
				if($('#cmbPcPrinter').val()!=null){
					$('#cmbPcPrinter option').each(function(index){
						if($(this).val().indexOf('BOSS') > 0 && $(this).val().indexOf('中一刀') > 0){
							$('#cmbPcPrinter option:eq('+index+')').prop('selected', true);
						}
					});
					
					//清除
					intervalupdate = setInterval(";");
					for (var i = 0 ; i < intervalupdate ; i++) {
					    clearInterval(i); 
					}
				}
            }
            
            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_vccp_sf',
                    options : [{
                        type : '0', //[1]
                        name : 'accy',
                        value : r_accy
                    }, {
                        type : '1', //[2][3]
                        name : 'xnoa'
                    }, {
                        type : '8',
                        name : 'xshowtaxname',
                        value : "1@顯示稅金".split(',')
                    }, {
                        type : '6',
                        name : 'xaddr2',
                    }]
                });
                q_popAssign();
                q_getFormat();
                q_langShow();
                
                if(r_len==4){                	
                	$.datepicker.r_len=r_len;
                	//格式(有設定格式要在重新設定模板，否則格式無效)
                	//$.datepicker.r_dateformat=q_getPara('sys.dateformat');
                	//民國模板(預設)
                	//$.datepicker.setDefaults($.datepicker.regional[""]);
                	//英文模板
					//$.datepicker.setDefaults($.datepicker.regional["ENG"]);
                }

                if (q_getHref()[0] == 'noa') {
                    $('#txtXnoa1').val(q_getHref()[1]);
                    $('#txtXnoa2').val(q_getHref()[1]);
                }

                if (q_getHref()[2] == 'addr2') {
                    $('#txtXaddr2').val(q_getHref()[3]);
                }

                $('#Xshowtaxname').css('width', '300px');
                $('#Xshowtaxname').css('height', '30px');
                $('#chkXshowtaxname').css('width', '200px');
                $('#chkXshowtaxname span').css('width', '100px');
                $('#chkXshowtaxname').css('margin-top', '5px');
            }
            
            function q_boxClose(s2) {
            }

            function q_gtPost(s2) {
            }
		</script>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div id="q_menu"></div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="q_report"></div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>

