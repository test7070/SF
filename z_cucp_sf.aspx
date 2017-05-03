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
         
			$(document).ready(function() {
            	q_getId();
                q_gf('', 'z_cucp_sf');       
            });
			function getLocation(){
            	var parser = document.createElement('a');
				parser.href = document.URL;
				return parser.protocol+'//'+parser.host;
				/*
				parser.href = "http://example.com:3000/pathname/?search=test#hash";
				parser.protocol; // => "http:"
				parser.host;     // => "example.com:3000"
				parser.hostname; // => "example.com"
				parser.port;     // => "3000"
				parser.pathname; // => "/pathname/"
				parser.hash;     // => "#hash"
				parser.search;   // => "?search=test"*/			
			}
            function q_gfPost() {
                $('#q_report').q_report({
                    fileName :'z_cucp_sf',
                    options : [{
						type : '0', //[1]
						name : 'path',
						value : getLocation()
					},{
						type : '6', //[2]
						name : 'xnoa'
					},{
						type : '1', //[3][4]
						name : 'xdate'
					},{
                        type : '2',//[5][6]
                        name : 'xcust',
                        dbf : 'cust',
                        index : 'noa,comp',
                        src : 'cust_b.aspx'
                    }, {
                        type : '6',
                        name : 'xproduct' //[7]
                    }, {
                        type : '6',
                        name : 'xspec' //[8]
                    }, {
                        type : '5',
                        name : 'xsize', //[9]
                        value:(',#2,#3,#4,#5,#6,#7,#8,#9,#10,#11,#12,#13,#14,#15,#16').split(',')
                    }, {
                        type : '6',
                        name : 'xmemo' //[10]
                    },{
                        type : '2',//[11][12] //直接以型式篩選要給的使用人 不篩選>裁剪 篩選彎料>成型
                        name : 'xpicno',
                        dbf : 'img',
                        index : 'noa,namea',
                        src : 'img_b.aspx'
                    },{
						type : '5',
						name : 'xorder',//[13]
						value :('#non@預設,memo@備註(區域),pic@加工型式,parafg@是否續接').split(',')
					},{
						type : '5',
						name : 'isparafg',//[14]
						value :('#non@全部,1@需續接,2@不續接').split(',')
					},{
						type : '8',
						name : 'ispage',//[15]
						value :('1@材質號數分頁').split(',')
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
                 
                $('#txtXdate1').val(q_date().substr(0,r_lenm)+'/01');
                $('#txtXdate2').val(q_cdn(q_cdn(q_date().substr(0,r_lenm)+'/01',45).substr(0,r_lenm)+'/01',-1));
				
				var t_key = q_getHref();
				if(t_key[1] != undefined){
					$('#txtXnoa').val(t_key[1]);
					
					if(window.parent.q_name=='z_cubp_sf'){
						$('#txtXnoa').val('');
						if(t_key[1].indexOf('z_cucp_sf')>-1){
							$('#txtXnoa').val(t_key[3]);
							t_report=t_key[1];
							var click_report=999;
							for(var i=0;i<$('#q_report').data().info.reportData.length;i++){
								if($('#q_report').data().info.reportData[i].report==t_report){
									click_report=i;
									$('#q_report div div .radio').eq(click_report).removeClass('nonselect').addClass('select').click();
								}
							}
							if($('#txtXnoa').val().length>0 && click_report!=999)
								$('#btnOk').click();
						}
					}
				}
				
				q_gt('spec', '1=1 ', 0, 0, 0, "spec");
				var tmp = document.getElementById("txtXspec");
                var selectbox = document.createElement("select");
                selectbox.id="combSpec";
                selectbox.style.cssText ="width:20px;font-size: medium;";
                tmp.parentNode.appendChild(selectbox,tmp);
                
                $('#combSpec').change(function() {
					$('#txtXspec').val($('#combSpec').find("option:selected").text());
				});
				
				$('#combSpec').css('font-size','medium');
				$('#Xsize select').css('font-size','medium');
				$('#Xorder select').css('font-size','medium');
				
				$('#Ispage').css('width','300px');
				$('#chkIspage').css('width','200px');
				$('#chkIspage span').css('width','150px');
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
                    default:
                        break;
                }
            }

	</script>
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