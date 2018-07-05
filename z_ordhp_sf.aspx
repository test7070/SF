<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title> </title>
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
            if (location.href.indexOf('?') < 0) {
                location.href = location.href + "?;;;;" + ((new Date()).getUTCFullYear() - 1911);
            }
            $(document).ready(function() {
                q_getId();
                q_gf('', 'z_ordhp_sf');
            });

            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_ordhp_sf',
                    options : [{
                        type : '1',
                        name : 'xdate'
                    }, {
                        type : '5',
                        name : 'xtypea',
                        value :'#non@全部,委外代工,來料加工,互換'.split(',')
                    }, {
                        type : '2',
                        name : 'xtggno',
                        dbf : 'view_cust_tgg',
                        index : 'noa,comp',
                        src : 'custtgg_b.aspx'
                    }, {
                        type : '6',
                        name : 'xnoa'
                    },{
                        type : '1',
                        name : 'ydate'
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
    			
    			$('#txtXdate1').mask(r_picd);
                //$('#txtXdate1').val(q_date().substr(0, r_lenm)+'/01');
                $('#txtXdate1').val('2017/07/01');//20180705 固定
                $('#txtXdate2').mask(r_picd);
                $('#txtXdate2').val(q_cdn(q_cdn(q_date().substr(0,r_lenm)+'/01',35).substr(0,r_lenm)+'/01',-1));
                $('#txtYdate1').mask(r_picd);
                $('#txtYdate2').mask(r_picd);
                
                var t_report=q_getHref()[1];
				var t_index=-1;
				for(var i=0;i<$('#q_report').data().info.reportData.length;i++){
					if($('#q_report').data('info').reportData[i].report=='z_ordhp_sf03'){
						t_index=i;
						break;	
					}
				}
				if(t_report!=undefined && t_report=='z_ordhp_sf03'){
					var t_noa=q_getHref()[3];
					$('#txtXnoa').val(t_noa);
					for(var i=0;i<$('#q_report').data().info.reportData.length;i++){
						if($('#q_report').data('info').reportData[i].report!='z_ordhp_sf03'){
							$('#q_report div div').eq(i).hide();
						}
					}
					$('#q_report').find('span.radio').eq(t_index).parent().click();	
					$('#txtXnoa').attr('disabled','disabled');
					$("#btnOk").click();
				}else{
					$('#q_report div div').eq(t_index).hide();
				}
            }

            function q_boxClose(s2) {
            }
			
			var partItem = '';
            function q_gtPost(t_name) {
                switch (t_name) {
                    
                }
            }

		</script>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div id="q_menu"> </div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;">
			<div id="container">
				<div id="q_report"> </div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>