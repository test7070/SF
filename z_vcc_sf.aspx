<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title> </title>
		<script src="/../script/jquery.min.js" type="text/javascript"></script>
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
            var gfrun = false;
            var xucolorItem = '';
            var xspecItem = '';
            var t_qno = '';
            var xclassItem = '';
            var xuccItem = '';
            var xcustItem = '';
            var t_first = true;

            if (location.href.indexOf('?') < 0) {
                location.href = location.href + "?;;;;100";
            }

            $(document).ready(function() {
                q_getId();
                q_gt('spec', '1=1 ', 0, 0, 0, "spec");
                
                $('#q_report').click(function(e) {
                	if(window.parent.q_name=="z_quatp_vu"){
                		for(var i=0;i<$('#q_report').data().info.reportData.length;i++){
							if($('#q_report').data().info.reportData[i].report!='z_vcc_sf9')
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

            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_vcc_sf',
                    options : [{
                        type : '0', //[1]
                        name : 'accy',
                        value : q_getId()[4]
                    }, {
                        type : '0', //[2] //判斷vcc是內含或應稅
                        name : 'vcctax',
                        value : q_getPara('sys.d4taxtype')
                    }, {
                        type : '0', //[3] //判斷顯示小數點
                        name : 'acomp',
                        value : q_getPara('sys.comp')
                    }, {
                        type : '1', //[4][5]//1
                        name : 'date'
                    }, {
                        type : '1', //[6][7]//2
                        name : 'mon'
                    }, { //106/12/28 換成下拉單選 楊
                        type : '2', //[8][9]
                        name : 'cust',
                        dbf : 'cust',
                        index : 'noa,comp',
                        src : 'cust_b.aspx'
                    }, {
                        type : '5',
                        name : 'vcctypea', //[10]//1000
                        value : [q_getPara('report.all')].concat(q_getPara('vcc.typea').split(','))
                    }, {
                        type : '5',
                        name : 'xproduct', //[11]
                        value : xuccItem.split(',')
                    }, {
                        type : '5',
                        name : 'xspec', //[12]
                        value : xspecItem.split(',')
                    }, {
                        type : '5',
                        name : 'xsize', //[13]
                        value : (' @全部,#2,#3,#4,#5,#6,#7,#8,#9,#10,#11,#12,#13,#14,#15,#16').split(',')
                    }, {
                        type : '5',
                        name : 'xclass', //[14]
                        value : xclassItem.split(',')
                    }, {
                        type : '8', //[15]
                        name : 'xshowenda',
                        value : "1@依號數排序".split(',')
                    }, {
                        type : '1',
                        name : 'xlengthb', //[16][17]
                    }, {
                        type : '6', //[18]
                        name : 'qno',
                    }, {
                        type : '2', //[19][20]
                        name : 'xstore',
                        dbf : 'store',
                        index : 'noa,store',
                        src : 'store_b.aspx'
                    }, {
                        type : '8',
                        name : 'xatax', //[21]
                        value : '1@顯示稅金'.split(',')
                    }, {
                        type : '8',
                        name : 'xcouplers', //[22]
                        value : '1@續接器'.split(',')
                    }, {
                        type : '6', //[23]
                        name : 'xaddr2'
                    }, {
                        type : '1', //[24][25]
                        name : 'Xdate'
                    }, {
                        type : '8', //[26]
                        name : 'xnoshowget',
                        value : "1@不含互換出貨".split(',')
                    }]
                });
                q_popAssign();
                q_getFormat();
                q_langShow();

                if(r_len==4){                	
                	$.datepicker.r_len=4;
					//$.datepicker.setDefaults($.datepicker.regional["ENG"]);
                }
                
                $('#txtDate1').datepicker();
                $('#txtDate2').datepicker();
                $('#txtXdate1').datepicker();
                $('#txtXdate2').datepicker();

                $('#txtMon1').mask(r_picm);
                $('#txtMon2').mask(r_picm);

                $('#txtDate1').mask(r_picd);
                $('#txtDate2').mask(r_picd);
                $('#txtXdate1').mask(r_picd);
                $('#txtXdate2').mask(r_picd);

                $('#txtDate1').val(q_date().substr(0, r_lenm) + '/01');
                $('#txtMon1').val(q_date().substr(0, r_lenm));
                $('#txtXdate1').val(q_date().substr(0, r_lenm) + '/01');
                $('#txtDate2').val(q_cdn(q_cdn(q_date().substr(0, r_lenm) + '/01', 35).substr(0, r_lenm) + '/01', -1));
                $('#txtXdate2').val(q_date());
                $('#txtMon2').val(q_date().substr(0, r_lenm));

                //$('.c3').css('display : none');
                $('#txtXlengthb1').addClass('num').val(0).change(function() {
                    $(this).val(dec($(this).val()));
                    if (isNaN($(this).val()))
                        $(this).val(0);
                });
                $('#txtXlengthb2').addClass('num').val(99).change(function() {
                    $(this).val(dec($(this).val()));
                    if (isNaN($(this).val()))
                        $(this).val(99);
                });

                var tmp = document.getElementById("txtQno");
                var selectbox = document.createElement("select");
                selectbox.id = "combQno";
                selectbox.style.cssText = "width:20px;font-size: medium;";
                tmp.parentNode.appendChild(selectbox, tmp);
                
                $('#combQno').change(function() {
                    $('#txtQno').val($('#combQno').find("option:selected").text());
                });

                $('#txtCust1a').focusout(function() {
                    //變動合約
                    $('#combQno').empty();
                    if (!emp($('#txtCust1a').val()) && !emp($('#txtCust2a').val())) {
                        var t_where = "where=^^ custno between '" + $('#txtCust1a').val() + "' and case when isnull('" + $('#txtCust2a').val() + "','')='' then char(255) else '" + $('#txtCust2a').val() + "' end order by datea desc,noa desc  --^^ stop=999 "
                        q_gt('view_quat', t_where, 0, 0, 0, "view_quat");
                    } else {
                        var t_where = "where=^^datea between '" + $('#txtDate1').val() + "' and '" + $('#txtDate2').val() + "' and custno between '" + $('#txtCust1a').val() + "' and case when isnull('" + $('#txtCust2a').val() + "','')='' then char(255) else '" + $('#txtCust2a').val() + "' end order by datea desc,noa desc  --^^ stop=999 "
                        q_gt('view_quat', t_where, 0, 0, 0, "view_quat");
                    }
                    
                    //變動工地
                    /*if (!emp($('#txtCust1a').val()) && !emp($('#txtCust2a').val()) && !emp($('#txtQno').val())) {
	                    var t_where = "where=^^datea between '" + $('#txtDate1').val() + "' and '" + $('#txtDate2').val() + "' and apvmemo like '%" + $('#txtQno').val() + "@%' ^^ "
	                    q_gt('view_vcc', t_where, 0, 0, 0, "view_vcc");
	                } else {
	                    var t_where = "where=^^datea between '" + $('#txtDate1').val() + "' and '" + $('#txtDate2').val() + "' and (custno between '" + $('#txtCust1a').val() + "' and case when isnull('" + $('#txtCust2a').val() + "','')='' then '" + $('#txtCust1a').val() + "' else '" + $('#txtCust2a').val() + "' end) and isnull(addr2,'')!='' ^^ stop=999"
	                    q_gt('view_vcc', t_where, 0, 0, 0, "view_vcc");
	                }*/
					if (!emp($('#txtCust1a').val()) && !emp($('#txtCust2a').val())) {	                    
	                    var t_where = "where=^^noa between '" + $('#txtCust1a').val() + "' and '" + $('#txtCust2a').val() + "' ^^ "
	                    q_gt('custms', t_where, 0, 0, 0, "getcustm");
	                }
                });

                $('#txtCust2a').focusout(function() {
                    //變動合約
                    $('#combQno').empty();
                    $('#combXaddr2').empty();
                    if (!emp($('#txtCust1a').val()) && !emp($('#txtCust2a').val())) {
                        var t_where = "where=^^ custno between '" + $('#txtCust1a').val() + "' and case when isnull('" + $('#txtCust2a').val() + "','')='' then char(255) else '" + $('#txtCust2a').val() + "' end order by datea desc,noa desc  --^^ stop=999 "
                        q_gt('view_quat', t_where, 0, 0, 0, "view_quat");
                    } else {
                        var t_where = "where=^^datea between '" + $('#txtDate1').val() + "' and '" + $('#txtDate2').val() + "' and custno between '" + $('#txtCust1a').val() + "' and case when isnull('" + $('#txtCust2a').val() + "','')='' then char(255) else '" + $('#txtCust2a').val() + "' end order by datea desc,noa desc  --^^ stop=999 "
                        q_gt('view_quat', t_where, 0, 0, 0, "view_quat");
                    }
                    q_gt('view_quat', t_where, 0, 0, 0, "view_quat");
                    
                    //變動工地
                    /*if (!emp($('#txtCust1a').val()) && !emp($('#txtCust2a').val()) && !emp($('#txtQno').val())) {
	                    var t_where = "where=^^datea between '" + $('#txtDate1').val() + "' and '" + $('#txtDate2').val() + "' and apvmemo like '%" + $('#txtQno').val() + "@%' ^^ "
	                    q_gt('view_vcc', t_where, 0, 0, 0, "view_vcc");
	                } else {
	                    var t_where = "where=^^datea between '" + $('#txtDate1').val() + "' and '" + $('#txtDate2').val() + "' and (custno between '" + $('#txtCust1a').val() + "' and case when isnull('" + $('#txtCust2a').val() + "','')='' then '" + $('#txtCust1a').val() + "' else '" + $('#txtCust2a').val() + "' end) and isnull(addr2,'')!='' ^^ stop=999"
	                    q_gt('view_vcc', t_where, 0, 0, 0, "view_vcc");
	                }*/
                    if (!emp($('#txtCust1a').val()) && !emp($('#txtCust2a').val())) {	                    
	                    var t_where = "where=^^noa between '" + $('#txtCust1a').val() + "' and '" + $('#txtCust2a').val() + "' ^^ "
	                    q_gt('custms', t_where, 0, 0, 0, "getcustm");
	                }
                });
                
                $('#Bcust select').change(function() {
                	//變動合約
                    $('#combQno').empty();
                    $('#combXaddr2').empty();
                    var t_custno=$('#Bcust select').val();
                    
                    if (!emp(t_custno)) {
                        var t_where = "where=^^datea between '" + $('#txtDate1').val() + "' and '" + $('#txtDate2').val() + "' and custno='"+t_custno+"' order by datea desc,noa desc  --^^ stop=999 "
                        q_gt('view_quat', t_where, 0, 0, 0, "view_quat");
                    } else {
                        var t_where = "where=^^datea between '" + $('#txtDate1').val() + "' and '" + $('#txtDate2').val() + "' order by datea desc,noa desc  --^^ stop=999 "
                        q_gt('view_quat', t_where, 0, 0, 0, "view_quat");
                    }
                    q_gt('view_quat', t_where, 0, 0, 0, "view_quat");
                    
                    if (!emp(t_custno)) {
	                    var t_where = "where=^^noa = '" + t_custno + "' ^^ "
	                    q_gt('custms', t_where, 0, 0, 0, "getcustm");
	                }
                });

                if (window.parent.q_name == "z_quatp_vu") {
                    $('#txtQno').val(q_getHref()[1]);
                    $('#txtDate1').val(q_getHref()[3].substr(0, r_lenm) + '/01');
                    $('#q_report div div .radio.select').click();
                }

                $('#Xcouplers').css('width', '300px').css('height', '30px');
                $('#Xcouplers .label').css('width', '0px');
                $('#chkXcouplers').css('width', '220px').css('margin-top', '5px');
                $('#chkXcouplers span').css('width', '180px')

                var tmp = document.getElementById("txtXaddr2");
                var selectbox = document.createElement("select");
                selectbox.id = "combXaddr2";
                selectbox.style.cssText = "width:20px;font-size: medium;";
                tmp.parentNode.appendChild(selectbox, tmp);

                $('#combXaddr2').change(function() {
                    $('#txtXaddr2').val($('#combXaddr2').find("option:selected").text());
                });

                //$('#q_report .report').css('width', '400px');
                //$('#q_report .report div').css('width', '200px');

                $('#Xshowenda').css('width', '300px').css('height', '30px');
                $('#Xshowenda .label').css('width', '0px');
                $('#chkXshowenda').css('width', '220px').css('margin-top', '5px');
                $('#chkXshowenda span').css('width', '180px')

                $('#Xnoshowget').css('width', '300px').css('height', '30px');
                $('#Xnoshowget .label').css('width', '0px');
                $('#chkXnoshowget').css('width', '220px').css('margin-top', '5px');
                $('#chkXnoshowget span').css('width', '180px')
                $('#chkXnoshowget').children('input').attr('checked', 'checked');
                
                $('#txtCust1b').hide();
                $('#btnCust1').hide();
                $('#txtCust2b').hide();
                $('#btnCust2').hide();
                
                $('#txtCust1a').after("<select id='combbcust' style='width:120px;font-size: medium;float:left;'></select>");
                $('#txtCust2a').after("<select id='combecust' style='width:120px;font-size: medium;float:left;'></select>");
                
                $('#combbcust').change(function() {
                	$('#txtCust1a').val($(this).val());
                	$('#txtCust2a').val($(this).val());
                	$('#combecust').val($(this).val());
				});
				$('#combecust').change(function() {
                	$('#txtCust2a').val($(this).val());
				});
				
				$('#txtCust1a').change(function() {
                	$('#combbcust').val($(this).val());
                	$('#combecust').val($(this).val());
				});
				
				$('#txtCust2a').change(function() {
                	$('#combecust').val($(this).val());
				});
                
                if (xcustItem.length != 0) {
					q_cmbParse("combbcust", xcustItem);
					q_cmbParse("combecust", xcustItem);
				}
				
				if(window.parent.q_name=="z_quatp_vu"){
					$('#btnOk').click();	
				}
            }

            function q_boxClose(s2) {
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'spec':
                        var as = _q_appendData("spec", "", true);
                        xspecItem = " @全部";
                        for ( i = 0; i < as.length; i++) {
                            xspecItem += "," + as[i].noa;
                        }
                        q_gt('color', '1=1 ', 0, 0, 0, "color");
                        break;
                    case 'color':
                        var as = _q_appendData("color", "", true);
                        xucolorItem = " @全部";
                        for ( i = 0; i < as.length; i++) {
                            xucolorItem += "," + as[i].color;
                        }
                        q_gt('class', '1=1 ', 0, 0, 0, "class");
                        break;
                    case 'class':
                        var as = _q_appendData("class", "", true);
                        xclassItem = " @全部";
                        for ( i = 0; i < as.length; i++) {
                            xclassItem += "," + as[i].noa;
                        }
                        q_gt('ucc', '1=1 ', 0, 0, 0, "ucc");
                        break;
                    case 'ucc':
                        xuccItem = " @全部";
                        var as = _q_appendData("ucc", "", true);
                        for ( i = 0; i < as.length; i++) {
                            xuccItem += "," + as[i].product;
                        }
                        q_gt('cust', '1=1 ', 0, 0, 0, "cust");
                        break;
					case 'cust':
                        xcustItem = " @全部";
                        var as = _q_appendData("cust", "", true);
                        for ( i = 0; i < as.length; i++) {
                            xcustItem += ","+as[i].noa+"@" + as[i].nick+"  "+as[i].noa;
                        }
                        break;
                    case 'view_quat':
                        var as = _q_appendData("view_quat", "", true);
                        if (as[0] != undefined) {
                            for ( i = 0; i < as.length; i++) {
                                t_qno += "," + as[i].noa;
                            }
                            if (t_qno.length != 0) {
                                $('#combQno').empty();
                                q_cmbParse("combQno", t_qno);
                            }
                            t_qno = '';
                        }
                        break;
                    case 'view_vcc':
                        var as = _q_appendData("view_vcc", "", true);
                        if (as[0] != undefined) {
                            var t_addr2 = '';
                            for ( i = 0; i < as.length; i++) {
                                var tt_addr2 = t_addr2.split(',');
                                var t_exists = false;
                                for (var j = 0; j < tt_addr2.length; j++) {
                                    if (as[i].addr2 == tt_addr2[j]) {
                                        t_exists = true;
                                        break;
                                    }
                                }
                                if (!t_exists)
                                    t_addr2 += "," + as[i].addr2;
                            }
                            if (t_addr2.length != 0) {
                                $('#combXaddr2').empty();
                                q_cmbParse("combXaddr2", t_addr2);
                            }
                        }
                        break;
					case 'getcustm':
                        var as = _q_appendData("custms", "", true);
                        if (as[0] != undefined) {
                            var t_addr2 = '';
                            for ( i = 0; i < as.length; i++) {
                                var tt_addr2 = t_addr2.split(',');
                                var t_exists = false;
                                for (var j = 0; j < tt_addr2.length; j++) {
                                    if (as[i].account == tt_addr2[j]) {
                                        t_exists = true;
                                        break;
                                    }
                                }
                                if (!t_exists)
                                    t_addr2 += "," + as[i].account;
                            }
                            if (t_addr2.length != 0) {
                                $('#combXaddr2').empty();
                                q_cmbParse("combXaddr2", t_addr2);
                            }
                        }
                        break;

                }
                if (xcustItem.length > 0 && !gfrun) {
                    gfrun = true;
                    q_gf('', 'z_vcc_sf');
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
