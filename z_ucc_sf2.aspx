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
            var uccgaItem = '';
            $(document).ready(function() {
                _q_boxClose();
                q_getId();
                q_gt('spec', '1=1 ', 0, 0, 0, "spec");
                
            });

            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_ucc_sf2',
                    options : [{
                        type : '0', //[1]
                        name : 'projectname',
                        value : q_getPara('sys.project').toUpperCase()
                    }, {
                        type : '0', //[2]
                        name : 'mountprecision',
                        value : q_getPara('vcc.mountPrecision')
                    }, {
                        type : '0', //[3]
                        name : 'weightprecision',
                        value : q_getPara('vcc.weightPrecision')
                    }, {
                        type : '0', //[4]
                        name : 'priceprecision',
                        value : q_getPara('vcc.pricePrecision')
                    },{
                        type : '0', //[5]
                        name : 'xuserno',
                        value : r_userno
                    },{
                        type : '0', //[6]
                        name : 'xrank',
                        value : r_rank
                    }, {
                        type : '6',
                        name : 'xproduct' //[7]
                    }, {
                        type : '6',
                        name : 'xucolor' //[8]
                    }, {
                        type : '6',
                        name : 'xspec' //[9]
                    }, {
                        type : '6',
                        name : 'xsize', //[10]
                    }, {
                        type : '1',
                        name : 'xlengthb' //[11][12]
                    }, {
                        type : '6',
                        name : 'xclass' //[13]
                    }, {
                        type : '6',
                        name : 'xuno' //[14]
                    }, {
                        type : '6',
                        name : 'xedate' //[15]
                    }, {
						type : '2', //[16][17]
						name : 'xstore',
						dbf : 'store',
						index : 'noa,store',
						src : 'store_b.aspx'
					}, {
                        type : '1',
                        name : 'xdate' //[18][19]
                    }, {
                        type : '1',
                        name : 'xmon' //[20][21]
                    },{
                        type : '0', //[22]
                        name : 'xlen',
                        value : r_len
                    }]
                });
                q_popAssign();
                q_getFormat();
                q_langShow();
                
                if(r_len==4){                	
                	$.datepicker.r_len=4;
					//$.datepicker.setDefaults($.datepicker.regional["ENG"]);
                }

                $('#txtXedate').mask(r_picd);
                $('#txtXedate').val(q_date());
                $('#txtXedate').datepicker();
                
                $('#txtXdate1').mask(r_picd);
                $('#txtXdate2').mask(r_picd);
                $('#txtXdate1').val(q_date().substr(0,r_lenm)+'/01');
                $('#txtXdate2').val(q_cdn(q_cdn(q_date().substr(0,r_lenm)+'/01',35).substr(0,r_lenm)+'/01',-1));
                
                $('#txtXmon1').mask(r_picm);
                $('#txtXmon2').mask(r_picm);
                $('#txtXmon1').val(q_date().substr(0,r_lenm));
                $('#txtXmon2').val(q_date().substr(0,r_lenm));
                
                $("#Xlengthb").css('width', '302px');
                $("#Xlengthb input").css('width', '90px');

                $('#txtXsize').change(function() {
                    if ($('#txtXsize').val().substr(0, 1) != '#')
                        $('#txtXsize').val('#' + $('#txtXsize').val());
                });

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
                q_cmbParse("combSpec", t_spec); 
                
                $('#combSpec').change(function() {
					$('#txtXspec').val($('#combSpec').find("option:selected").text());
				});
				
				var tmp = document.getElementById("txtXclass");
                var selectbox = document.createElement("select");
                selectbox.id="combClass";
                selectbox.style.cssText ="width:20px;font-size: medium;";
                tmp.parentNode.appendChild(selectbox,tmp);
                q_cmbParse("combClass", t_class); 
                
                $('#combClass').change(function() {
					$('#txtXclass').val($('#combClass').find("option:selected").text());
				});
				
				var tmp = document.getElementById("txtXsize");
                var selectbox = document.createElement("select");
                selectbox.id="combSize";
                selectbox.style.cssText ="width:20px;font-size: medium;";
                tmp.parentNode.appendChild(selectbox,tmp);
                q_cmbParse("combSize", ',#2,#3,#4,#5,#6,#7,#8,#9,#10,#11,#12,#13,#14,#15,#16');
                
                $('#combSize').change(function() {
                    $('#txtXsize').val($('#combSize').find("option:selected").text());
                }); 

				//類別暫時不放入
				var tmp = document.getElementById("txtXucolor");
                var selectbox = document.createElement("select");
                selectbox.id="combUcolor";
                selectbox.style.cssText ="width:20px;font-size: medium;";
                tmp.parentNode.appendChild(selectbox,tmp);
                q_cmbParse("combUcolor", t_color); 
                
                $('#combUcolor').change(function() {
					$('#txtXucolor').val($('#combUcolor').find("option:selected").text());
				});
				
				$('#txtXstore1a').val('A').change();
				$('#txtXstore2a').val('A3').change();
            }

            function q_popPost(s1) {
                switch (s1) {

                }
            }

            function q_boxClose(s2) {

            }
			
			var t_spec='@',t_color='@',t_class='@';
            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'spec':
                		var as = _q_appendData("spec", "", true);
						for ( i = 0; i < as.length; i++) {
							t_spec+=","+as[i].noa;
						}
						q_gt('color', '1=1 ', 0, 0, 0, "color");
                		break;
                	case 'color':
                		var as = _q_appendData("color", "", true);
						for ( i = 0; i < as.length; i++) {
							t_color+=","+as[i].color;
						}
						q_gt('class', '1=1 ', 0, 0, 0, "class");
                		break;
                	case 'class':
                		var as = _q_appendData("class", "", true);
						for ( i = 0; i < as.length; i++) {
							t_class+=","+as[i].noa;
						}
                		q_gf('', 'z_ucc_sf2');
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
	<body id="z_accc" ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div id="q_menu"> </div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="q_report"> </div>
				<!--<input type="button" id="btnUcf" value="成本結轉" style="font-weight: bold;font-size: medium;color: red;">-->
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>