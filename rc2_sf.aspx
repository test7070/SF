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
		<script type="text/javascript">
			this.errorHandler = null;
			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}

			q_tables = 's';
			var q_name = "rc2";
			var q_readonly = ['txtNoa', 'txtAcomp', 'txtTgg', 'txtWorker', 'txtWorker2','txtMoney','txtTotal','txtOrdeno'];
			var q_readonlys = ['txtNoq','txtOrdeno','txtNo2','txtStore'];
			var bbmNum = [];
			var bbsNum = [];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwCount2 = 16;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'datea';
			aPop = new Array(
				['txtTggno', 'lblTgg', 'tgg', 'noa,nick,tel,zip_home,addr_home,paytype', 'txtTggno,txtTgg,txtTel,txtPost,txtAddr,txtPaytype', 'tgg_b.aspx'],
				['txtStoreno_', 'btnStoreno_', 'store', 'noa,store', 'txtStoreno_,txtStore_', 'store_b.aspx'],
				//['txtPost', 'lblAddr', 'addr', 'post,addr', 'txtPost,txtAddr', 'addr_b.aspx'],
				//['txtPost2', 'lblAddr2', 'addr', 'post,addr', 'txtPost2,txtAddr2', 'addr_b.aspx'],
				['txtPost', 'lblAddr', 'addr2', 'noa,post', 'txtPost,txtAddr', 'addr2_b.aspx'],
				['txtPost2', 'lblAddr2', 'cust', 'noa,comp', 'txtPost2,txtAddr2', 'cust_b.aspx'],
				['txtCardealno', 'lblCardeal', 'cardeal', 'noa,comp', 'txtCardealno,txtCardeal', 'cardeal_b.aspx'],
				['txtCarno', 'lblCarno', 'cardeals', 'a.carno,a.noa,a.comp', '0txtCarno,txtCardealno,txtCardeal', 'cardeals_b.aspx'],
				['txtCno', 'lblAcomp', 'acomp', 'noa,acomp,addr', 'txtCno,txtAcomp,txtAddr2', 'acomp_b.aspx']
				//['txtProductno_', 'btnProductno_', 'ucaucc', 'noa,product,unit,spec', 'txtProductno_,txtProduct_,txtUnit_,txtSpec_,txtUcolor_', 'ucaucc_b.aspx'],
				//['txtCarno', 'lblCar', 'cardeal', 'noa', '0txtCarno', 'cardeal_b.aspx']
			);

			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_brwCount();
				
				if(window.parent.q_name=='rc2'){
					if(q_content.length>0)
						q_content="where=^^ isnull(part2,'')='' and "+q_content.substr(q_content.indexOf('^^')+2);
					else
						q_content = "where=^^isnull(part2,'')='' ^^";
				}
				
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
				q_gt('acomp', 'stop=1 ', 0, 0, 0, "cno_acomp");
				q_gt('spec', '1=1 ', 0, 0, 0, "bbsspec");
				q_gt('color', '1=1 ', 0, 0, 0, "bbscolor");
				q_gt('class', '1=1 ', 0, 0, 0, "bbsclass");
				q_gt('adpro', '1=1 ', 0, 0, 0, "bbspro");
				q_gt('img', "where=^^ noa like 'Z%' ^^ ", 0, 0, 0, "bbsimg");
				q_gt('mech', "where=^^mech='辦公室'^^", 0, 0, 0, "");
			});

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(1);
			}

			function sum() {
				var t1 = 0, t_unit, t_mount, t_weight = 0,t_money=0, t_tax = 0, t_total = 0;
				for (var j = 0; j < q_bbsCount; j++) {
					t_weight = q_add(t_weight,dec($('#txtWeight_' + j).val()));
					t_money = q_add(t_money, dec(q_float('txtTotal_' + j)));
				}
				if($('#chkAtax').prop('checked')){
					var t_taxrate = q_div(parseFloat(q_getPara('sys.taxrate')), 100);
					t_tax = round(q_mul(t_money, t_taxrate), 0);
					t_total = q_add(t_money, t_tax);
				}else{
					t_tax = q_float('txtTax');
					t_total = q_add(t_money, t_tax);
				}
				//$('#txtTranmoney').val(q_mul(dec($('#txtWeight').val()), dec($('#txtPrice').val())));
				$('#textQweight1').val(FormatNumber(t_weight));
				$('#txtMoney').val(FormatNumber(t_money));
				$('#txtTax').val(FormatNumber(t_tax));
				$('#txtTotal').val(FormatNumber(t_total));
				bbssum();
			}
			
			var t_cont1='#non',t_cont2='#non';
			function mainPost() {
				q_getFormat();
				bbmMask = [['txtDatea', r_picd], ['txtMon', r_picm]];
				q_mask(bbmMask);
				bbmNum = [['txtMoney', 15, 0, 1], ['txtTax', 10, 0, 1], ['txtTotal', 15, 0, 1], ['txtTotal', 15, 3, 1],['txtTranmoney', 11, 0, 1]
								,['txtTranadd', 15, q_getPara('rc2.weightPrecision'), 1],['txtBenifit', 15, q_getPara('rc2.weightPrecision'), 1],['txtWeight', 15, q_getPara('rc2.weightPrecision'), 1]
								,['textQweight1', 15, q_getPara('rc2.weightPrecision'), 1],['textQweight2', 15, q_getPara('rc2.weightPrecision'), 1]];
				bbsNum = [['txtMount', 15, q_getPara('rc2.mountPrecision'), 1],['txtWeight', 15, q_getPara('rc2.weightPrecision'), 1], ['txtPrice', 15, q_getPara('rc2.pricePrecision'), 1]
								, ['txtTotal', 15, 0, 1], ['txtLengthb', 15, 2, 1], ['txtLengthc', 15, 2, 1]];
				
				//q_cmbParse("cmbTranstyle", q_getPara('sys.transtyle'));
				q_cmbParse("cmbTypea", q_getPara('rc2.typea'));
				q_cmbParse("cmbStype", q_getPara('rc2.stype'));
				q_cmbParse("combPaytype", q_getPara('rc2.paytype'));
				q_cmbParse("cmbTrantype", q_getPara('sys.tran'));//2017/07/10 進貨沒有運費方式 交運一律還是照舊
				//q_cmbParse("cmbTrantype", ',收費,含運,自運'); //106/07/07
				//q_cmbParse("combUcolor", q_getPara('rc2s_sf.typea'),'s');
				//q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));
				//q_cmbParse("combProduct", q_getPara('rc2s_sf.product'),'s');
				
				var t_where = "where=^^ 1=1 ^^";
				q_gt('ucc', t_where, 0, 0, 0, "");
				//q_gt('custaddr', t_where, 0, 0, 0, "");
				
				$('#lblOrdc').text('合約號碼');
				$('#lblTranadd').text('車空重');
				$('#lblBenifit').text('車總重');
				$('#lblWeight').text('淨重');
				$('#lblPrice').text('運費單價');
				
				$('#btnUnoprint').click(function() {
					if(!emp($('#txtNoa').val()) && q_cur!=1  && q_cur!=2){
						var t_seq='';
						$('.isPrint:checked').each(function(index) {
							var n=$(this).attr('id').split('_')[1];
							t_seq=t_seq + (t_seq.length>0?'^':'')+$('#txtNoq_'+n).val();	
						});
						if(t_seq.length==0){
							alert('請選擇要列印的標籤!!');
						}else if (emp($('#combMechno').val())){
							alert('請選擇列印機台!!');
						}else{
							q_func( 'barvu.genBar','rc2,'+$('#txtNoa').val()+','+$('#combMechno').val()+','+t_seq)
						}
					}
				});
				
				$('#txtTranadd').change(function() {
					q_tr('txtWeight',q_sub(q_float('txtBenifit'),q_float('txtTranadd')));
					$('#txtWeight').change();
				});
				$('#txtBenifit').change(function() {
					q_tr('txtWeight',q_sub(q_float('txtBenifit'),q_float('txtTranadd')));
					$('#txtWeight').change();
				});
				
				$('#txtWeight').change(function() {
					//105/12/07 增加 //106/06/08 功能取消 107/01/10 重新開放
					var t_weight=dec($('#txtWeight').val());
					if(t_weight!=0){
						for (var i = 0; i < q_bbsCount; i++) {
							if(!emp($('#txtProduct_'+i).val())){
								t_weight=q_sub(t_weight,dec($('#txtWeight_'+i).val()));
							}
						}
					}
					if(t_weight!=0){
						var t_n=-1;
						for (var i = 0; i < q_bbsCount; i++) {
							if(emp($('#txtProduct_'+i).val())){
								t_n=i;
								break;
							}
						}
						if(t_n==-1){
							t_n=q_bbsCount;
							$('#btnPlus').click();
						}
						$('#txtWeight_'+t_n).val(t_weight);
					}else{
						for (var i = 0; i < q_bbsCount; i++) {
							if(emp($('#txtProduct_'+i).val())){
								t_n=i;
								$('#txtWeight_'+t_n).val(0);
								break;
							}
						}
					}
					$('#txtTranmoney').val(round(q_mul(dec($('#txtPrice').val()),dec($('#txtWeight').val())),0));
				});
				
				//限制帳款月份的輸入 只有在備註的第一個字為*才能手動輸入					
				$('#txtMemo').change(function(){
					if ($('#txtMemo').val().substr(0,1)=='*')
						$('#txtMon').removeAttr('readonly');
					else
						$('#txtMon').attr('readonly', 'readonly');
				});
				
				$('#txtMon').click(function(){
					if ($('#txtMon').attr("readonly")=="readonly" && (q_cur==1 || q_cur==2))
						q_msg($('#txtMon'), "月份要另外設定，請在"+q_getMsg('lblMemo')+"的第一個字打'*'字");
				});
				
				$('#chkAtax').click(function() {
					refreshBbm();
					sum();
				});
				
				$('#txtTax').change(function() {
					sum();
				});
				
				$('#lblAccc').click(function() {
					q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + $('#txtDatea').val().substring(0, 3) + '_' + r_cno, 'accc', 'accc3', 'accc2', "92%", "1054px", q_getMsg('lblAccc'), true);
				});
				
				$('#lblOrdc').click(function() {
					//105/11/08 互換合約再另外作業處理 維持抓cont
					var t_where = '';
					t_contno = $('#txtOrdcno').val();
					if (t_invo.length > 0) {
						t_where = "noa='" +t_contno + "'";
						q_box("contst_vu.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'contst', "95%", "95%", '進貨合約');
						//q_box("contst_sf.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'contst', "95%", "95%", '進貨合約');
					}
				});
				
				$('#lblInvono').click(function() {
					t_where = '';
					t_invo = $('#txtInvono').val();
					if (t_invo.length > 0) {
						t_where = "noa='" + t_invo + "'";
						q_box("rc2a.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'rc2a', "95%", "95%", q_getMsg('popRc2a'));
					}
				});
								
				$('#txtTotal').change(function() {
					sum();
				});
				
				$('#txtTggno').change(function() {
					if (!emp($('#txtTggno').val())) {
						var t_where = "where=^^ noa='" + $('#txtTggno').val() + "'^^ stop=100";
						q_gt('custaddr', t_where, 0, 0, 0, "");
					}
				});

				$('#txtAddr').change(function() {
					var t_tggno = trim($(this).val());
					if (!emp(t_tggno)) {
						focus_addr = $(this).attr('id');
						zip_fact = $('#txtPost').attr('id');
						var t_where = "where=^^ noa='" + t_tggno + "' ^^";
						q_gt('tgg', t_where, 0, 0, 0, "");
					}
				});
				
				$('#txtAddr2').change(function() {
					var t_custno = trim($(this).val());
					if (!emp(t_custno)) {
						focus_addr = $(this).attr('id');
						zip_fact = $('#txtPost2').attr('id');
						var t_where = "where=^^ noa='" + t_custno + "' ^^";
						q_gt('cust', t_where, 0, 0, 0, "");
					}
				});
				
				$('#txtCardealno').change(function() {
					//取得車號下拉式選單
					var thisVal = $(this).val();
					var t_where = "where=^^ noa=N'" + thisVal + "' ^^";
					q_gt('cardeal', t_where, 0, 0, 0, "getCardealCarno");
				});
					
				$('#txtPrice').change(function(){
					$('#txtTranmoney').val(round(q_mul(dec($('#txtPrice').val()),dec($('#txtWeight').val())),0))
					sum();
				});
				
				$('#lblQno1').click(function() {
					//105/11/08 互換合約再另外作業處理 維持抓cont
					/*var t_where1="tggno='"+$('#txtTggno').val()+"' and eweight>0 and isnull(enda,0)=0";//cont
					var t_where2="where[1]=^^tggno='"+$('#txtTggno').val()+"' and f4>0 and isnull(enda,0)=0";//ordhs
					var t_where3="where[2]=^^1=0^^";//quat
					var t_where4="where[3]=^^1=0 order by datea,noa ^^";//ordbht
					
					if(q_cur==1 || q_cur==2){
						t_where1=t_where1+" and noa!='"+$('#textQno2').val()+"'";
						t_where2=t_where2+" and noa!='"+$('#textQno2').val()+"'";
					}
					
					t_where1=t_where1+" ^^";
					t_where2=t_where2+" ^^";
					
					q_box("cont_sf_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where1+t_where2+t_where3+t_where4, 'cont1_b', "600px", "700px", '進貨合約');*/
					
					var t_where="tggno='"+$('#txtTggno').val()+"' and eweight>0 and isnull(enda,0)=0 ";
					if(q_cur==1 || q_cur==2)
						t_where=t_where+" and noa!='"+$('#textQno2').val()+"'";
					q_box("contst_vu_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'cont1_b', "600px", "700px", '進貨合約');
				});
				
				$('#textQno1').change(function() {
					//105/11/08 互換合約再另外作業處理 維持抓cont
					/*if(!emp($('#textQno1').val())){
						var t_where1="where=^^noa='"+$('#textQno1').val()+"'^^ ";
						var t_where2="where[1]=^^noa='"+$('#textQno1').val()+"'^^ ";
						var t_where3="where[2]=^^1=0^^ ";
						var t_where4="where[3]=^^=1=0^^ ";
						
						q_gt('cont_sf', t_where1t_where2+t_where3+t_where4, 0, 0, 0, "qno1_chage", r_accy);
					}*/
					if(!emp($('#textQno1').val())){
						var t_where="where=^^noa='"+$('#textQno1').val()+"'^^ ";
						q_gt('cont', t_where, 0, 0, 0, "qno1_chage", r_accy);
					}
				});
				
				$('#lblQno2').click(function() {
					//105/11/08 互換合約再另外作業處理 維持抓cont
					/*var t_where1="tggno='"+$('#txtTggno').val()+"' and eweight>0 and isnull(enda,0)=0";//cont
					var t_where2="where[1]=^^tggno='"+$('#txtTggno').val()+"' and f4>0 and isnull(enda,0)=0";//ordhs
					var t_where3="where[2]=^^1=0^^";//quat
					var t_where4="where[3]=^^1=0 order by datea,noa ^^";//ordbht
					
					if(q_cur==1 || q_cur==2){
						t_where1=t_where1+" and noa!='"+$('#textQno1').val()+"'";
						t_where2=t_where2+" and noa!='"+$('#textQno1').val()+"'";
					}
					
					t_where1=t_where1+" ^^";
					t_where2=t_where2+" ^^";
					
					q_box("cont_sf_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where1+t_where2+t_where3+t_where4, 'cont2_b', "600px", "700px", '進貨合約');*/
					var t_where="tggno='"+$('#txtTggno').val()+"' and eweight>0 and isnull(enda,0)=0 ";
					if(q_cur==1 || q_cur==2)
						t_where=t_where+" and noa!='"+$('#textQno1').val()+"'";
					q_box("contst_vu_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'cont2_b', "600px", "700px",  '進貨合約');
				});
				
				$('#textQno2').change(function() {
					//105/11/08 互換合約再另外作業處理 維持抓cont
					/*if(!emp($('#textQno2').val())){
						var t_where1="where=^^noa='"+$('#textQno2').val()+"'^^ ";
						var t_where2="where[1]=^^noa='"+$('#textQno2').val()+"'^^ ";
						var t_where3="where[2]=^^1=0^^ ";
						var t_where4="where[3]=^^=1=0^^ ";
						
						q_gt('cont_sf', t_where1t_where2+t_where3+t_where4, 0, 0, 0, "qno2_chage", r_accy);
					}*/
					if(!emp($('#textQno2').val())){
						var t_where="where=^^noa='"+$('#textQno2').val()+"'^^ ";
						q_gt('cont', t_where, 0, 0, 0, "qno2_chage", r_accy);
					}
				});
				
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
                
                if (q_cur == 1) {
                    $('#txtNoa').css('color', 'black').css('background', 'white').removeAttr('readonly');
                } else {
                    $('#txtNoa').css('color', 'green').css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
                }
            }
            
            function HiddenTreat(){
				var t_quat=$('#txtTranstart').val().split('##');
				if(t_quat[0]!=undefined){
					var r_quat=t_quat[0].split('@');
					if(r_quat[0]!=undefined)
						$('#textQno1').val(r_quat[0]);
					else
						$('#textQno1').val('');
					if(r_quat[1]!=undefined){
						$('#textQweight1').val(r_quat[1]);
					}else{
						$('#textQweight1').val(0);
					}
				}
				if(t_quat[1]!=undefined){
					var r_quat=t_quat[1].split('@');
					if(r_quat[0]!=undefined)
						$('#textQno2').val(r_quat[0]);
					else
						$('#textQno2').val('');
					if(r_quat[1]!=undefined){
						$('#textQweight2').val(r_quat[1]);
					}else{
						$('#textQweight2').val(0);
					}
				}
			}

			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case 'cont1_b':
						if (q_cur > 0 && q_cur < 4) {
							b_ret = getb_ret();
							if (!b_ret || b_ret.length == 0 || b_ret[0]==undefined)
								return;
							$('#textQno1').val(b_ret[0].noa);
							if(b_ret[0].atax=="true"){
								$('#chkAtax').prop('checked',true);
							}else{
								$('#chkAtax').prop('checked',false);	
							}
							refreshBbm();
							sum();
						}
						break;
					case 'cont2_b':
						if (q_cur > 0 && q_cur < 4) {
							b_ret = getb_ret();
							if (!b_ret || b_ret.length == 0 || b_ret[0]==undefined)
								break;
							$('#textQno2').val(b_ret[0].noa);
							if(b_ret[0].atax=="true"){
								$('#chkAtax').prop('checked',true);
							}else{
								$('#chkAtax').prop('checked',false);	
							}
							refreshBbm();
							sum();
						}
						break;
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}

			var focus_addr = '', zip_fact = '';
			var z_cno = r_cno, z_acomp = r_comp, z_nick = r_comp.substr(0, 2);
			var carnoList = [];
			var thisCarSpecno = '';
			var ordcoverrate = [],rc2soverrate = [];
			var a_spec='@',a_color='@',a_pro='@',a_class='@'; //106/01/04 續接器 類別 材質改抓續接參數 廠牌 =直彎
			var a_img=[],a_class2='@';//106/01/06改抓img編號名稱
			var tmpucc=[];
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'ucc':
						var as = _q_appendData("ucc", "", true);
						tmpucc=$.extend(true,[], as);
						var t_ucc='@';
						for ( i = 0; i < as.length; i++) {
							t_ucc+=","+as[i].product;
						}
						q_cmbParse("combProduct", t_ucc,'s');
						break;
					case 'bbsspec':
						var as = _q_appendData("spec", "", true);
						var t_spec='@';
						for ( i = 0; i < as.length; i++) {
							t_spec+=","+as[i].noa;
							a_spec+=","+as[i].noa;
						}
						q_cmbParse("combSpec", t_spec,'s');
						break;
					case 'bbscolor':
						var as = _q_appendData("color", "", true);
						var t_color='@';
						for ( i = 0; i < as.length; i++) {
							t_color+=","+as[i].color;
							a_color+=","+as[i].color;
						}
						q_cmbParse("combUcolor", t_color,'s');
						break;
					case 'bbsclass':
						var as = _q_appendData("class", "", true);
						var t_class='@';
						for ( i = 0; i < as.length; i++) {
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
						break;
					case 'mech':
						var as = _q_appendData("mech", "", true);
						t_mech='@';
						for (var i = 0; i < as.length; i++) {
							t_mech=as[i].noa+"@"+as[i].mech;
						}
						$('#combMechno').text();
						q_cmbParse("combMechno", t_mech);
						break;
					case 'getCardealCarno' :
						var as = _q_appendData("cardeals", "", true);
						carnoList = as;
						var t_item = " @ ";
						if (as[0] != undefined) {
							for ( i = 0; i < as.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].carno + '@' + as[i].carno;
							}
						}
						for(var k=0;k<carnoList.length;k++){
							if(carnoList[k].carno==$('#txtCarno').val()){
								thisCarSpecno = carnoList[k].carspecno;
								break;
							}
						}
						document.all.combCarno.options.length = 0;
						q_cmbParse("combCarno", t_item);
						$('#combCarno').unbind('change').change(function(){
							if (q_cur == 1 || q_cur == 2) {
								$('#txtCarno').val($('#combCarno').find("option:selected").text());
							}
							for(var k=0;k<carnoList.length;k++){
								if(carnoList[k].carno==$('#txtCarno').val()){
									thisCarSpecno = carnoList[k].carspecno;
									break;
								}
							}
						});
						break;
					case 'cno_acomp':
						var as = _q_appendData("acomp", "", true);
						if (as[0] != undefined) {
							z_cno = as[0].noa;
							z_acomp = as[0].acomp;
							z_nick = as[0].nick;
						}
						break;
					case 'custaddr':
						var as = _q_appendData("custaddr", "", true);
						var t_item = " @ ";
						if (as[0] != undefined) {
							for ( i = 0; i < as.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].post + '@' + as[i].addr;
							}
						}
						document.all.combAddr.options.length = 0;
						q_cmbParse("combAddr", t_item);
						break;
					case 'tgg':
						var as = _q_appendData("tgg", "", true);
						if (as[0] != undefined && focus_addr != '') {
							$('#' + zip_fact).val(as[0].zip_fact);
							$('#' + focus_addr).val(as[0].addr_fact);
							zip_fact = '';
							focus_addr = '';
						}
						break;
					case 'cust':
						var as = _q_appendData("cust", "", true);
						if (as[0] != undefined && focus_addr != '') {
							$('#' + zip_fact).val(as[0].noa);
							$('#' + focus_addr).val(as[0].comp);
							zip_fact = '';
							focus_addr = '';
						}
						break;
					case 'btnDele':
						var as = _q_appendData("pays", "", true);
						if (as[0] != undefined) {
							var t_msg = "", t_paysale = 0;
							for (var i = 0; i < as.length; i++) {
								t_paysale = parseFloat(as[i].paysale.length == 0 ? "0" : as[i].paysale);
								if (t_paysale != 0)
									t_msg += String.fromCharCode(13) + '付款單號【' + as[i].noa + '】 ' + FormatNumber(t_paysale);
							}
							if (t_msg.length > 0) {
								alert('已沖帳:' + t_msg);
								Unlock(1);
								return;
							}
						}
						_btnDele();
						Unlock(1);
						break;
					case 'btnModi':
						var as = _q_appendData("pays", "", true);
						if (as[0] != undefined) {
							var t_msg = "", t_paysale = 0;
							for (var i = 0; i < as.length; i++) {
								t_paysale = parseFloat(as[i].paysale.length == 0 ? "0" : as[i].paysale);
								if (t_paysale != 0)
									t_msg += String.fromCharCode(13) + '付款單號【' + as[i].noa + '】 ' + FormatNumber(t_paysale);
							}
							if (t_msg.length > 0) {
								alert('已沖帳:' + t_msg);
								Unlock(1);
								return;
							}
						}
						_btnModi();
						Unlock(1);
						$('#txtDatea').focus();
						if (!emp($('#txtTggno').val())) {
							var t_where = "where=^^ noa='" + $('#txtTggno').val() + "' ^^ stop=100";
							q_gt('custaddr', t_where, 0, 0, 0, "");
						}
						break;
					/*case 'ordc':
						var ordc = _q_appendData("ordc", "", true);
						if (ordc[0] != undefined) {
							$('#combPaytype').val(ordc[0].paytype);
							$('#txtPaytype').val(ordc[0].pay);
							$('#cmbTrantype').val(ordc[0].trantype);
							$('#txtPost2').val(ordc[0].post2);
							$('#txtAddr2').val(ordc[0].addr2);
						}
						break;*/
					case 'checkRc2no_btnOk':
						var as = _q_appendData("view_rc2", "", true);
                        if (as[0] != undefined) {
                            alert('進貨單號已存在!!!');
                        } else {
                            wrServer($('#txtNoa').val());
                        }
						break;
					case 'qno1_chage':
						var as = _q_appendData("cont", "", true);
						if (as[0] != undefined) {
							if((as[0].enda)=="true" && $('#cmbTypea').val()!='2'){
								alert($('#textQno1').val()+'合約已結案!');
							}else if(dec(as[0].eweight)<=0  && $('#cmbTypea').val()!='2'){
								alert($('#textQno1').val()+'合約已進貨完畢!');
							}else if(!emp($('#txtTggno').val()) && $('#txtTggno').val()!=as[0].tggno){
								alert('合約廠商與進貨廠商不同!!');
							}else{
								if(as[0].atax=="true"){
									$('#chkAtax').prop('checked',true);
								}else{
									$('#chkAtax').prop('checked',false);	
								}
								refreshBbm();
								sum();
							}
						}else{
							alert($('#textQno1').val()+'合約不存在!!!');
						}
						break;
					case 'qno2_chage':
						var as = _q_appendData("cont", "", true);
						if (as[0] != undefined) {
							if((as[0].enda)=="true" && $('#cmbTypea').val()!='2'){
								alert($('#textQno2').val()+'合約已結案!');
							}else if(dec(as[0].eweight)<=0  && $('#cmbTypea').val()!='2'){
								alert($('#textQno2').val()+'合約已進貨完畢!');
							}else if(!emp($('#txtTggno').val()) && $('#txtTggno').val()!=as[0].tggno){
								alert('合約廠商與進貨廠商不同!!');
							}else{
								if(as[0].atax=="true"){
									$('#chkAtax').prop('checked',true);
								}else{
									$('#chkAtax').prop('checked',false);	
								}
								refreshBbm();
								sum();
							}
						}else{
							alert($('#textQno2').val()+'合約不存在!!!');
						}
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
			}

			function q_stPost() {
				//105/11/08 互換合約再另外作業處理 維持抓cont
				t_cont1=t_cont1.length==0?'#non':t_cont1;
				t_cont2=t_cont2.length==0?'#non':t_cont2;
				if(q_cur==3){
					if(t_cont1 != '#non' || t_cont2 != '#non'){
						//q_func('qtxt.query.changecontgweight', 'rc2.txt,changecont_sf,' + encodeURI(r_accy) + ';' + encodeURI($('#txtNoa').val())+ ';' + encodeURI(t_cont1)+ ';' + encodeURI(t_cont2));
						q_func('qtxt.query.changecontgweight', 'rc2.txt,changecont_vu,' + encodeURI(r_accy) + ';' + encodeURI($('#txtNoa').val())+ ';' + encodeURI(t_cont1)+ ';' + encodeURI(t_cont2));
					}
					t_cont1='#non',t_cont2='#non';
				}
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				var s1 = xmlString.split(';');
				abbm[q_recno]['accno'] = s1[0];
				$('#txtAccno').val(s1[0]);
				if((!emp($('#textQno1').val()) || !emp($('#textQno2').val()) || t_cont1 != '#non' || t_cont2 != '#non' )){
					//q_func('qtxt.query.changecontgweight', 'rc2.txt,changecont_sf,' + encodeURI(r_accy) + ';' + encodeURI($('#txtNoa').val())+ ';' + encodeURI(t_cont1)+ ';' + encodeURI(t_cont2));
					q_func('qtxt.query.changecontgweight', 'rc2.txt,changecont_vu,' + encodeURI(r_accy) + ';' + encodeURI($('#txtNoa').val())+ ';' + encodeURI(t_cont1)+ ';' + encodeURI(t_cont2));
				}
				t_cont1='#non',t_cont2='#non';
			}
			
			var check_uno=false,check_uno_count=0,check_uno_err='';
			var getnewuno=false;
			function btnOk() {
				var t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')],['txtDatea', q_getMsg('lblDatea')], ['txtTggno', q_getMsg('lblTgg')], ['txtCno', q_getMsg('lblAcomp')]]);
				// 檢查空白
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				
				if((!emp($('#textQno1').val()) || !emp($('#textQno2').val())) && dec($('#txtWeight').val())!=q_add(dec($('#textQweight1').val()),dec($('#textQweight2').val()))){
					alert('合約重量'+FormatNumber(q_add(dec($('#textQweight1').val()),dec($('#textQweight2').val())))+'不等於進貨淨重'+FormatNumber(dec($('#txtWeight').val()))+'!!');
					return;
				}
				
				if((!emp($('#textQno1').val()) && !emp($('#textQno2').val())) && $('#textQno1').val()==$('#textQno2').val() ){
					alert('合約1號碼與合約2號碼相同!!');
					return;
				}
				
				var t_zero=false;
				for (var i = 0; i < q_bbsCount; i++) {
					if(dec($('#txtMount_'+i).val())==0 && dec($('#txtWeight_'+i).val())==0 && !emp($('#txtProduct_'+i).val())){
						t_zero=true;
					}
				}
				
				if(t_zero){
					if (confirm('進貨品項【件數】和【重量】為0將會清空，是否繼續?')){
						for (var i = 0; i < q_bbsCount; i++) {
							if(dec($('#txtMount_'+i).val())==0 && dec($('#txtWeight_'+i).val())==0 && !emp($('#txtProduct_'+i).val())){
								$('#btnMinus_'+i).click();
							}
						}
					}else{
						return;
					}
				}
				
				//判斷起算日,寫入帳款月份
				//104/09/30 如果備註沒有*字就重算帳款月份
				//if( emp($('#txtMon').val())){
				if($('#txtMemo').val().substr(0,1)!='*'){	
					var t_where = "where=^^ noa='"+$('#txtTggno').val()+"' ^^";
					q_gt('tgg', t_where, 0, 0, 0, "startdate", r_accy,1);
					var as = _q_appendData('tgg', '', true);
					var t_startdate='';
					if (as[0] != undefined) {
						t_startdate=as[0].startdate;
					}
					if(t_startdate.length==0 || ('00'+t_startdate).slice(-2)=='00' || $('#txtDatea').val().substr(r_lenm+1, 2)<('00'+t_startdate).substr(-2)){
						$('#txtMon').val($('#txtDatea').val().substr(0, r_lenm));
					}else{
						var t_date=$('#txtDatea').val();
						var nextdate='';
						if(r_len==4)
							nextdate=new Date(dec(t_date.substr(0,4)),dec(t_date.substr(5,2))-1,1);
						else
							nextdate=new Date(dec(t_date.substr(0,3))+1911,dec(t_date.substr(4,2))-1,1);
				    	nextdate.setMonth(nextdate.getMonth() +1)
				    	if(r_len==4)
				    		t_date=''+(nextdate.getFullYear())+'/'+(nextdate.getMonth()<9?'0':'')+(nextdate.getMonth()+1);
				    	else
				    		t_date=''+(nextdate.getFullYear()-1911)+'/'+(nextdate.getMonth()<9?'0':'')+(nextdate.getMonth()+1);
						$('#txtMon').val(t_date);
					}
				}
								
				//檢查合約是否存在或已結案
				//105/11/08 互換合約再另外作業處理 維持抓cont
				var q1_weight=0,q2_weight=0;
				/*if((!emp($('#textQno1').val()) || !emp($('#textQno2').val()))){
					var t_where1 = "where=^^ 1=0 "+(!emp($('#textQno1').val())?" or noa='"+$('#textQno1').val()+"' ":'')+(!emp($('#textQno2').val())?" or noa='"+$('#textQno2').val()+"' ":'')+ " ^^";
					var t_where2 = "where=^^ 1=0 "+(!emp($('#textQno1').val())?" or noa='"+$('#textQno1').val()+"' ":'')+(!emp($('#textQno2').val())?" or noa='"+$('#textQno2').val()+"' ":'')+ " ^^";
					var t_where3 = "where=^^ 1=0 ^^";
					var t_where4 = "where=^^ 1=0 ^^";
					q_gt('cont_sf', t_where1+t_where2+t_where3+t_where4, 0, 0, 0, "cont_btnOk", r_accy,1);
					return;
				}*/
				if((!emp($('#textQno1').val()) || !emp($('#textQno2').val()))){
					var t_where = "where=^^ 1=0 "+(!emp($('#textQno1').val())?" or noa='"+$('#textQno1').val()+"' ":'')+(!emp($('#textQno2').val())?" or noa='"+$('#textQno2').val()+"' ":'')+ " ^^";
					q_gt('cont', t_where, 0, 0, 0, "cont_btnOk", r_accy,1);
					//105/11/08 互換合約再另外作業處理 維持抓cont
					var as = _q_appendData("cont", "", true);
					var qno1_exists=(emp($('#textQno1').val())?true:false);
					var qno2_exists=(emp($('#textQno2').val())?true:false);
					var qtgg1='',qtgg2='';
					for ( i = 0; i < as.length; i++) {
						if(as[i].noa==$('#textQno1').val()){
							qno1_exists=true;
							//q1_weight=dec(as[i].weight);
							q1_weight=dec(as[i].ordeweight);
							qtgg1=trim(as[i].tggno);
						}
						if(as[i].noa==$('#textQno2').val()){
							qno2_exists=true;
							//q2_weight=dec(as[i].weight);
							q2_weight=dec(as[i].ordeweight);
							qtgg2=trim(as[i].tggno);
						}
					}
					
					if (!qno1_exists || !qno2_exists) {
						var t_qno='';
						if(!qno1_exists)
							t_qno=$('#textQno1').val();
						if(!qno2_exists)
							t_qno=t_qno+(t_qno.length>0?',':'')+$('#textQno2').val();
						alert(t_qno+'合約號碼不存在!!');
						return;
					}else if((!emp($('#textQno1').val()) && qtgg1!=trim($('#txtTggno').val())) || (!emp($('#textQno2').val()) && qtgg2!=trim($('#txtTggno').val()))){
						alert('合約廠商與進貨廠商不同!!');
						return;
					}else{
						var t_where = "where=^^ (1=0 "+(!emp($('#textQno1').val())?" or charindex('"+$('#textQno1').val()+"',transtart)>0 ":'')+(!emp($('#textQno2').val())?" or charindex('"+$('#textQno2').val()+"',transtart)>0 ":'')+ ") ^^"; //and noa!='"+$('#txtNoa').val()+"'
						q_gt('view_rc2', t_where, 0, 0, 0, "cont_view_rc2", r_accy,1);
						var as = _q_appendData("view_rc2", "", true);
						for ( i = 0; i < as.length; i++) {
							if(as[i].noa!=$('#txtNoa').val()){
								var t_quat=as[i].transtart.split('##');
								if(t_quat[0]!=undefined){
									var r_quat=t_quat[0].split('@');
									if(r_quat[0]==$('#textQno1').val()){
										if(as[i].typea=='2'){
											q1_weight=q_add(q1_weight,dec(r_quat[1]));
										}else{
											q1_weight=q_sub(q1_weight,dec(r_quat[1]));
										}
									}
									if(r_quat[0]==$('#textQno2').val()){
										if(as[i].typea=='2'){
											q2_weight=q_add(q2_weight,dec(r_quat[1]));
										}else{
											q2_weight=q_sub(q2_weight,dec(r_quat[1]));
										}
									}
								}
								if(t_quat[1]!=undefined){
									var r_quat=t_quat[1].split('@');
									if(r_quat[0]==$('#textQno1').val()){
										if(as[i].typea=='2'){
											q1_weight=q_add(q1_weight,dec(r_quat[1]));
										}else{
											q1_weight=q_sub(q1_weight,dec(r_quat[1]));
										}
									}
									if(r_quat[0]==$('#textQno2').val()){
										if(as[i].typea=='2'){
											q2_weight=q_add(q2_weight,dec(r_quat[1]));
										}else{
											q2_weight=q_sub(q2_weight,dec(r_quat[1]));
										}
									}
								}
							}else{
								var t_quat=as[i].transtart.split('##');
								if(t_quat[0]!=undefined){
									var r_quat=t_quat[0].split('@');
									t_cont1=r_quat[0];
								}
								if(t_quat[1]!=undefined){
									var r_quat=t_quat[1].split('@');
									t_cont2=r_quat[0];
								}
							}
						}
						if((q1_weight>=dec($('#textQweight1').val()) && q2_weight>=dec($('#textQweight2').val())) || $('#cmbTypea').val()=='2' ){
							
						}else{
							var t_err='';
							if(q1_weight<dec($('#textQweight1').val()))
								t_err+='合約號碼【'+$('#textQno1').val()+'】合約剩餘重量'+FormatNumber(q1_weight)+'小於進貨重量'+FormatNumber($('#textQweight1').val());
							if(q2_weight<dec($('#textQweight2').val()))
								t_err+=(t_err.length>0?'\n':'')+'合約號碼【'+$('#textQno2').val()+'】合約剩餘重量'+FormatNumber(q2_weight)+'小於進貨重量'+FormatNumber($('#textQweight2').val());
							alert(t_err);
							return;
						}
						q1_weight=0,q2_weight=0;
					}
				}
					
				//檢查批號重覆
				//1051208 定尺批號一樣 定尺排除判斷
				for (var i = 0; i < q_bbsCount; i++) {
					if(!emp($('#txtProduct_' + i).val()) && $('#txtUcolor_'+i).val().indexOf('定尺')==-1
					&& $.trim($('#txtUno_' + i).val()).length > 0){
						for (var j = i + 1; j < q_bbsCount; j++) {
							if ($.trim($('#txtUno_' + i).val()) == $.trim($('#txtUno_' + j).val())
							&& $('#txtUcolor_'+j).val().indexOf('定尺')==-1
							) {
								alert('【' + $.trim($('#txtUno_' + i).val()) + '】批號重覆。\n' + (i + 1) + ', ' + (j + 1));
								return;
							}
						}
					}
				}
				
				//判斷批號是否已存在
				if(!check_uno){
					check_uno_count=0;check_uno_err='';
					for (var i = 0; i < q_bbsCount; i++) {
						if(!emp($('#txtUno_'+i).val())){
							q_func('qtxt.query.rc2checkuno_'+i, 'cuc_sf.txt,getuno,'+$('#txtUno_'+i).val()+';'+$('#txtNoa').val()+';#non'+';#non');
							check_uno_count++;
						}	
					}
					if(check_uno_count>0){
						return;
					}else{
						check_uno=true;
					}
				}
				
				//取得UNO
				//106/04/10 用手動的方式產生
				/*var needuno=false;
				for (var i = 0; i < q_bbsCount; i++) {
					if($('#txtStoreno_'+i).val().toUpperCase()=='A' && emp($('#txtUno_'+i).val()) && !emp($('#txtProduct_'+i).val()) && ($('#txtProduct_'+i).val().indexOf('鐵線')>-1 || $('#txtProduct_'+i).val().indexOf('鋼筋')>-1)){
						needuno=true;
					}
				}
				
				if(!getnewuno && needuno){
					q_func('qtxt.query.getnewuno', 'cuc_sf.txt,getnewuno,rc2;'+$('#txtNoa').val()+';'+q_getPara('sys.key_rc2')+';'+$('#txtDatea').val());
					return;
				}*/
				
				getnewuno=false;
				check_uno=false;
				
				$('#txtTranstart').val($('#textQno1').val()+'@'+dec($('#textQweight1').val())+'##'+$('#textQno2').val()+'@'+dec($('#textQweight2').val()));
				
				sum();
				
				//105/12/08空白倉庫預設A
				for (var i = 0; i < q_bbsCount; i++) {
					if(!emp($('#txtProduct_'+i).val()) && emp($('#txtStoreno_'+i).val())){
						$('#txtStoreno_'+i).val('A');
						$('#txtStore_'+i).val('三泰-板料');
					}
				}
				
				//106/12/18 判斷淨重與表身重量
				var tt_weight=0;
				for (var i = 0; i < q_bbsCount; i++) {
					tt_weight=q_add(tt_weight,dec($('#txtWeight_'+i).val()));
				}
				if(tt_weight!=dec($('#txtWeight').val())){
					alert('※表頭【淨重】與表身【重量】合計不同!!');
				}
				
				if (q_cur == 1)
					$('#txtWorker').val(r_name);
				if (q_cur == 2)
					$('#txtWorker2').val(r_name);
					
				var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
				if (s1.length == 0 || s1 == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_rc2') + $('#txtDatea').val(), '/', ''));
				else{
					if (q_cur == 1){
						t_where = "where=^^ noa='" + $('#txtNoa').val() + "'^^";
                    	q_gt('view_rc2', t_where, 0, 0, 0, "checkRc2no_btnOk", r_accy);
					}else{		
						wrServer(s1);
					}
				}
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)// 1-3
					return;
				q_box('rc2_sf_s.aspx', q_name + '_s', "500px", "520px", q_getMsg("popSeek"));
			}

			function cmbPaytype_chg() {
				var cmb = document.getElementById("combPaytype");
				if (!q_cur)
					cmb.value = '';
				else
					$('#txtPaytype').val(cmb.value);
				cmb.value = '';
			}

			function combAddr_chg() {
				if (q_cur == 1 || q_cur == 2) {
					$('#txtAddr2').val($('#combAddr').find("option:selected").text());
					$('#txtPost2').val($('#combAddr').find("option:selected").val());
				}
			}

			function bbsAssign() {
				for (var j = 0; j < (q_bbsCount == 0 ? 1 : q_bbsCount); j++) {
					if (!$('#btnMinus_' + j).hasClass('isAssign')) {
						$('#btnMinus_' + j).click(function() {
							btnMinus($(this).attr('id'));
						});
						
						$('#txtMount_' + j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if (q_cur == 1 || q_cur == 2){
								var t_weight=dec($('#txtWeight_' + b_seq).val());
								var t_mount=dec($('#txtMount_' + b_seq).val());
								var t_price=dec($('#txtPrice_' + b_seq).val());
								
								/*if($('#txtProduct_'+b_seq).val().indexOf('續接器')>-1 || $('#txtProduct_'+b_seq).val().indexOf('水泥方塊')>-1 || $('#txtProduct_'+b_seq).val()=='組裝工資')
									$('#txtTotal_' + b_seq).val(round(q_mul(t_price, t_mount), 0));
								else if($('#txtProduct_'+b_seq).val()=='運費' || $('#txtProduct_'+b_seq).val().substr(0,3)=='加工費'){
									//var sot_weight=0;
	                                //for (var i = 0; i < q_bbsCount; i++) {
	                                //    sot_weight=q_add(sot_weight,dec($('#txtWeight_'+i).val()));
	                                //}
	                                //$('#txtTotal_'+b_seq).val(round(q_mul(t_price,sot_weight),0));
									//106/07/11 楊小姐 加工費 會不同單價
									$('#txtTotal_'+b_seq).val(round(q_mul(t_price, t_weight), 0));
								}else{
									$('#txtTotal_'+b_seq).val(round(q_mul(t_price, t_weight), 0));
								}*/
								
								//106/07/20 根據品名的單位去計算 (*最後一次調整)
								var iskg=false;
								for(var i=0;i<tmpucc.length;i++){
									if($('#txtProduct_'+b_seq).val()==tmpucc[i].product){
										if(tmpucc[i].unit.toUpperCase()=='KG'){
											iskg=true;
										}
										break;
									}
								}
								if(iskg){
									$('#txtTotal_'+b_seq).val(round(q_mul(t_price, t_weight), 0));
								}else{
									$('#txtTotal_' + b_seq).val(round(q_mul(t_price, t_mount), 0));
								}
								sum();
							}
						});
						
						$('#txtWeight_' + j).change(function() {
							_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if (q_cur == 1 || q_cur == 2){
								var t_weight=dec($('#txtWeight_' + b_seq).val());
								var t_mount=dec($('#txtMount_' + b_seq).val());
								var t_price=dec($('#txtPrice_' + b_seq).val());
								
								/*if($('#txtProduct_'+b_seq).val().indexOf('續接器')>-1 || $('#txtProduct_'+b_seq).val().indexOf('水泥方塊')>-1 || $('#txtProduct_'+b_seq).val()=='組裝工資')
									$('#txtTotal_' + b_seq).val(round(q_mul(t_price, t_mount), 0));
								else if($('#txtProduct_'+b_seq).val()=='運費' || $('#txtProduct_'+b_seq).val().substr(0,3)=='加工費'){
									//var sot_weight=0;
	                                //for (var i = 0; i < q_bbsCount; i++) {
	                                //    sot_weight=q_add(sot_weight,dec($('#txtWeight_'+i).val()));
	                                //}
	                                //$('#txtTotal_'+b_seq).val(round(q_mul(t_price,sot_weight),0));
									//106/07/11 楊小姐 加工費 會不同單價
									$('#txtTotal_'+b_seq).val(round(q_mul(t_price, t_weight), 0));
								}else{
									$('#txtTotal_'+b_seq).val(round(q_mul(t_price, t_weight), 0));
								}*/
								
								//106/07/20 根據品名的單位去計算 (*最後一次調整)
								var iskg=false;
								for(var i=0;i<tmpucc.length;i++){
									if($('#txtProduct_'+b_seq).val()==tmpucc[i].product){
										if(tmpucc[i].unit.toUpperCase()=='KG'){
											iskg=true;
										}
										break;
									}
								}
								if(iskg){
									$('#txtTotal_'+b_seq).val(round(q_mul(t_price, t_weight), 0));
								}else{
									$('#txtTotal_' + b_seq).val(round(q_mul(t_price, t_mount), 0));
								}
								$('#txtWeight').change();
								sum();
							}
						});
						
						$('#txtPrice_' + j).change(function() {
							_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if (q_cur == 1 || q_cur == 2){
								var t_weight=dec($('#txtWeight_' + b_seq).val());
								var t_mount=dec($('#txtMount_' + b_seq).val());
								var t_price=dec($('#txtPrice_' + b_seq).val());
								
								var t_weight=dec($('#txtWeight_' + b_seq).val());
								var t_mount=dec($('#txtMount_' + b_seq).val());
								var t_price=dec($('#txtPrice_' + b_seq).val());
								
								/*if($('#txtProduct_'+b_seq).val().indexOf('續接器')>-1 || $('#txtProduct_'+b_seq).val().indexOf('水泥方塊')>-1 || $('#txtProduct_'+b_seq).val()=='組裝工資')
									$('#txtTotal_' + b_seq).val(round(q_mul(t_price, t_mount), 0));
								else if($('#txtProduct_'+b_seq).val()=='運費' || $('#txtProduct_'+b_seq).val().substr(0,3)=='加工費'){
									//var sot_weight=0;
	                                //for (var i = 0; i < q_bbsCount; i++) {
	                                //    sot_weight=q_add(sot_weight,dec($('#txtWeight_'+i).val()));
	                                //}
	                                //$('#txtTotal_'+b_seq).val(round(q_mul(t_price,sot_weight),0));
									//106/07/11 楊小姐 加工費 會不同單價
									$('#txtTotal_'+b_seq).val(round(q_mul(t_price, t_weight), 0));
								}else{
									$('#txtTotal_'+b_seq).val(round(q_mul(t_price, t_weight), 0));
								}*/
								
								//106/07/20 根據品名的單位去計算 (*最後一次調整)
								var iskg=false;
								for(var i=0;i<tmpucc.length;i++){
									if($('#txtProduct_'+b_seq).val()==tmpucc[i].product){
										if(tmpucc[i].unit.toUpperCase()=='KG'){
											iskg=true;
										}
										break;
									}
								}
								if(iskg){
									$('#txtTotal_'+b_seq).val(round(q_mul(t_price, t_weight), 0));
								}else{
									$('#txtTotal_' + b_seq).val(round(q_mul(t_price, t_mount), 0));
								}
								sum();
							}
						});
						
						$('#txtTotal_' + j).change(function() {
							sum();
						});
						
						$('#btnRecord_' + j).click(function() {
							var n = replaceAll($(this).attr('id'), 'btnRecord_', '');
							q_box("z_rc2record.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";tgg=" + $('#txtTggno').val() + "&product=" + $('#txtProductno_' + n).val() + ";" + r_accy, 'z_vccstp', "95%", "95%", q_getMsg('popPrint'));
						});
						
						$('#combUcolor_' + j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1 || q_cur==2)
								$('#txtUcolor_'+b_seq).val($('#combUcolor_'+b_seq).find("option:selected").text());
						});
						
						$('#combSpec_' + j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1 || q_cur==2)
								$('#txtSpec_'+b_seq).val($('#combSpec_'+b_seq).find("option:selected").text());
						});
						
						$('#combClass_' + j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1 || q_cur==2)
								$('#txtClass_'+b_seq).val($('#combClass_'+b_seq).find("option:selected").text());
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
								
								var t_weight=dec($('#txtWeight_' + b_seq).val());
								var t_mount=dec($('#txtMount_' + b_seq).val());
								var t_price=dec($('#txtPrice_' + b_seq).val());
								
								/*if($('#txtProduct_'+b_seq).val().indexOf('續接器')>-1 || $('#txtProduct_'+b_seq).val().indexOf('水泥方塊')>-1 || $('#txtProduct_'+b_seq).val()=='組裝工資')
									$('#txtTotal_' + b_seq).val(round(q_mul(t_price, t_mount), 0));
								else if($('#txtProduct_'+b_seq).val()=='運費' || $('#txtProduct_'+b_seq).val().substr(0,3)=='加工費'){
									//var sot_weight=0;
	                                //for (var i = 0; i < q_bbsCount; i++) {
	                                //    sot_weight=q_add(sot_weight,dec($('#txtWeight_'+i).val()));
	                                //}
	                                //$('#txtTotal_'+b_seq).val(round(q_mul(t_price,sot_weight),0));
									//106/07/11 楊小姐 加工費 會不同單價
									$('#txtTotal_'+b_seq).val(round(q_mul(t_price, t_weight), 0));
								}else{
									$('#txtTotal_'+b_seq).val(round(q_mul(t_price, t_weight), 0));
								}*/
								
								//106/07/20 根據品名的單位去計算 (*最後一次調整)
								var iskg=false;
								for(var i=0;i<tmpucc.length;i++){
									if($('#txtProduct_'+b_seq).val()==tmpucc[i].product){
										if(tmpucc[i].unit.toUpperCase()=='KG'){
											iskg=true;
										}
										break;
									}
								}
								if(iskg){
									$('#txtTotal_'+b_seq).val(round(q_mul(t_price, t_weight), 0));
								}else{
									$('#txtTotal_' + b_seq).val(round(q_mul(t_price, t_mount), 0));
								}
								sum();
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
								
								var t_weight=dec($('#txtWeight_' + b_seq).val());
								var t_mount=dec($('#txtMount_' + b_seq).val());
								var t_price=dec($('#txtPrice_' + b_seq).val());
								
								/*if($('#txtProduct_'+b_seq).val().indexOf('續接器')>-1 || $('#txtProduct_'+b_seq).val().indexOf('水泥方塊')>-1 || $('#txtProduct_'+b_seq).val()=='組裝工資')
									$('#txtTotal_' + b_seq).val(round(q_mul(t_price, t_mount), 0));
								else if($('#txtProduct_'+b_seq).val()=='運費' || $('#txtProduct_'+b_seq).val().substr(0,3)=='加工費'){
									//var sot_weight=0;
	                                //for (var i = 0; i < q_bbsCount; i++) {
	                                //    sot_weight=q_add(sot_weight,dec($('#txtWeight_'+i).val()));
	                                //}
	                                //$('#txtTotal_'+b_seq).val(round(q_mul(t_price,sot_weight),0));
									//106/07/11 楊小姐 加工費 會不同單價
									$('#txtTotal_'+b_seq).val(round(q_mul(t_price, t_weight), 0));
								}else{
									$('#txtTotal_'+b_seq).val(round(q_mul(t_price, t_weight), 0));
								}*/
								
								//106/07/20 根據品名的單位去計算 (*最後一次調整)
								var iskg=false;
								for(var i=0;i<tmpucc.length;i++){
									if($('#txtProduct_'+b_seq).val()==tmpucc[i].product){
										if(tmpucc[i].unit.toUpperCase()=='KG'){
											iskg=true;
										}
										break;
									}
								}
								if(iskg){
									$('#txtTotal_'+b_seq).val(round(q_mul(t_price, t_weight), 0));
								}else{
									$('#txtTotal_' + b_seq).val(round(q_mul(t_price, t_mount), 0));
								}
								sum();
							}
						});
						
						$('#txtSize_' + j).change(function() {
							 if ($(this).val().substr(0, 1) != '#')
                        		$(this).val('#' + $(this).val());
						});
						
						$('#txtUno_'+j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							var t_noa=$('#txtNoa').val();
							if(t_noa.length==0)
								t_noa='#non';
							if(!emp($('#txtUno_'+b_seq).val())){
								q_func('qtxt.query.rc2suno_'+b_seq, 'cuc_sf.txt,getuno,'+$('#txtUno_'+b_seq).val()+';'+t_noa+';#non'+';#non');
							}
						});
						
						$('#btnGenuno_'+j).click(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur!=1 && q_cur!=2 && emp($('#txtUno_'+b_seq).val()) && $('#txtStoreno_'+b_seq).val()=='A' && !emp($('#txtNoa').val()) && !emp($('#txtNoq_'+b_seq).val())){
								if(confirm("確定要產生批號?")){
									var t_ucolor=$('#txtUcolor_'+b_seq).val();
									if(t_ucolor.length==0){
										t_ucolor='#non';
									}
									q_func('qtxt.query.insertuno_'+b_seq, 'cuc_sf.txt,insert_uno,'
									+encodeURI(r_accy)+';'+encodeURI('rc2')+';'+encodeURI($('#txtNoa').val())+';'+encodeURI($('#txtNoq_'+b_seq).val())+';'
									+encodeURI(r_userno)+';'+encodeURI(r_name)+';'+encodeURI(t_ucolor));
								}
							}else{
								if(!emp($('#txtUno_'+b_seq).val())){
									alert('批號已存在!!')
								}
								if($('#txtStoreno_'+b_seq).val()!='A'){
									alert('進貨倉庫非【三泰-板料】!!')
								}
							}
						});
						$('#btnDeleuno_'+j).click(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur!=1 && q_cur!=2 && !emp($('#txtUno_'+b_seq).val()) && !emp($('#txtNoa').val()) && !emp($('#txtNoq_'+b_seq).val())){
								if(confirm("確定要刪除批號【"+$('#txtUno_'+b_seq).val()+"】?")){
									q_func('qtxt.query.deleuno_'+b_seq, 'cuc_sf.txt,dele_uno,'
									+encodeURI(r_accy)+';'+encodeURI('rc2')+';'+encodeURI($('#txtNoa').val())+';'+encodeURI($('#txtNoq_'+b_seq).val())+';'
									+encodeURI(r_userno)+';'+encodeURI(r_name)+';'+encodeURI($('#txtUno_'+b_seq).val()));
								}
							}else{
								if(emp($('#txtUno_'+b_seq).val())){
									alert('批號不存在!!')
								}
							}
						});
						
						/*$('#btnManu_'+j).click(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1 || q_cur==2){
								if($('#txtProduct_'+b_seq).val()=='加工費'){
									$('#txtWeight_'+b_seq).val(0);
									
									var t_price=dec($('#txtPrice_' + b_seq).val());
									var sot_weight=0;
	                                for (var i = 0; i < q_bbsCount; i++) {
	                                    sot_weight=q_add(sot_weight,dec($('#txtWeight_'+i).val()));
	                                }
	                                $('#txtTotal_'+b_seq).val(round(q_mul(t_price,sot_weight),0));
	                                sum();
								}
							}
						});*/
					}
				}
				_bbsAssign();
				refreshBbm();
				HiddenTreat();
				bbssum();
				
				$('#div_orde').hide();
				$('#lblNoq_s').text('項序');
				$('#lblProductno_s').text('品號');
				$('#lblProduct_s').text('品名');
				$('#lblUcolor_s').text('類別');
				$('#lblStyle_s').text('型');
				$('#lblSpec_s').text('材質');
				$('#lblSize_s').text('號數');
				$('#lblLengthb_s').text('米數');
				$('#lblClass_s').text('廠牌');
				$('#lblMount_s').text('數量(件)');
				$('#lblLengthc_s').text('支數');
				$('#lblWeight_s').text('重量(KG)');
				
				//105/02/01
				$('#btnStoreCopy').click(function() {
					if(q_cur==1 || q_cur==2){
                		if(!emp($('#txtStoreno_0').val())){
	                		for (var i = 1; i < q_bbsCount; i++) {
	                			if(emp($('#txtStoreno_'+i).val())){
	                				$('#txtStoreno_'+i).val($('#txtStoreno_0').val());
	                				$('#txtStore_'+i).val($('#txtStore_0').val());
	                			}
	                		}
                		}
                	}
				});
				$('#btnProductCopy').click(function() {
					if(q_cur==1 || q_cur==2){
                		if(!emp($('#txtProduct_0').val())){
	                		for (var i = 1; i < q_bbsCount; i++) {
	                			if(emp($('#txtProduct_'+i).val())){
	                				$('#txtProduct_'+i).val($('#txtProduct_0').val());
	                			}
	                		}
                		}
                	}
				});
				$('#btnUcolorCopy').click(function() {
					if(q_cur==1 || q_cur==2){
                		if(!emp($('#txtUcolor_0').val())){
	                		for (var i = 1; i < q_bbsCount; i++) {
	                			if(emp($('#txtUcolor_'+i).val())){
	                				$('#txtUcolor_'+i).val($('#txtUcolor_0').val());
	                			}
	                		}
                		}
                	}
				});
				$('#btnSpecCopy').click(function() {
					if(q_cur==1 || q_cur==2){
                		if(!emp($('#txtSpec_0').val())){
	                		for (var i = 1; i < q_bbsCount; i++) {
	                			if(emp($('#txtSpec_'+i).val())){
	                				$('#txtSpec_'+i).val($('#txtSpec_0').val());
	                			}
	                		}
                		}
                	}
				});
				$('#btnSizeCopy').click(function() {
					if(q_cur==1 || q_cur==2){
                		if(!emp($('#txtSize_0').val())){
	                		for (var i = 1; i < q_bbsCount; i++) {
	                			if(emp($('#txtSize_'+i).val())){
	                				$('#txtSize_'+i).val($('#txtSize_0').val());
	                			}
	                		}
                		}
                	}
				});
				$('#btnLengthbCopy').click(function() {
					if(q_cur==1 || q_cur==2){
                		if(!emp($('#txtLengthb_0').val())){
	                		for (var i = 1; i < q_bbsCount; i++) {
	                			if(emp($('#txtLengthb_'+i).val())){
	                				$('#txtLengthb_'+i).val($('#txtLengthb_0').val());
	                			}
	                		}
                		}
                	}
				});
				$('#btnClassCopy').click(function() {
					if(q_cur==1 || q_cur==2){
                		if(!emp($('#txtClass_0').val())){
	                		for (var i = 1; i < q_bbsCount; i++) {
	                			if(emp($('#txtClass_'+i).val())){
	                				$('#txtClass_'+i).val($('#txtClass_0').val());
	                			}
	                		}
                		}
                	}
				});
				
				if(q_cur==1 || q_cur==2){
					for (var j = 0; j < q_bbsCount; j++) {
						//chgcombSpec(j);
						//chgcombUcolor(j);
						//chgcombClass(j);
					}
				}
				
				for (var i = 0; i < brwCount2; i++) {
					if(!emp($('#vttranstart_'+i).text())){
						var t_quat=$('#vttranstart_'+i).text().split('##');
						if(t_quat[0]!=undefined){
							var r_quat=t_quat[0].split('@');
							if(r_quat[0]!=undefined)
								$('#vttranstart_'+i).text(r_quat[0]);
							else
								$('#vttranstart_'+i).text('');
						}
					}
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
			
			function bbssum() {
            	var sot_mount=0,sot_weight=0;
                for (var i = 0; i < q_bbsCount; i++) {
	                sot_mount=q_add(sot_mount,dec($('#txtMount_'+i).val()));
	                sot_weight=q_add(sot_weight,dec($('#txtWeight_'+i).val()));
				}
				if(sot_mount!=0)
					$('#lblSot_mount').text(FormatNumber(sot_mount));
				else
					$('#lblSot_mount').text('');
				if(sot_weight!=0){
					$('#lblSot_weight').text(FormatNumber(sot_weight));
				}else
					$('#lblSot_weight').text('');
					
				/*for (var i = 0; i < q_bbsCount; i++) {
					if((q_cur==1 || q_cur==2) && $('#txtProduct_'+i).val()=='加工費' && dec($('#txtPrice_'+i).val())!=0){
						$('#btnManu_'+i).show();
					}else{
						$('#btnManu_'+i).hide();
					}
				}*/
            }

			function btnIns() {
				_btnIns();
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
				$('#txtCno').val(z_cno);
				$('#txtAcomp').val(z_acomp);
				$('#txtDatea').val(q_date());
				$('#txtDatea').focus();
				$('#cmbTaxtype').val(1);
				//var t_where = "where=^^ 1=1 ^^";
				//q_gt('custaddr', t_where, 0, 0, 0, "");
			}

			function btnModi() {
				t_cont1=$('#textQno1').val();
				t_cont2=$('#textQno2').val();
				if (emp($('#txtNoa').val()))
					return;
				Lock(1, {
					opacity : 0
				});
				//取得車號下拉式選單
				var thisVal = $('#txtCardealno').val();
				var t_where = "where=^^ noa=N'" + thisVal + "' ^^";
				q_gt('cardeal', t_where, 0, 0, 0, "getCardealCarno");
				var t_where = " where=^^ rc2no='" + $('#txtNoa').val() + "' and paysale!=0 ^^";
				q_gt('pays', t_where, 0, 0, 0, 'btnModi', r_accy);
			}

			function btnPrint() {
				q_box("z_rc2p_sf.aspx?;;;noa=" + trim($('#txtNoa').val()) + ";" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['uno'] && !as['product'] && !dec(as['total'])) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				as['typea'] = abbm2['typea'];
				as['mon'] = abbm2['mon'];
				as['noa'] = abbm2['noa'];
				as['datea'] = abbm2['datea'];
				as['tggno'] = abbm2['tggno'];
				as['kind'] = abbm2['kind'];
				if (abbm2['storeno'])
					as['storeno'] = abbm2['storeno'];
				t_err = '';
				if (as['price'] != null && (dec(as['price']) > 99999999 || dec(as['price']) < -99999999))
					t_err = q_getMsg('msgPriceErr') + as['price'] + '\n';
				if (as['total'] != null && (dec(as['total']) > 999999999 || dec(as['total']) < -99999999))
					t_err = q_getMsg('msgMoneyErr') + as['total'] + '\n';
				if (t_err) {
					alert(t_err);
					return false;
				}
				return true;
			}

			function refresh(recno) {
				_refresh(recno);
				refreshBbm();
				HiddenTreat();
				$('#div_orde').hide();
				
				getnewuno=false;
				check_uno=false;
				
				$('.isPrint').prop('checked',true);
                $('.checkAll').prop('checked',true);
			}
			
			function checkAll(){
            	$('.isPrint').prop('checked',$('.checkAll').prop('checked'));
            }

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if (t_para) {
					$('#combAddr').attr('disabled', 'disabled');
					$('#btnUnoprint').removeAttr('disabled');
					for (var i = 0; i < q_bbsCount; i++) {
						$('#btnGenuno_'+i).removeAttr('disabled');
						$('#btnDeleuno_'+i).removeAttr('disabled');
					}
				} else {
					$('#combAddr').removeAttr('disabled');
					$('#btnUnoprint').attr('disabled', 'disabled');
					for (var i = 0; i < q_bbsCount; i++) {
						$('#btnGenuno_'+i).attr('disabled', 'disabled');
						$('#btnDeleuno_'+i).attr('disabled', 'disabled');
					}
				}
				
				//限制帳款月份的輸入 只有在備註的第一個字為*才能手動輸入
				if ($('#txtMemo').val().substr(0,1)=='*')
					$('#txtMon').removeAttr('readonly');
				else
					$('#txtMon').attr('readonly', 'readonly');
				refreshBbm();
				HiddenTreat();
			}

			function btnMinus(id) {
				_btnMinus(id);
				sum();
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
				if (q_tables == 's')
					bbsAssign();
			}

			function q_appendData(t_Table) {
				dataErr = !_q_appendData(t_Table);
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
				if (!emp($('#txtPart2').val())){
					alert('由互換進貨轉來禁止直接刪除!!');
					return;
				}
				
				t_cont1=$('#textQno1').val();
				t_cont2=$('#textQno2').val();
				Lock(1, {
					opacity : 0
				});
				var t_where = " where=^^ rc2no='" + $('#txtNoa').val() + "' and paysale!=0 ^^";
				q_gt('pays', t_where, 0, 0, 0, 'btnDele', r_accy);
			}

			function btnCancel() {
				_btnCancel();
				t_cont1='#non';
				t_cont2='#non';
			}

			function q_popPost(s1) {
				switch (s1) {
					case 'txtCardealno':
						//取得車號下拉式選單
						var thisVal = $('#txtCardealno').val();
						var t_where = "where=^^ noa=N'" + thisVal + "' ^^";
						q_gt('cardeal', t_where, 0, 0, 0, "getCardealCarno");
						break;
					case 'txtTggno':
						if (!emp($('#txtTggno').val())) {
							var t_where = "where=^^ noa='" + $('#txtTggno').val() + "' ^^ stop=100";
							q_gt('custaddr', t_where, 0, 0, 0, "");
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
			
			function q_funcPost(t_func, result) {
				switch(t_func) {
					//105/12/08  定尺批號一樣
					case 'qtxt.query.getnewuno':
						var as = _q_appendData("tmp0", "", true, true);
						if (as[0] != undefined) {
							var t_uno=as[0].uno;
							var t_noa=as[0].noa;
							var whilenum=0;
							if(t_noa!='' && ($('#txtNoa').val().length==0 || $('#txtNoa').val()=='AUTO'))
								$('#txtNoa').val(t_noa);
								
							//定尺
							for (var i = 0; i < q_bbsCount; i++) {
								if($('#txtStoreno_'+i).val().toUpperCase()=='A'){
									if(!emp($('#txtProduct_' + i).val()) && $('#txtUcolor_'+i).val().indexOf('定尺')>-1
									&& emp($('#txtUno_'+i).val())){
										if(t_noa!='' && ($('#txtNoa').val().length==0 || $('#txtNoa').val()=='AUTO'))
											$('#txtUno_'+i).val(t_noa);
										else
											$('#txtUno_'+i).val($('#txtNoa').val());
									}
								}
							}
							
							if(t_uno!=''){
								//檢查是否與表身重覆
								while(1==1 && whilenum<q_bbsCount*q_bbsCount) //避免無窮迴圈
								{
									var isnoexists=true,needuno=false;
									for (var i = 0; i < q_bbsCount; i++) {
										if(!emp($('#txtUno_'+i).val())){
											if(t_uno==$('#txtUno_'+i).val()){
												isnoexists=false;
											}
										}
										if(emp($('#txtUno_'+i).val()) && !emp($('#txtProduct_'+i).val()) && ($('#txtProduct_'+i).val().indexOf('鐵線')>-1 || $('#txtProduct_'+i).val().indexOf('鋼筋')>-1)){
											needuno=true;
										}
									}
									if(!needuno){
										break;
									}
									if(isnoexists){
										for (var i = 0; i < q_bbsCount; i++) {
											if(emp($('#txtUno_'+i).val()) && !emp($('#txtProduct_'+i).val()) && ($('#txtProduct_'+i).val().indexOf('鐵線')>-1 || $('#txtProduct_'+i).val().indexOf('鋼筋')>-1)){
												$('#txtUno_'+i).val(t_uno);
												break;
											}
										}
									}
									t_uno=t_noa+'-'+('000'+(dec(t_uno.slice(-3))+1).toString()).slice(-3);
									whilenum++;
								}
							}
						}
						//不管有沒有批號都會存檔
						getnewuno=true;
	                	btnOk();
						break;
					case 'changecontgweight':
						break;
					case 'qtxt.query.rc2toorde':
						var as = _q_appendData("tmp0", "", true, true);
						if (as[0] != undefined) {
							if(as[0].t_err=='modi'){
								alert('訂單已更新!!');
							}
							if(as[0].t_err=='modi'){
								alert('訂單已產生!!');
							}
							$('#txtOrdeno').val(as[0].ordeno);
							abbm[q_recno]['ordeno']=as[0].ordeno;
						}else{
							alert('訂單產生錯誤!!');
						}
						
						$('#btnOk_div_orde').removeAttr('disabled').val('轉訂單');
						$('#div_orde').hide();
						break;
				}
				if(t_func.indexOf('qtxt.query.rc2suno_')>-1){
					var n=t_func.split('_')[1];
                	var as = _q_appendData("tmp0", "", true, true);
                	if (as[0] != undefined) {
                		alert("批號【"+as[0].uno+"】已存在!!");
                		$('#btnMinus_'+n).click();
                	}
				}
				if(t_func.indexOf('qtxt.query.rc2checkuno_')>-1){
					var n=t_func.split('_')[1];
                	var as = _q_appendData("tmp0", "", true, true);
                	if (as[0] != undefined) {
                		if(as[0].noa!=$('#txtNoa').val())
                			check_uno_err=check_uno_err+'批號【'+as[0].uno+'】已被使用\n';
                	}
                	
                	check_uno_count--;
                	if(check_uno_count==0){
	                	if(check_uno_err.length>0){
	                		alert(check_uno_err);
	                	}else{
	                		check_uno=true;
	                		btnOk();
	                	}
                	}
				}
				
				if(t_func.indexOf('qtxt.query.insertuno_')>-1){
					var n=t_func.split('_')[1];
                	var as = _q_appendData("tmp0", "", true, true);
                	if (as[0] != undefined) {
                		if(as[0].terr.length>0){
                			alert(as[0].terr);
                		}else{
                			if($('#txtNoa').val()==as[0].noa && $('#txtNoq_'+n).val()==as[0].noq){
                				$('#txtUno_'+n).val(as[0].uno);
                				for (var j = 0; j < abbs.length; j++) {
									if (abbs[j]['noa'] == as[0].noa && abbs[j]['noq'] == as[0].noq) {
	                                    abbs[j]['uno'] = as[0].uno;
	                                    break;
	                                }
	                            }
                			}else{
                				//重刷畫面
                				location.href=location.href;
                			}
                		}
                	}else{
                		alert('產生批號失敗!!')
                	}
				}
				
				if(t_func.indexOf('qtxt.query.deleuno_')>-1){
					var n=t_func.split('_')[1];
                	var as = _q_appendData("tmp0", "", true, true);
                	if (as[0] != undefined) {
                		if(as[0].terr.length>0){
                			alert(as[0].terr);
                		}else{
                			if($('#txtNoa').val()==as[0].noa && $('#txtNoq_'+n).val()==as[0].noq){
                				$('#txtUno_'+n).val('');
                				for (var j = 0; j < abbs.length; j++) {
									if (abbs[j]['noa'] == as[0].noa && abbs[j]['noq'] == as[0].noq) {
	                                    abbs[j]['uno'] = as[0].uno;
	                                    break;
	                                }
	                            }
                			}else{
                				//重刷畫面
                				location.href=location.href;
                			}
                		}
                	}else{
                		alert('刪除批號失敗!!')
                	}
				}
				
			}
		</script>
		<style type="text/css">
			#dmain {
				overflow: hidden;
			}
			.dview {
				float: left;
				width: 40%;
				border-width: 0px;
			}
			.tview {
				width: 100%;
				margin: 0;
				padding: 2px;
				border: 1px black double;
				border-spacing: 0;
				font-size: medium;
				background-color: #FFFF66;
				color: blue;
			}
			.tview td {
				padding: 2px;
				text-align: center;
				border: 1px black solid;
			}
			.dbbm {
				float: left;
				width: 60%;
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
			.tbbm .tdZ {
				width: 2%;
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
				font-size: medium;
			}
			.tbbm tr td .lbl.btn:hover {
				color: #FF8F19;
			}
			.txt.c1 {
				width: 98%;
				float: left;
			}
			.txt.c2 {
				width: 38%;
				float: left;
			}
			.txt.c3 {
				width: 60%;
				float: left;
			}
			.txt.c6 {
				width: 25%;
			}
			.txt.ime {
				ime-mode:disabled;
				-webkit-ime-mode: disabled;
				-moz-ime-mode:disabled;
				-o-ime-mode:disabled;
				-ms-ime-mode:disabled;
			}
			.txt.num {
				text-align: right;
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
			.tbbm select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				font-size: medium;
			}
			.tbbm td {
				width: 9%;
			}
			input[type="text"], input[type="button"] ,select{
				font-size: medium;
			}
			.dbbs .tbbs {
				margin: 0;
				padding: 2px;
				border: 2px lightgrey double;
				border-spacing: 1px;
				border-collapse: collapse;
				font-size: medium;
				color: blue;
				background: #cad3ff;
				width: 100%;
			}
			.dbbs .tbbs tr {
				height: 35px;
			}
			.dbbs .tbbs tr td {
				text-align: center;
				border: 2px lightgrey double;
			}

		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="overflow:hidden; width: 100%;">
			<div class="dview" id="dview">
				<table class="tview" id="tview" >
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:5%"><a id='vewTypea'> </a></td>
						<td align="center" style="width:20%"><a id='vewDatea'> </a></td>
						<td align="center" style="width:20%"><a id='vewNoa'> </a></td>
						<td align="center" style="width:30%"><a id='vewTgg'> </a></td>
						<td align="center" style="width:20%"><a id='vewQno1'>合約號碼</a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td align="center" id='typea=rc2.typea'>~typea=rc2.typea</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='tggno tgg,4' style="text-align: left;">~tggno ~tgg,4</td>
						<td align="center" id='transtart'>~transtart</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm" id="tbbm">
					<tr>
						<td><span> </span><a id='lblType' class="lbl"> </a></td>
						<td>
							<input id="txtType" type="text" style='display:none;'/>
							<select id="cmbTypea" class="txt c1"> </select>
						</td>
						<td><span> </span><a id='lblStype' class="lbl"> </a></td>
						<td><select id="cmbStype" class="txt c1"> </select></td>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1 ime"/></td>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAcomp' class="lbl btn"> </a></td>
						<td><input id="txtCno" type="text" class="txt c1"/></td>
						<td colspan="2"><input id="txtAcomp" type="text" class="txt c1"/></td>
						<td ><span> </span><a id='lblMon' class="lbl"> </a></td>
						<td><input id="txtMon" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblInvono' class="lbl btn"> </a></td>
						<td><input id="txtInvono" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTgg' class="lbl btn"> </a></td>
						<td><input id="txtTggno" type="text" class="txt c1" /></td>
						<td colspan="2"><input id="txtTgg" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblTel' class="lbl"> </a></td>
						<td><input id="txtTel" type="text" class="txt c1"/></td>
						<!--<td><span> </span><a id='lblOrdc' class="lbl btn"> </a></td>
						<td><input id="txtOrdcno" type="text" class="txt c1"/></td>-->
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr' class="lbl btn"> </a></td>
						<td><input id="txtPost" type="text" class="txt c1"/></td>
						<td colspan='4' ><input id="txtAddr" type="text" class="txt" style="width: 98%;"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr2' class="lbl btn"> </a></td>
						<td><input id="txtPost2" type="text" class="txt c1"/></td>
						<td colspan='4' >
							<input id="txtAddr2" type="text" class="txt" style="width: 95%;"/>
							<select id="combAddr" style="width: 20px" onchange='combAddr_chg()'> </select>
						</td>
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
						<td><span> </span><a id='lblPaytype' class="lbl"> </a></td>
						<td><input id="txtPaytype" type="text" class="txt c1"/></td>
						<td><select id="combPaytype" class="txt c1" onchange='cmbPaytype_chg()'> </select></td>
						<td><span> </span><a id='lblTrantype' class="lbl"> </a></td>
						<td colspan="2"><select id="cmbTrantype" class="txt c1"> </select></td>
						<td style="display: none;"><span> </span><a id='lblAccc' class="lbl btn"> </a></td>
						<td style="display: none;"><input id="txtAccno" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblPrice' class="lbl"> </a></td>
                        <td><input id="txtPrice" type="text" class="txt num c1"/></td>
					</tr>
					<tr>
					    <td><span> </span><a id='lblCarno' class="lbl btn"> </a></td>
                        <td>
                            <input id="txtCarno" type="text" class="txt" style="width:75%;"/>
                            <select id="combCarno" style="width: 20%;"> </select>
                        </td>
                        <td><!--<select id="cmbTranstyle" style="width: 100%;"> </select>--></td>
						<td><span> </span><a id='lblCardeal' class="lbl btn"> </a></td>
						<td><input id="txtCardealno" type="text" class="txt c1"/></td>
						<td><input id="txtCardeal" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblTranmoney' class="lbl"> </a></td>
						<td><input id="txtTranmoney" type="text" class="txt num c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMoney' class="lbl"> </a></td>
						<td colspan='2'>
							<input id="txtMoney" type="text" class="txt num c1" />
						</td>
						<td ><span> </span><a id='lblTax' class="lbl"> </a></td>
						<td colspan='2' >
							<input id="txtTax" type="text" class="txt num c1 istax" style="width: 49%;" />
							<!--<select id="cmbTaxtype" class="txt c1" style="width: 49%;" onchange="calTax();"> </select>-->
							<input id="chkAtax" type="checkbox" />
						</td>
						<td><span> </span><a id='lblTotal' class="lbl istax"> </a></td>
						<td><input id="txtTotal" type="text" class="txt num c1 istax" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan='7' >
							<input id="txtMemo" type="text" class="txt" style="width:98%;"/>
							<input id="txtTranstart" type="hidden"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblQno1" class="lbl btn">合約號碼</a></td>
						<td colspan='2'><input id="textQno1" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblQweight1" class="lbl">合約重量</a></td>
						<td colspan='2'><input id="textQweight1" type="text" class="txt num c1"  style="width:70%;"/>&nbsp; KG</td>
						<td style="display: none;"><span> </span><a id="lblMechno_sf" class="lbl">列印機台</a></td>
						<td style="display: none;"><select id="combMechno" class="txt c1"> </select></td>
					</tr>
					<tr style="display: none;">
						<td><span> </span><a id="lblQno2" class="lbl btn">合約2號碼</a></td>
						<td colspan='2'><input id="textQno2" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblQweight2" class="lbl">合約2重量</a></td>
						<td colspan='2'><input id="textQweight2" type="text" class="txt num c1" style="width:70%;"/>&nbsp; KG</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td colspan='2'><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td colspan='2'>
							<input id="txtWorker2" type="text" class="txt c1"/>
							<input id="txtPart2" type="hidden"/><!--由INA轉來的單子-->
						</td>
						<td colspan='2' style="text-align:center;display: none;"><input type="button" id="btnUnoprint" value="條碼列印" style="width:120px;"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' style="width: 1735px;"><!--2100px-->
			<table id="tbbs" class='tbbs' border="1" cellpadding='2' cellspacing='1' >
				<tr style='color:White; background:#003366;' >
					<td align="center" style="width:1%;"><input class="btn" id="btnPlus" type="button" value='＋' style="font-weight: bold;" /></td>
					<td align="center" style="width:35px;display: none;">列印<input class="checkAll" type="checkbox" onclick="checkAll()"/></td>
					<td align="center" style="width:50px;"><a id='lblNoq_s'> </a></td>
					<!--SF 106/08/17 取消批號入庫--->
					<td align="center" style="width:160px;display: none;"><a id='lblUno_s'> </a></td>
					<!--<td align="center" style="width:150px;"><a id='lblProductno_s'> </a></td>-->
					<td align="center" style="width:150px;">
						<a id='lblProduct_s'> </a>
						<input class="btn"  id="btnProductCopy" type="button" value='≡' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:160px;">
						<a id='lblUcolor_s'> </a>
						<input class="btn"  id="btnUcolorCopy" type="button" value='≡' style="font-weight: bold;"  />
					</td>
					<!--<td align="center" style="width:40px;"><a id='lblStyle_s'> </a></td>-->
					<td align="center" style="width:150px;">
						<a id='lblSpec_s'> </a>
						<input class="btn"  id="btnSpecCopy" type="button" value='≡' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:80px;">
						<a id='lblSize_s'> </a>
						<input class="btn"  id="btnSizeCopy" type="button" value='≡' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:80px;">
						<a id='lblLengthb_s'> </a>
						<input class="btn"  id="btnLengthbCopy" type="button" value='≡' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:100px;">
						<a id='lblClass_s'> </a>
						<input class="btn"  id="btnClassCopy" type="button" value='≡' style="font-weight: bold;"  />
					</td>
					<!--<td align="center" style="width:40px;"><a id='lblUnit_s'> </a></td>-->
					<td align="center" style="width:70px;"><a id='lblLengthc_s'> </a></td>
					<td align="center" style="width:75px;">
						<a id='lblMount_s'> </a>
						<BR><a id='lblSot_mount'> </a></td>
					<td align="center" style="width:90px;">
						<a id='lblWeight_s'> </a>
						<BR><a id='lblSot_weight'> </a></td>
					<td align="center" style="width:90px;"><a id='lblPrice_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblTotal_s'> </a></td>
					<td align="center" style="width:180px;">
						<a id='lblStore_s'> </a>
						<input class="btn"  id="btnStoreCopy" type="button" value='≡' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:180px;"><a id='lblMemo_s'> </a></td>
					<!--<td align="center" style="width:60px;"><a id='lblRecord_s'> </a></td>-->
				</tr>
				<tr style='background:#cad3ff;'>
					<td><input class="btn" id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
					<td align="center" style="display: none;"><input id="checkIsprint.*" class="isPrint" type="checkbox"/></td>
					<td><input id="txtNoq.*" type="text" class="txt c1"/></td>
					<td style="display: none;">
						<input id="txtUno.*" type="text" class="txt c1"/>
						<input id="btnGenuno.*" type="button" value="入庫"/>
						<input id="btnDeleuno.*" type="button" value="刪除"/>
					</td>
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
					<!--<td><input id="txtStyle.*" type="text" class="txt c1"/></td>-->
					<td>
						<input id="txtSpec.*" type="text" class="txt c1" style="width: 70%;"/>
						<select id="combSpec.*" class="txt" style="width: 20px;"> </select>
					</td>
					<td><input id="txtSize.*" type="text" class="txt c1" /></td>
					<td><input id="txtLengthb.*" type="text" class="txt num c1" /></td>
					<td>
						<input id="txtClass.*" type="text" class="txt c1" style="width: 60%;"/>
						<select id="combClass.*" class="txt" style="width: 20px;"> </select>
					</td>
					<!--<td><input id="txtUnit.*" type="text" class="txt c1"/></td>-->
					<td><input id="txtLengthc.*" type="text" class="txt num c1" /></td>
					<td><input id="txtMount.*" type="text" class="txt num c1" /></td>
					<td><input id="txtWeight.*" type="text" class="txt num c1" /></td>
					<td>
						<input id="txtPrice.*" type="text" class="txt num c1" />
						<!--<input id="btnManu.*" type="button" class="txt c1" value="加工費計算" style="width:85px;font-size: 14px;float: none;display:none;"/>-->
					</td>
					<td><input id="txtTotal.*" type="text" class="txt num c1" /></td>
					<td>
						<input id="txtStoreno.*" type="text" class="txt c1" style="width: 30%;"/>
						<input class="btn" id="btnStoreno.*" type="button" value='.' style=" font-weight: bold;float: left;" />
						<input id="txtStore.*" type="text" class="txt c1"  style="width: 50%;"/>
					</td>
					<td>
						<input id="txtMemo.*" type="text" class="txt c1"/>
						<!--<input id="txtOrdeno.*" type="text" class="txt" style="width:68%;" />
						<input id="txtNo2.*" type="text" class="txt" style="width:25%;" />-->
						<input id="recno.*" style="display:none;"/>
					</td>
					<!--<td align="center"><input class="btn" id="btnRecord.*" type="button" value='.' style=" font-weight: bold;" /></td>-->
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>