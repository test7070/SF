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
			var t_first=true;
			$(document).ready(function() {
				q_getId();
				q_gt('spec', '1=1 ', 0, 0, 0, "spec");
				
				$('#q_report').click(function(e) {
					if(window.parent.q_name=="z_contstp_vu"){
						for(var i=0;i<$('#q_report').data().info.reportData.length;i++){
							if($('#q_report').data().info.reportData[i].report!='z_ina_sf06')
								$('#q_report div div').eq(i).hide();
						}
						$('#q_report div div .radio').parent().each(function(index) {
							if(!$(this).is(':hidden') && t_first){
								$(this).children().removeClass('nonselect').addClass('select');
								t_first=false;
							}
							if($(this).is(':hidden') && t_first){
								$(this).children().removeClass('select').addClass('nonselect');
							}
						});
					}
				});
			});
			var xucolorItem ='';
            var xspecItem ='';
            var t_qno='';
            var xlengthbItem ='';
            var xclassItem ='';
            var xuccItem ='';
			
			function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_ina_sf',
					options : [{
						type : '0', //[1]
						name : 'accy',
						value : r_accy
					}, {
                        type : '0', //[2] //判斷顯示小數點與其他判斷
                        name : 'lenm',
                        value : r_lenm
                    }, {
                        type : '0', //[3] //判斷顯示小數點與其他判斷
                        name : 'acomp',
                        value : q_getPara('sys.comp')
                    }, {
						type : '1', //[4][5]
						name : 'date'
					}, {
						type : '2', //[6][7]
						name : 'tgg',
						dbf : 'tgg',
						index : 'noa,comp',
						src : 'tgg_b.aspx'
					}, {
                        type : '5',
                        name : 'xproduct', //[8]
                        value :xuccItem.split(',')
                    }, {
                        type : '5',
                        name : 'xspec' ,//[9]
                        value :xspecItem.split(',')
                    }, {
                        type : '5',
                        name : 'xsize', //[10]
                        value:(' @全部,#2,#3,#4,#5,#6,#7,#8,#9,#10,#11,#12,#13,#14,#15,#16,#16').split(',')
                    }, {
                        type : '5',
                        name : 'xclass',//[11]
                        value : xclassItem.split(',')
                    },{
                    	type : '8', //[12]
						name : 'xshowenda',
						value : "1@依號數排序".split(',')
                    },{
                        type : '1',
                        name : 'xlengthb', //[13][14]
                    },{
                        type : '6', //[15] //判斷顯示小數點與其他判斷
                        name : 'qno',
                    }, {
						type : '2', //[16][17]
						name : 'xstore',
						dbf : 'store',
						index : 'noa,store',
						src : 'store_b.aspx'
					}, {
                        type : '0',//[18]
                        name : 'xworker',
                        value : r_name
                    }, {
                        type : '1',//[19][20]
                        name : 'xdate'
                    }, {
                    	type : '5', //[21]
						name : 'xtypea',
						value : '#non@全部,委外代工@委外代工,來料加工@來料加工,互換@互換'.split(',')
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
               	
				$('#txtDate1').datepicker();
				$('#txtDate2').datepicker();
				$('#txtXdate1').datepicker();
                $('#txtXdate2').datepicker();
				
				$('#lblQno').css('font-size','12px');
				
                $('#txtDate1').mask(r_picd);
                $('#txtDate2').mask(r_picd);
                $('#txtXdate1').mask(r_picd);
                $('#txtXdate2').mask(r_picd);
				
				$('#txtDate1').val(q_date().substr(0,r_lenm)+'/01');
                $('#txtDate2').val(q_cdn(q_cdn(q_date().substr(0,r_lenm)+'/01',35).substr(0,r_lenm)+'/01',-1));
                $('#txtXdate1').val(q_date().substr(0,r_lenm)+'/01');
                $('#txtXdate2').val(q_date());
                
                $('#txtXlengthb1').addClass('num').val(0).change(function() {
                    $(this).val(dec($(this).val()));
                    if ($(this).val() == 'NaN')
                    	$(this).val(0);
                });
                $('#txtXlengthb2').addClass('num').val(99).change(function() {
                    $(this).val(dec($(this).val()));
                    if ($(this).val() == 'NaN')
                    	$(this).val(99);
                });
               
                var tmp = document.getElementById("txtQno");
                var selectbox = document.createElement("select");
                selectbox.id="combQno";
                selectbox.style.cssText ="width:20px;font-size: medium;";
                tmp.parentNode.appendChild(selectbox,tmp);
                
				 var t_where="where=^^datea between '"+$('#txtDate1').val()+"' and '"+$('#txtDate2').val()+
							"' and tggno between '"+$('#txtTgg1a').val()+"' and case when isnull('"+$('#txtTgg2a').val()+"','')='' then char(255) else '"+$('#txtTgg2a').val()+"' end order by datea desc,noa desc  --^^ stop=999 "
				q_gt('ordh',t_where, 0, 0, 0, "ordh"); 
				 
                 $('.c3.text').change(function(){
                 	var t_where="where=^^datea between '"+$('#txtDate1').val()+"' and '"+$('#txtDate2').val()+
								"' and tggno between '"+$('#txtTgg1a').val()+"' and case when isnull('"+$('#txtTgg2a').val()+"','')='' then char(255) else '"+$('#txtTgg2a').val()+"' end order by datea desc,noa desc  --^^ stop=999 "
					q_gt('ordh',t_where, 0, 0, 0, "ordh");               
                 });
                 $('c2.text').change(function(){
                 	var t_where="where=^^datea between '"+$('#txtDate1').val()+"' and '"+$('#txtDate2').val()+
                 				"' and tggno between '"+$('#txtTgg1a').val()+"' and case when isnull('"+$('#txtTgg2a').val()+"','')='' then char(255) else '"+$('#txtTgg2a').val()+"' end order by datea desc,noa desc  --^^ stop=999 "
                 });
                 $('#combQno').click(function() {       	
                 	var t_where="where=^^datea between '"+$('#txtDate1').val()+"' and '"+$('#txtDate2').val()+
								"' and tggno between '"+$('#txtTgg1a').val()+"' and case when isnull('"+$('#txtTgg2a').val()+"','')='' then char(255) else '"+$('#txtTgg2a').val()+"' end order by datea desc,noa desc  --^^ stop=999 "
					q_gt('ordh',t_where, 0, 0, 0, "ordh");
                 });
                $('#combQno').change(function() {
					$('#txtQno').val($('#combQno').find("option:selected").text());
				});
				
				$('#Xshowenda').css('width', '300px').css('height', '30px');
				$('#Xshowenda .label').css('width','0px');
				$('#chkXshowenda').css('width', '220px').css('margin-top', '5px');
				$('#chkXshowenda span').css('width','180px')
			}

			function q_boxClose(s2) {
			}

			function q_gtPost(s2) {
			}
			
			function q_gtPost(t_name) {
                switch (t_name) {
                	case 'ordh':
                		var as = _q_appendData("ordh", "", true);
						for ( i = 0; i < as.length; i++) {
							t_qno+=","+as[i].noa;
						}
						$('#combQno').empty();
						if(t_qno.length != 0){							
								
								 q_cmbParse("combQno", t_qno); 
							}
							t_qno='';
                		break;
                	case 'spec':
                		var as = _q_appendData("spec", "", true);
                		xspecItem = " @全部";
						for ( i = 0; i < as.length; i++) {
							xspecItem+=","+as[i].noa;
						}
						q_gt('color', '1=1 ', 0, 0, 0, "color");
                		break;
                	case 'color':
                		var as = _q_appendData("color", "", true);
                		xucolorItem = " @全部";
						for ( i = 0; i < as.length; i++) {
							xucolorItem+=","+as[i].color;
						}
						q_gt('class', '1=1 ', 0, 0, 0, "class");
                		break;
                	case 'class':
                		var as = _q_appendData("class", "", true);
                		xclassItem = " @全部";
						for ( i = 0; i < as.length; i++) {
							xclassItem+=","+as[i].noa;
						}
						q_gt('ucc', '1=1 ', 0, 0, 0, "ucc"); 
						break;
                	case 'ucc':
						xuccItem = " @全部";
                		var as = _q_appendData("ucc", "", true);
						for ( i = 0; i < as.length; i++) {
							xuccItem+=","+as[i].product;
						}
						
						q_gf('', 'z_ina_sf');
						break;  
                	default:
                        break;
                }
            }
		</script>
		<style type="text/css">
            .num {
                text-align: right;
                padding-right: 2px;
            }
            #q_report select {
            	font-size: medium;
    			margin-top: 2px;
            }
            select {
            	font-size: medium;
            }
		</style> 
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div id="q_menu"> </div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="q_report"> </div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>
