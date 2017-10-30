<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src='../script/qj2.js' type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src='../script/qj_mess.js' type="text/javascript"> </script>
		<script src="../script/qbox.js" type="text/javascript"> </script>
		<script src='../script/mask.js' type="text/javascript"> </script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"> </script>
		<script src="css/jquery/ui/jquery.ui.widget.js"> </script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"> </script>
		<script type="text/javascript">
           if (location.href.indexOf('?') < 0) {
				location.href = location.href + "?;;;;" + ((new Date()).getUTCFullYear() - 1911);
			}
            $(document).ready(function() {
            	q_getId();
                q_gf('', 'z_cubp_sf');
            });
        	
            function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_cubp_sf',
					options : [{
                        type : '0', //[1]
                        name : 'projectname',
                        value : q_getPara('sys.project').toUpperCase()
                    }, {
                        type : '0', //[2]
                        name : 'mountprecision',
                        value : q_getPara('rc2.mountPrecision')
                    }, {
                        type : '0', //[3]
                        name : 'weightprecision',
                        value : q_getPara('rc2.weightPrecision')
                    }, {
                        type : '0', //[4]
                        name : 'priceprecision',
                        value : q_getPara('rc2.pricePrecision')
                    },{
                        type : '0', //[5]
                        name : 'xrank',
                        value : r_rank
                    }, {//[6][7]
						type : '1',
						name : 'xdate'
					},{ //[8][9]
						type : '1',
						name : 'xmon'
					},{//[10][11]
                        type : '2',
                        name : 'xcust',
                        dbf : 'cust',
                        index : 'noa,comp',
                        src : 'cust_b.aspx'
                    }, {/*[12][13]*/
                        type : '2',
                        name : 'xmechno',
                        dbf  : 'mech',
                        index: 'noa,mech',
                        src  : 'mech_b.aspx'
                    }, {
                        type : '6',
                        name : 'xproduct' //[14]
                    }, {
                        type : '6',
                        name : 'xspec' //[15]
                    }, {
                        type : '5',
                        name : 'xsize', //[16]
                        value:(',#2,#3,#4,#5,#6,#7,#8,#9,#10,#11,#12,#13,#14,#15,#16').split(',')
                    }, {
                        type : '5',
                        name : 'xitype', //[17]
                        value:('#non@全部,1@裁剪,2@成型').split(',')
                    },{
						type : '5',
						name : 'xenda',//[18]
						value :('#non@全部,0@未結案,1@已結案').split(',')
					},{
						type : '5',
						name : 'xorder',//[19]
						value :('noa@案號,comp@客戶,bdate@預交日').split(',')
					}, {//[20]
						type : '6',
						name : 'xyear'
					}]
				});
                q_popAssign();
				q_getFormat();
				q_langShow();
                 
                 if(r_len==4){                	
                	$.datepicker.r_len=4;
					//$.datepicker.setDefaults($.datepicker.regional["ENG"]);
                }
               
				$('#txtXdate1').datepicker();
				$('#txtXdate2').datepicker();
                 
                $('#txtXdate1').mask(r_picd);
	            $('#txtXdate2').mask(r_picd);
	            $('#txtXmon1').mask(r_picm);
	            $('#txtXmon2').mask(r_picm);
	            $('#txtXtime1').mask('99:99');
	            $('#txtXtime2').mask('99:99');
           		
           		$('#txtXyear').mask(r_pic);
           		$('#txtXyear').val(q_date().substr(0,r_len));
                
               //1201 日期預設 當天
                $('#txtXdate1').val(q_date());
                $('#txtXdate2').val(q_date());
                
                //1204 預設兩個月 與類別預設顯示 未結案
                $('#txtXmon1').val(q_cdn(q_date().substring(0,r_lenm)+'/01',-25).substring(0,r_lenm));
                $('#txtXmon2').val(q_date().substring(0,r_lenm));
                $('#Xtype select').val('0');
 				
 				
 				q_gt('spec', '1=1 ', 0, 0, 0, "spec");
 				
 				var tmp = document.getElementById("txtXproduct");
                var selectbox = document.createElement("select");
                selectbox.id="combProduct";
                selectbox.style.cssText ="width:20px;font-size: medium;";
                tmp.parentNode.appendChild(selectbox,tmp);
                //q_cmbParse("combProduct", q_getPara('vccs_vu.product'));
                q_gt('ucc', '1=1 ', 0, 0, 0, "ucc"); 
                
                $('#combProduct').change(function() {
					$('#txtXproduct').val($('#combProduct').find("option:selected").text());
				});
                
                var tmp = document.getElementById("txtXspec");
                var selectbox = document.createElement("select");
                selectbox.id="combSpec";
                selectbox.style.cssText ="width:20px;font-size: medium;";
                tmp.parentNode.appendChild(selectbox,tmp);
                
                $('#combSpec').change(function() {
					$('#txtXspec').val($('#combSpec').find("option:selected").text());
				});
 				
 				if(window.parent.q_name=='cuc'){
 					$('#q_report .report div').eq(3).click();
 					$('#btnOk').click();
 				}	
 				
			}
			
            function q_boxClose(s2) {
            }
            
            var t_spec='@'
            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'spec':
                		var as = _q_appendData("spec", "", true);
						for ( i = 0; i < as.length; i++) {
							t_spec+=","+as[i].noa;
						}
						q_cmbParse("combSpec", t_spec); 
                		break;
                	case 'ucc':
						var as = _q_appendData("ucc", "", true);
						var t_ucc='@';
						for ( i = 0; i < as.length; i++) {
							t_ucc+=","+as[i].product;
						}
						q_cmbParse("combProduct", t_ucc);
						break;
                    default:
                        break;
                }
            }
		</script>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
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