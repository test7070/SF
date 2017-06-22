<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
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
			this.errorHandler = null;
			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}
			q_desc = 1;
			q_tables = 's';
			var q_name = "orde";
			var q_readonly = ['txtNoa', 'txtWorker', 'txtWorker2', 'txtComp', 'txtAcomp', 'txtMoney','txtTotal', 'txtTotalus', 'txtSales', 'txtOrdbno', 'txtOrdcno'];
			var q_readonlys = ['txtTotal', 'txtQuatno', 'txtNo2', 'txtNo3', 'txtC1', 'txtNotv'];
			var bbmNum = [];
			var bbsNum = [];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'odate';
			brwCount2 = 11;
			
			aPop = new Array(
				['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'],
				['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'],
				['txtCustno', 'lblCust', 'cust', 'noa,comp,nick,paytype,trantype,tel,fax,zip_home,addr_home', 'txtCustno,txtComp,txtNick,txtPaytype,cmbTrantype,txtTel,txtFax,txtPost,txtAddr', 'cust_b.aspx']
				//['txtPost', 'lblAddr', 'addr2', 'noa,post', 'txtPost,txtAddr', 'addr2_b.aspx'],
				//['txtPost2', 'lblAddr2', 'addr2', 'noa,post', 'txtPost2,txtAddr2', 'addr2_b.aspx'],
				//,['txtProductno_', 'btnProductno_', 'ucaucc', 'noa,product,unit,spec', 'txtProductno_,txtProduct_,txtUnit_,txtSpec_,txtUcolor_', 'ucaucc_b.aspx']
				//['txtUno__', '', 'view_uccc2', 'uno,uno,productno,product,spec,size,lengthb,class,unit,emount,eweight'
            	//, '0txtUno__,txtUno__,txtProductno__,txtProduct__,txtSpec__,txtSize__,txtLengthb__,txtClass__,txtUnit__,txtMount__,txtWeight__', 'uccc_seek_b2.aspx?;;;1=0', '95%', '60%']
			);
			
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'no2'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
				q_gt('acomp', 'stop=1 ', 0, 0, 0, "cno_acomp");
				q_gt('ucc', '1=1 ', 0, 0, 0, "bbsucc");
				q_gt('spec', '1=1 ', 0, 0, 0, "bbsspec");
				q_gt('color', '1=1 ', 0, 0, 0, "bbscolor");
				q_gt('class', '1=1 ', 0, 0, 0, "bbsclass");
				q_gt('adspec', '1=1 ', 0, 0, 0, "bbsspec2");
				q_gt('adpro', '1=1 ', 0, 0, 0, "bbspro");
				q_gt('img', "where=^^ noa like 'Z%' ^^ ", 0, 0, 0, "bbsimg");
				$('#txtOdate').focus();
			});

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(1);
			}

			function sum() {
				var t1 = 0, t_unit, t_mount=0, t_weight = 0;
				for (var j = 0; j < q_bbsCount; j++) {
					var tproduct=$('#txtProduct_'+j).val();
					if(tproduct.indexOf('費')>-1 || tproduct.indexOf('續接')>-1 || tproduct.indexOf('組接')>-1 || tproduct.indexOf('水泥方塊')>-1){
						t_mount = $('#txtMount_' + j).val();
					}else{
						t_mount = $('#txtWeight_' + j).val();
					}
					$('#txtTotal_' + j).val(round(q_mul(dec($('#txtPrice_' + j).val()), dec(t_mount)), 0));//小計	
					t_weight = t_weight + dec( $('#txtWeight_' + j).val()) ; // 重量合計
					t1 = q_add(t1, dec($('#txtTotal_' + j).val()));//金額合計
				}
				
				if($('#chkAtax').prop('checked')){
					var t_taxrate = q_div(parseFloat(q_getPara('sys.taxrate')), 100);
					t_tax = round(q_mul(t1, t_taxrate), 0);
					t_total = q_add(t1, t_tax);
				}else{
					t_tax = q_float('txtTax');
					t_total = q_add(t1, t_tax);
				}
				
				$('#txtMoney').val(FormatNumber(round(t1, 0)));
				$('#txtTax').val(FormatNumber(t_tax));
				$('#txtTotal').val(FormatNumber(t_total));
			}

			function mainPost() {
				q_getFormat();
				bbmMask = [['txtOdate', r_picd],['txtDatea', r_picd]];
				q_mask(bbmMask);
				bbsMask = [['txtDatea', r_picd]];
				bbmNum = [['txtTranadd', 15, q_getPara('vcc.weightPrecision'), 1],['txtBenifit', 15, q_getPara('vcc.weightPrecision'), 1],['txtWeight', 15, q_getPara('vcc.weightPrecision'), 1]
								,['txtTotal', 15, 0, 1], ['txtMoney', 15, 0, 1], ['txtTax', 15,0 , 1]];
				bbsNum = [['txtPrice', 15, q_getPara('vcc.pricePrecision'), 1], ['txtMount', 15, q_getPara('vcc.mountPrecision'), 1]
								,['txtWeight', 15, q_getPara('vcc.weightPrecision'), 1], ['txtLengthb', 15, 2, 1], ['txtTotal', 15, 0, 1]];
				
				q_cmbParse("cmbStype", q_getPara('orde.stype'));
				q_cmbParse("combPaytype", q_getPara('vcc.paytype'));
				q_cmbParse("cmbTrantype", q_getPara('sys.tran'));
				
				$('#lblAddr2').text('工地名稱');
				$('#lblTranadd').text('車空重');
				$('#lblBenifit').text('車總重');
				$('#lblWeight').text('淨重');
				$('#lblDatea').text('預交日');
				
				$('#txtTranadd').change(function() {
					q_tr('txtWeight',q_sub(q_float('txtBenifit'),q_float('txtTranadd')))
				});
				$('#txtBenifit').change(function() {
					q_tr('txtWeight',q_sub(q_float('txtBenifit'),q_float('txtTranadd')))
				});
				
				$('#cmbTaxtype').change(function() {
					sum();
				});
				
				$('#chkAtax').click(function() {
					refreshBbm();
					sum();
				});
				
				$('#txtTax').change(function() {
					sum();
				});
				
				$('#txtAddr').change(function() {
					var t_custno = trim($(this).val());
					if (!emp(t_custno)) {
						focus_addr = $(this).attr('id');
						var t_where = "where=^^ noa='" + t_custno + "' ^^";
						q_gt('cust', t_where, 0, 0, 0, "");
					}
				});
				
				$('#txtCustno').change(function() {
					if (!emp($('#txtCustno').val())) {
						var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^";
						q_gt('custm', t_where, 0, 0, 0, "");
					}
				});
				
				$('#chkCancel').click(function(){
					if($(this).prop('checked')){
						for(var k=0;k<q_bbsCount;k++){
							$('#chkCancel_'+k).prop('checked',true);
						}
					}
				});
				
				$('#textNouno').click(function() {
                	q_msg($(this),'多批號領料請用,隔開');
				});
				
				$('#btnClose_div_nouno').click(function() {
					$('#textNouno').val('');
                	$('#div_nouno').hide();
				});
			}
			
			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case 'quats':
						if (q_cur > 0 && q_cur < 4) {
							b_ret = getb_ret();
							if (!b_ret || b_ret.length == 0)
								return;
							var t_quatno='';
							for (var i = 0; i < b_ret.length; i++) {
								if (t_quatno.indexOf(b_ret[i].noa) == -1)
									t_quatno = t_quatno + (t_quatno.length > 0 ? (',' + b_ret[i].noa) : b_ret[i].noa);
							}
							$('#txtContract').val(t_quatno);
							
							//取得報價的第一筆匯率等資料
							var t_where = "where=^^ noa='" + b_ret[0].noa + "' ^^";
							q_gt('quat', t_where, 0, 0, 0, "", r_accy);

							var i, j = 0;
							ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtProduct,txtSpec,txtSize,txtLengthb,txtClass,txtUnit,txtPrice,txtMount,txtWeight,txtQuatno,txtNo3'
							, b_ret.length, b_ret, 'product,spec,size,lengthb,class,unit,price,mount,weight,noa,no3', 'txtProduct,txtSpec');
							/// 最後 aEmpField 不可以有【數字欄位】
							sum();
							bbsAssign();
						}
						break;

					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}

			function browTicketForm(obj) {
				//資料欄位名稱不可有'_'否則會有問題
				if (($(obj).attr('readonly') == 'readonly') || ($(obj).attr('id').substring(0, 3) == 'lbl')) {
					if ($(obj).attr('id').substring(0, 3) == 'lbl')
						obj = $('#txt' + $(obj).attr('id').substring(3));
					var noa = $.trim($(obj).val());
					var openName = $(obj).attr('id').split('_')[0].substring(3).toLowerCase();
					if (noa.length > 0) {
						switch (openName) {
							case 'ordbno':
								q_box("ordb.aspx?;;;charindex(noa,'" + noa + "')>0;" + r_accy, 'ordb', "95%", "95%", q_getMsg("popOrdb"));
								break;
							case 'ordcno':
								q_box("ordc.aspx?;;;noa='" + noa + "';" + r_accy, 'ordc', "95%", "95%", q_getMsg("popOrdc"));
								break;
							case 'quatno':
								q_box("quat.aspx?;;;noa='" + noa + "';" + r_accy, 'quat', "95%", "95%", q_getMsg("popQuat"));
								break;
						}
					}
				}
			}

			var focus_addr = '';
			var z_cno = r_cno, z_acomp = r_comp, z_nick = r_comp.substr(0, 2);
			var a_spec='@',a_spec2='@',a_color='@',a_pro='@',a_class='@'; //106/01/04 續接器 類別 材質改抓續接參數 廠牌 =直彎
			var a_img=[],a_class2='@';//106/01/06改抓img編號名稱
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'bbsucc':
						var as = _q_appendData("ucc", "", true);
						var t_ucc='@';
						for (var i = 0; i < as.length; i++) {
							t_ucc+=","+as[i].product;
						}
						q_cmbParse("combProduct", t_ucc,'s');
						break;
					case 'bbsspec':
						var as = _q_appendData("spec", "", true);
						var t_spec='@';
						for (var i = 0; i < as.length; i++) {
							t_spec+=","+as[i].noa;
							a_spec+=","+as[i].noa;
						}
						q_cmbParse("combSpec", t_spec,'s');
						break;
					case 'bbsspec2':
						var as = _q_appendData("adspec", "", true);
						a_spec2='@';
						for (var i = 0; i < as.length; i++) {
							a_spec2+=","+as[i].spec;
						}
						break;
					case 'bbscolor':
						var as = _q_appendData("color", "", true);
						var t_color='@';
						for (var i = 0; i < as.length; i++) {
							t_color+=","+as[i].color;
							a_color+=","+as[i].color;
						}
						q_cmbParse("combUcolor", t_color,'s');
						break;
					case 'bbsclass':
						var as = _q_appendData("class", "", true);
						var t_class='@';
						for (var i = 0; i < as.length; i++) {
							t_class+=","+as[i].noa;
							a_class+=","+as[i].noa;
						}
						q_cmbParse("combClass", t_class,'s');
						break;
					case 'bbspro':
						var as = _q_appendData("adpro", "", true);
						a_pro='@';
						for (var i = 0; i < as.length; i++) {
							a_pro+=","+as[i].product;
						}
						break;
					case 'bbsimg':
						a_img = _q_appendData("img", "", true);
						a_class2='@'
						for (var i = 0; i < a_img.length; i++) {
							a_class2+=","+a_img[i].noa+'@'+a_img[i].noa+' '+a_img[i].namea;
						}
						for (var j = 0; j < q_bbsCount; j++) {
							chgimg(j);
						}
						break;
					case 'cno_acomp':
						var as = _q_appendData("acomp", "", true);
						if (as[0] != undefined) {
							z_cno = as[0].noa;
							z_acomp = as[0].acomp;
							z_nick = as[0].nick;
						}
						break;
					case 'custm':
						var as = _q_appendData("custm", "", true);
						if(as[0] != undefined){
							var ass = _q_appendData("custms", "", true);
							if(ass[0] != undefined){
								var t_item = " @ ";
								for ( i = 0; i < ass.length; i++) {
									t_item = t_item + (t_item.length > 0 ? ',' : '') + ass[i].account + '@' + ass[i].account;
								}
								$('#combAddr').text('');
								q_cmbParse("combAddr", t_item);
							}else{
								$('#combAddr').text('');
							}
						}else{
							$('#combAddr').text('');
						}
						break;
					case 'quat':
						var as = _q_appendData("quat", "", true);
						if (as[0] != undefined) {
							if(as[0].atax=='true'){
								$('#cmbTaxtype').val('3')
							}else{
								$('#cmbTaxtype').val('1')
							}
							sum();
						}
						break;
					case 'cust':
						var as = _q_appendData("cust", "", true);
						if (as[0] != undefined && focus_addr != '') {
							$('#' + focus_addr).val(as[0].addr_fact);
							focus_addr = '';
						}
						break;
					
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
			}
			
			function chgcombSpec(n) {
				$('#combSpec_'+n).text('');
				if($('#txtProduct_'+n).val().indexOf('續接')>-1 || $('#txtProduct_'+n).val().indexOf('組接')>-1)
					q_cmbParse("combSpec_"+n, a_pro);
				else
					q_cmbParse("combSpec_"+n, a_spec);
			}
			
			//106/06/21關閉
			function chgcombUcolor(n) {
				$('#combUcolor_'+n).text('');
				if($('#txtProduct_'+n).val().indexOf('續接')>-1 && $('#txtProduct_'+n).val().indexOf('加工費')>-1)
					q_cmbParse("combUcolor_"+n, ',續接器-直牙(支),續接器-錐牙(支),續接超長5~6M,續接超長6~7M,續接超長7~8M,續接超長(支),組接工資(支),組接超高1.5~1.8M,組接超高1.81~2M,組接超高2M ↑,組接點工');
				else if($('#txtProduct_'+n).val().indexOf('續接')>-1 || $('#txtProduct_'+n).val().indexOf('組接')>-1)
					q_cmbParse("combUcolor_"+n, a_pro);
				else
					q_cmbParse("combUcolor_"+n, a_color);
			}
			
			function chgcombClass(n) {
				$('#combClass_'+n).text('');
				if($('#txtProduct_'+n).val().indexOf('續接')>-1 || $('#txtProduct_'+n).val().indexOf('組接')>-1)
					q_cmbParse("combClass_"+n, a_class2);
				else
					q_cmbParse("combClass_"+n, a_class);
			}
			
			function chgimg(n) { //a_img
				if(($('#txtProduct_'+n).val().indexOf('續接')>-1 || $('#txtProduct_'+n).val().indexOf('組接')>-1) && $('#txtClass_'+n).val()!=''){
					var t_imgorg='';
					
					for (var i=0;i<a_img.length;i++){
						if($('#txtClass_'+n).val()==a_img[i].noa){
							t_imgorg=a_img[i].org;
							break;
						}
					}
					if(t_imgorg.length==0){
						return;
					}
										
					$('#imgPic_'+n).attr('src',t_imgorg);
					var imgwidth = 300;
					var imgheight = 100;
					$('#canvas_'+n).width(imgwidth).height(imgheight);
					var c = document.getElementById("canvas_"+n);
					var ctx = c.getContext("2d");		
					c.width = imgwidth;
					c.height = imgheight;
					ctx.drawImage($('#imgPic_'+n)[0],0,0,imgwidth,imgheight);
					
					//------------------------------
					$('#imgPic_'+n).attr('src',c.toDataURL());
					//條碼用圖形
					xx_width = 355;
					xx_height = 119;						
					$('#canvas_'+n).width(xx_width).height(xx_height);
					c.width = xx_width;
					c.height = xx_height;
					$('#canvas_'+n)[0].getContext("2d").drawImage($('#imgPic_'+n)[0],0,0,imgwidth,imgheight,0,0,xx_width,xx_height);
					//報表用圖形 縮放為150*50
					$('#canvas_'+n).width(150).height(50);
					c.width = 150;
					c.height = 50;
					$('#canvas_'+n)[0].getContext("2d").drawImage($('#imgPic_'+n)[0],0,0,imgwidth,imgheight,0,0,150,50);
				}
				chgbbswidth();
			}
			
			function chgbbswidth() {
				var isCouplers=false;
				for (var i = 0; i < q_bbsCount; i++) {
					if($('#txtProduct_'+i).val().indexOf('續接')>-1 || $('#txtProduct_'+i).val().indexOf('組接')>-1){
						isCouplers=true;
						break;
					}
				}
				if(isCouplers){
					$('#dbbs').css('width','1590px');
					$('.img').show();
				}else{
					$('#dbbs').css('width','1390px');
					$('.img').hide();
				}
			}
			
			function btnOk() {
				t_err = '';
				t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtCustno', q_getMsg('lblCustno')], ['txtCno', q_getMsg('btnAcomp')]]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				
				if(emp($('#txtDatea').val()))
					$('#txtDatea').val(q_cdn($.trim($('#txtOdate').val()),15))
				for(var k=0;k<q_bbsCount;k++){					
					if(!emp($('#txtDatea').val()))
						$('#txtDatea_'+k).val($.trim($('#txtDatea').val()));
				}
				
				//1030419 當專案沒有勾 BBM的取消和結案被打勾BBS也要寫入
				if(!$('#chkIsproj').prop('checked')){
					for (var j = 0; j < q_bbsCount; j++) {
						if($('#chkEnda').prop('checked'))
							$('#chkEnda_'+j).prop('checked','true');
						if($('#chkCancel').prop('checked'))
							$('#chkCancel_'+j).prop('checked','true')
					}
				}
				
				for (var j = 0; j < q_bbsCount; j++) {
					var tproduct=$('#txtProduct_'+j).val();
					if(tproduct.indexOf('續接')>-1 || tproduct.indexOf('組接')>-1){
						var t_para1=$('#txtUcolor_'+j).val().replace(/[^0-9]/g,"");
						var t_para2=$('#txtSpec_'+j).val().replace(/[^0-9]/g,"");
						var tmp='';
						if(t_para1!='' && t_para2!=''){
							if(dec(t_para1)>dec(t_para2)){
								tmp=$('#txtUcolor_'+j).val();
								$('#txtUcolor_'+j).val($('#txtSpec_'+j).val());
								$('#txtSpec_'+j).val(tmp);
							}
						}
					}
				}
				
				if (q_cur == 1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);
				sum();

				var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
				if (s1.length == 0 || s1 == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_orde') + $('#txtOdate').val(), '/', ''));
				else
					wrServer(s1);
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('orde_sf_s.aspx', q_name + '_s', "500px", "450px", q_getMsg("popSeek"));
			}

			function combPaytype_chg() {
				var cmb = document.getElementById("combPaytype");
				if (!q_cur)
					cmb.value = '';
				else
					$('#txtPaytype').val(cmb.value);
				cmb.value = '';
			}
			
			function combAddr_chg() {
				if (q_cur == 1 || q_cur == 2) {
					$('#txtAddr2').val($('#combAddr').find("option:selected").val());
				}
			}

			function bbsAssign() {
				for (var j = 0; j < (q_bbsCount == 0 ? 1 : q_bbsCount); j++) {
					if (!$('#btnMinus_' + j).hasClass('isAssign')) {
						$('#btnMinus_' + j).click(function() {
							btnMinus($(this).attr('id'));
						});
						
						$('#txtWeight_' + j).focusout(function () { sum(); });
						$('#txtPrice_' + j).focusout(function() {sum();});
						$('#txtMount_' + j).focusout(function() {sum();});
						$('#txtTotal_' + j).focusout(function() {sum();});
						$('#combUcolor_' + j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1 || q_cur==2){
								$('#txtUcolor_'+b_seq).val($('#combUcolor_'+b_seq).find("option:selected").text());
								chgimg(b_seq);
							}
						});
						$('#txtUcolor_' + j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1 || q_cur==2){
								chgimg(b_seq);
							}
						});
						
						$('#txtSize_' + j).change(function() {
							 if ($(this).val().substr(0, 1) != '#' && $(this).val().length>0)
                        		$(this).val('#' + $(this).val());
						});
						
						$('#combSpec_' + j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1 || q_cur==2){
								$('#txtSpec_'+b_seq).val($('#combSpec_'+b_seq).find("option:selected").text());
								chgimg(b_seq);
							}
						});
						$('#txtSpec_' + j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1 || q_cur==2){
								chgimg(b_seq);
							}
						});
						
						$('#combClass_' + j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1 || q_cur==2){
								$('#txtClass_'+b_seq).val($('#combClass_'+b_seq).find("option:selected").val());
								chgimg(b_seq);
							}
						});
						
						$('#txtClass_' + j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1 || q_cur==2){
								chgimg(b_seq);
							}
						});
						
						$('#combProduct_' + j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1 || q_cur==2){
								$('#txtProduct_'+b_seq).val($('#combProduct_'+b_seq).find("option:selected").text());
								//chgcombSpec(b_seq);
								//chgcombUcolor(b_seq);
								//chgcombClass(b_seq);
								//chgimg(b_seq);
							}
						});
						$('#txtProduct_' + j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1 || q_cur==2){
								//chgcombSpec(b_seq);
								//chgcombUcolor(b_seq);
								//chgcombClass(b_seq);
								//chgimg(b_seq);
							}
						});
					}
				}
				_bbsAssign();
				refreshBbm();
				
				$('#lblProductno_s').text('品號');
				$('#lblProduct_s').text('品名');
				$('#lblUcolor_s').text('類別');
				$('#lblStyle_s').text('型');
				$('#lblSpec_s').text('材質');
				$('#lblSize_s').text('號數');
				$('#lblLengthb_s').text('米數');
				$('#lblClass_s').text('廠牌');
				$('#lblImg_s').text('形狀');
				$('#lblUno_s').text('批號');
				$('#lblMount_s').text('數量(件)');
				$('#lblWeight_s').text('重量(KG)');
				
				/*if(q_cur==1 || q_cur==2){
					for (var j = 0; j < q_bbsCount; j++) {
						chgcombSpec(j);
						chgcombUcolor(j);
						chgcombClass(j);
						chgimg(j);
					}
				}*/
			}

			function btnIns() {
				_btnIns();
				$('#chkIsproj').prop('checked', false).attr('disabled', 'disabled');
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
				$('#txtCno').val(z_cno);
				$('#txtAcomp').val(z_acomp);
				$('#txtOdate').val(q_date());
				$('#txtOdate').focus();
				$('#combAddr').text('');
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtOdate').focus();

				if (!emp($('#txtCustno').val())) {
					var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^";
					q_gt('custm', t_where, 0, 0, 0, "");
				}else{
					$('#combAddr').text('');
				}
			}

			function btnPrint() {
                var t_where = "noa='" + $.trim($('#txtNoa').val()) + "'";
               	q_box("z_ordep_vu.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, '', "95%", "95%", q_getMsg('popPrint'));
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				xmlSql = '';
				if (q_cur == 2)
					xmlSql = q_preXml();

				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['productno'] && !as['product'] && !as['spec'] && !dec(as['total'])) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				as['typea'] = abbm2['typea'];
				as['mon'] = abbm2['mon'];
				as['noa'] = abbm2['noa'];
				as['odate'] = abbm2['odate'];

				if (!emp(abbm2['datea']))
					as['datea'] = abbm2['datea'];

				as['custno'] = abbm2['custno'];
				as['comp'] = abbm2['comp'];

				return true;
			}

			function refresh(recno) {
				_refresh(recno);
				$('input[id*="txt"]').click(function() {
					browTicketForm($(this).get(0));
				});
				refreshBbm();
				for (var j = 0; j < q_bbsCount; j++) {
					chgimg(j);
				}
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if (t_para) {
					$('#combAddr').attr('disabled', 'disabled');
					//$('#txtOdate').datepicker( 'destroy' );
				} else {
					$('#combAddr').removeAttr('disabled');
					//$('#txtOdate').datepicker();
				}	
				$('#chkIsproj').attr('disabled', 'disabled');
				refreshBbm();
			}

			function btnMinus(id) {
				_btnMinus(id);
				sum();
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);

			}

			function q_appendData(t_Table) {
				return _q_appendData(t_Table);
			}

			function btnSeek() {
				_btnSeek();
			}

			function btnTop() {
				_btnTop();
			}

			function btnPrev() {
				_btnPrev();
			}

			function btnPrevPage() {
				_btnPrevPage();
			}

			function btnNext() {
				_btnNext();
			}

			function btnNextPage() {
				_btnNextPage();
			}

			function btnBott() {
				_btnBott();
			}

			function q_brwAssign(s1) {
				_q_brwAssign(s1);
			}

			function btnDele() {
				_btnDele();
			}

			function btnCancel() {
				_btnCancel();
			}

			function q_popPost(s1) {
				switch (s1) {
					case 'txtCustno':
						if (!emp($('#txtCustno').val())) {
							var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^";
							q_gt('custm', t_where, 0, 0, 0, "");
						}
						break;
				}
			}
			
			function FormatNumber(n) {
				var xx = "";
				if (n < 0) {
					n = Math.abs(n);
					xx = "-";
				}
				n += "";
				var arr = n.split(".");
				var re = /(\d{1,3})(?=(\d{3})+$)/g;
				return xx + arr[0].replace(re, "$1,") + (arr.length == 2 ? "." + arr[1] : "");
			}
			
			function refreshBbm() {
                if (q_cur == 1 || q_cur==2) {
					if($('#chkAtax').prop('checked'))
						$('#txtTax').css('color', 'green').css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
					else
						$('#txtTax').css('color', 'black').css('background', 'white').removeAttr('readonly');  
                }else{
                	$('#txtTax').css('color', 'green').css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
                }
            }
            
            function q_funcPost(t_func, result) {
				switch(t_func) {
					
				}
			}
		</script>
		<style type="text/css">
			#dmain {
				overflow: hidden;
			}
			.dview {
				float: left;
				width: 30%;
				border-width: 0px;
			}
			.tview {
				width: 100%;
				border: 5px solid gray;
				font-size: medium;
				background-color: black;
			}
			.tview tr {
				height: 30px;
			}
			.tview td {
				padding: 2px;
				text-align: center;
				border-width: 0px;
				background-color: #FFFF66;
				color: blue;
			}
			.dbbm {
				float: left;
				width: 70%;
				border-radius: 5px;
			}
			.tbbm {
				padding: 0px;
				border: 1px white double;
				border-spacing: 0;
				border-collapse: collapse;
				font-size: medium;
				color: blue;
				background: #cad3ff;
				width: 100%;
			}
			.tbbm tr {
				height: 35px;
			}
			.tbbm tr td span {
				float: right;
				display: block;
				width: 5px;
				height: 10px;
			}
			.tbbm tr td .lbl {
				float: right;
				color: blue;
				font-size: medium;
			}
			.tbbm tr td .lbl.btn {
				color: #4297D7;
				font-weight: bolder;
			}
			.tbbm tr td .lbl.btn:hover {
				color: #FF8F19;
			}
			.tbbm td {
				margin: 0 -1px;
				padding: 0;
			}
			.tbbm td input[type="text"] {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				float: left;
			}
			.tbbm td input[type="button"] {
				width: auto;
			}
			.tbbm select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				font-size: medium;
			}
			.dbbs {
				width: 100%;
			}
			.tbbs a {
				font-size: medium;
			}
			.txt.c1 {
				width: 98%;
				float: left;
			}
			.txt.c2 {
				width: 48%;
				float: left;
			}
			.txt.c3 {
				width: 50%;
				float: left;
			}
			.txt.c6 {
				width: 25%;
			}
			.txt.c7 {
				width: 95%;
				float: left;
			}
			.num {
				text-align: right;
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			select {
				font-size: medium;
			}
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id="div_nouno" style="position:absolute; top:70px; left:840px; display:none; width:300px; background-color: #CDFFCE; border: 1px solid gray;">
			<table id="table_nouno" style="width:100%;" border="1" cellpadding='2'  cellspacing='0'>
				<tr>
					<td style="background-color: #f8d463;width: 250px;" align="center">批號</td>
					<td style="background-color: #f8d463;width: 50px;" align="center">領料</td>
				</tr>
				<tr id='nouno_close'>
					<td align="center" colspan='2'><input id="btnClose_div_nouno" type="button" value="取消"></td>
				</tr>
			</table>
		</div>
		<div id='dmain' style="overflow:hidden;">
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:25%"><a id='vewOdate'> </a></td>
						<td align="center" style="width:25%"><a id='vewNoa'> </a></td>
						<td align="center" style="width:40%"><a id='vewComp'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td align="center" id='odate'>~odate</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='custno comp,4'>~custno ~comp,4</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm" id="tbbm">
					<tr style="height: 1px">
						<td style="width: 108px;"> </td>
						<td style="width: 108px;"> </td>
						<td style="width: 108px;"> </td>
						<td style="width: 108px;"> </td>
						<td style="width: 108px;"> </td>
						<td style="width: 108px;"> </td>
						<td style="width: 108px;"> </td>
						<td style="width: 108px;"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblOdate' class="lbl"> </a></td>
						<td><input id="txtOdate" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblStype' class="lbl"> </a></td>
						<td><select id="cmbStype" class="txt c1"> </select></td>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td colspan="2"><input id="txtNoa" type="text" class="txt c1"/></td>
						<!--<td align="center"><input id="btnOrdei" type="button" /></td>-->
					</tr>
					<tr>
						<td><span> </span><a id="lblAcomp" class="lbl btn"> </a></td>
						<td><input id="txtCno" type="text" class="txt c1"/></td>
						<td colspan="2"><input id="txtAcomp" type="text" class="txt c1"/></td>
						<!--<td ><span> </span><a id='lblContract' class="lbl"> </a></td>
						<td colspan="2"><input id="txtContract" type="text" class="txt c1"/></td>-->
						<td><span> </span><a id='lblCustorde' class="lbl"> </a></td>
						<td colspan="2"><input id="txtCustorde" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCust" class="lbl btn"> </a></td>
						<td><input id="txtCustno" type="text" class="txt c1"/></td>
						<td colspan="2">
							<input id="txtComp" type="text" class="txt c1"/>
							<input id="txtNick" type="hidden" class="txt c1"/>
						</td>
						<td><span> </span><a id='lblPaytype' class="lbl"> </a></td>
						<td><input id="txtPaytype" type="text" class="txt c1"/></td>
						<td><select id="combPaytype" class="txt c1" onchange='combPaytype_chg()' > </select></td>
						<!--<td align="center"><input id="btnOrdem" type="button"/></td>-->
						<!--<td align="center"><input id="btnCredit" type="button" value='' /></td>-->
					</tr>
					<tr>
						<td><span> </span><a id='lblTel' class="lbl"> </a></td>
						<td colspan='3'><input id="txtTel" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblFax' class="lbl"> </a></td>
						<td colspan="2"><input id="txtFax" type="text" class="txt c1" /></td>
						<!--<td align="center"><input id="btnQuat" type="button" /></td>-->
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr' class="lbl"> </a></td>
						<td><input id="txtPost" type="text" class="txt c1"/></td>
						<td colspan='5'><input id="txtAddr" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr2' class="lbl"> </a></td>
						<td colspan='3'><input id="txtAddr2" type="text" class="txt c1" /></td>
						<td><select id="combAddr" style="width: 20px" onchange='combAddr_chg()'> </select></td>
						<!--<td><input id="btnAddr2" type="button" value='...' style="width: 30px;height: 21px" /></td>-->
					</tr>
					<tr>
						<td><span> </span><a id='lblTrantype' class="lbl"> </a></td>
						<td colspan="2"><select id="cmbTrantype" class="txt c1" name="D1" > </select></td>
						<td><span> </span><a id="lblSales" class="lbl btn"> </a></td>
						<td colspan="2">
							<input id="txtSalesno" type="text" class="txt c2"/>
							<input id="txtSales" type="text" class="txt c3"/>
						</td>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTranadd' class="lbl"> </a></td>
						<td colspan="2"><input id="txtTranadd" type="text" class="txt num c1"/></td>
						<td><span> </span><a id='lblBenifit' class="lbl"> </a></td>
						<td colspan="2"><input id="txtBenifit" type="text" class="txt num c1"/></td>
						<td><span> </span><a id='lblWeight' class="lbl"> </a></td>
						<td><input id="txtWeight" type="text" class="txt num c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMoney' class="lbl"> </a></td>
						<td colspan='2'>
							<input id="txtMoney" type="text" class="txt c1" style="text-align: center;"/>
						</td>
						<td><span> </span><a id='lblTax' class="lbl"> </a></td>
						<td><input id="txtTax" type="text" class="txt num c1"/></td>
						<td>
							<input id="chkAtax" type="checkbox" onchange='sum()' />
							<!--<select id="cmbTaxtype" class="txt c1" onchange='sum()' > </select>-->
						</td>
						<td><span> </span><a id='lblTotal' class="lbl"> </a></td>
						<td><input id="txtTotal" type="text" class="txt num c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td colspan='2'><input id="txtWorker" type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td colspan='2'><input id="txtWorker2" type="text" class="txt c1" /></td>
						<td colspan="2">
							<input id="chkIsproj" type="checkbox"/>
							<span> </span><a id='lblIsproj'> </a>
							<input id="chkEnda" type="checkbox"/>
							<span> </span><a id='lblEnda'> </a>
							<input id="chkCancel" type="checkbox"/>
							<span> </span><a id='lblCancel'> </a>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class='lbl'> </a></td>
						<td colspan='7'><textarea id="txtMemo" cols="10" rows="5" style="width: 99%;height: 50px;"> </textarea></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' style="width: 1380px;"><!--2000px-->
			<table id="tbbs" class='tbbs' border="1" cellpadding='2' cellspacing='1'>
				<tr style='color:White; background:#003366;' >
					<td align="center" style="width:45px;"><input class="btn" id="btnPlus" type="button" value='＋' style="font-weight: bold;" /></td>
					<td align="center" style="width:60px;"><a id='lblNo2'> </a></td>
					<!--<td align="center" style="width:150px;"><a id='lblProductno_s'> </a></td>-->
					<td align="center" style="width:110px;"><a id='lblProduct_s'> </a></td>
					<td align="center" style="width:140px;"><a id='lblUcolor_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblSpec_s'> </a></td>
					<td align="center" style="width:70px;"><a id='lblSize_s'> </a></td>
					<td align="center" style="width:70px;"><a id='lblLengthb_s'> </a></td>
					<td align="center" style="width:90px;"><a id='lblClass_s'> </a></td>
					<td align="center" style="width:200px;display: none;" class="img"><a id='lblImg_s'> </a></td>
					<!--<td align="center" style="width:55px;"><a id='lblUnit'> </a></td>-->
					<td align="center" style="width:60px;"><a id='lblMount_s'> </a></td>
					<td align="center" style="width:85px;"><a id='lblWeight_s'> </a></td>
					<td align="center" style="width:85px;"><a id='lblPrices'> </a></td>
					<td align="center" style="width:100px;"><a id='lblTotals'> </a></td>
					<td align="center" style="width:85px;"><a id='lblGemounts'> </a></td>
					<td align="center" style="width:180px;"><a id='lblMemo_s'> </a></td>
					<!--<td align="center" style="width: 180px;"><a id='lblUno_s'> </a></td>-->
					<td align="center" style="width:90px;display: none;"><a id='lblDateas'> </a></td>
					<td align="center" style="width:30px;"><a id='lblEndas'> </a></td>
					<td align="center" style="width:30px;"><a id='lblCancels'> </a></td>
					<!--<td align="center" style="width:30px;"><a id='lblNouno_s'>領料</a></td>-->
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center"><input class="btn" id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
					<td><input id="txtNo2.*" type="text" class="txt c1"/></td>
					<!--<td>
						<input id="txtProductno.*" type="text" class="txt c1" style="width: 83%;"/>
						<input class="btn" id="btnProductno.*" type="button" value='.' style="font-weight: bold;" />
					</td>-->
					<td>
						<input id="txtProduct.*" type="text" class="txt c1" style="width: 70%;"/>
						<select id="combProduct.*" class="txt" style="width: 20px;"> </select>
					</td>
					<td>
						<input id="txtUcolor.*" type="text" class="txt c1" style="width: 110px;"/>
						<select id="combUcolor.*" class="txt" style="width: 20px;"> </select>
					</td>
					<td>
						<input id="txtSpec.*" type="text" class="txt c1" style="width: 70%;"/>
						<select id="combSpec.*" class="txt" style="width: 20px;"> </select>
					</td>
					<td><input id="txtSize.*" type="text" class="txt c1" /></td>
					<td><input id="txtLengthb.*" type="text" class="txt num c1" /></td>
					<td>
						<input id="txtClass.*" type="text" class="txt c1" style="width: 70%;"/>
						<select id="combClass.*" class="txt" style="width: 20px;"> </select>
					</td>
					<td align="center" class="img" style="display: none;">
						<canvas id="canvas.*" width="150" height="50"> </canvas>
						<img id="imgPic.*" src="" style="display:none;"/>
					</td>
					<!--<td><input id="txtUnit.*" type="text" class="txt c1"/></td>-->
					<td><input id="txtMount.*" type="text" class="txt num c1"/></td>
					<td><input id="txtWeight.*" type="text" class="txt num c1"/></td>
					<td><input id="txtPrice.*" type="text" class="txt num c1"/></td>
					<td><input id="txtTotal.*" type="text" class="txt num c1"/></td>
					<td>
						<input id="txtC1.*" type="text" class="txt num c1"/>
						<!--<input id="txtNotv.*" type="text" class="txt num c1"/>-->
					</td>
					<td>
						<input class="txt c7" id="txtMemo.*" type="text" />
						<!--<input class="txt" id="txtQuatno.*" type="text" style="width: 70%;" />
						<input class="txt" id="txtNo3.*" type="text" style="width: 20%;"/>-->
					</td>
					<!--<td><input id="txtUno.*" type="text" class="txt c1"/></td>-->
					<td style="display: none;"><input id="txtDatea.*" type="text" class="txt c1"/></td>
					<td align="center"><input id="chkEnda.*" type="checkbox"/></td>
					<td align="center"><input id="chkCancel.*" type="checkbox"/></td>
					<!--<td align="center"><input id="btnCub_nouno.*" type="button" value="."/></td>-->
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>