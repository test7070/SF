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
						type : '6', //[1]
						name : 'xnoa'
					},{
						type : '1', //[2][3]
						name : 'xdate'
					}]
                });
				 q_popAssign();
                 q_getFormat();
                 q_langShow();
			
                 var r_1911=1911;
                 if(r_len==4){//西元年
						r_1911=0;
                 }else{
						$('#txtXdate1').datepicker();
						$('#txtXdate2').datepicker();
				 }
                 $('#txtXdate1').mask(r_picd);
                 $('#txtXdate2').mask(r_picd);
                 
                var t_date, t_year, t_month, t_day;
                t_date = new Date();
                t_date.setDate(1);
                t_year = t_date.getUTCFullYear() - r_1911;
                t_year = t_year > 99 ? t_year + '' : '0' + t_year;
                t_month = t_date.getUTCMonth() + 1;
                t_month = t_month > 9 ? t_month + '' : '0' + t_month;
                t_day = t_date.getUTCDate();
                t_day = t_day > 9 ? t_day + '' : '0' + t_day;
                $('#txtXdate1').val(t_year + '/' + t_month + '/' + t_day);      

                t_date = new Date();
                t_date.setDate(35);
                t_date.setDate(0);
                t_year = t_date.getUTCFullYear() - r_1911;
                t_year = t_year > 99 ? t_year + '' : '0' + t_year;
                t_month = t_date.getUTCMonth() + 1;
                t_month = t_month > 9 ? t_month + '' : '0' + t_month;
                t_day = t_date.getUTCDate();
                t_day = t_day > 9 ? t_day + '' : '0' + t_day;
                $('#txtXdate2').val(t_year + '/' + t_month + '/' + t_day);
				
				var t_key = q_getHref();
				if(t_key[1] != undefined){
				$('#txtXnoa').val(t_key[1]);}
                				
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
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
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